From: Cord Seele <cowose@googlemail.com>
Subject: [PATCH v2] git-send-email: allow filename expansion
Date: Fri, 30 Sep 2011 12:52:23 +0200
Message-ID: <1317379945-9355-1-git-send-email-cowose@gmail.com>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 30 12:52:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9aiA-00006m-RP
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 12:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483Ab1I3Kww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 06:52:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64021 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab1I3Kww (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 06:52:52 -0400
Received: by fxe4 with SMTP id 4so2767989fxe.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 03:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=m7fj5h8URX8vWubTomPFW59MApgZlVpHZr4KqvAQfN4=;
        b=mxgKowgKzcbrTgSJr08LoeRcMudpiXVmiQNYUD4CiSIBVJYepTi7O72PHnQuTlS0OD
         2z62VHCFJ1Z1Po8N0RZNaw2vs/gjxZmvUXAaBSmazStwN0P5naY5jWa/Gn160x6Hxwai
         4COb7W8XT6nEanWWzVjbztLo4PwClAWD4PuSI=
Received: by 10.223.59.137 with SMTP id l9mr18139096fah.15.1317379970824;
        Fri, 30 Sep 2011 03:52:50 -0700 (PDT)
Received: from localhost.localdomain (p4FF1B6BF.dip.t-dialin.net. [79.241.182.191])
        by mx.google.com with ESMTPS id u6sm6209486faf.3.2011.09.30.03.52.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Sep 2011 03:52:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.4
In-Reply-To: <vpqty7wk9km.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182477>

OK, here's another try to get it more Git-like.

Filename expansion now works as far as I can tell. But I failed actually
using my mutt aliases (but also with plain v1.7.6.4). Since I'm not
familiar with perl-debugging could please someone more experienced have a look?
Thanks.

-- Cord

[PATCH 1/2] Add Git::config_path()
[PATCH 2/2] use new Git::config_path() for aliasesfile
