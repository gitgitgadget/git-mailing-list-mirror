From: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
Subject: [PATCH 0/2] git-config should not replace symlink
Date: Wed, 25 Jul 2007 12:49:51 -0400
Message-ID: <11853821932079-git-send-email-bradford.carl.smith@gmail.com>
References: <7vps2s2chy.fsf@assigned-by-dhcp.cox.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 18:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDk3r-0004AA-KO
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 18:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759456AbXGYQt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 12:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755682AbXGYQt5
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 12:49:57 -0400
Received: from ag-out-0708.google.com ([72.14.246.246]:34716 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783AbXGYQt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 12:49:56 -0400
Received: by ag-out-0708.google.com with SMTP id 35so2199451aga
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 09:49:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jJ4qDyWXNVq3E5NN3EoEpmwnyn3o0+EzYlwea+wD3y95zyxvvsk8JuwP9KFFimjyXbGPzV2xcL3IquHVYhoIe+tifzuTiOZnYiikQ1poT68w8noZuAzi9g++XFUCJfNBqvJtlVldnKCV33O7YWlZ57jv+LB2ahOpOcke6/7Cnwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LWnxtcrR47pibM+i6HlCYoXHx6qGgnU7PrtGM9qXdW1XFdeIEd35doyE95jgBMpJewS81SnJaslM1v8u9yv5J0HsbaKCqU+/RmgtZIGWW8didyZUKl3f5iueDUkHmXXuxAuSCSccseeyurVtlyvioFSXZWdF+NSn+pn+bPwGrUc=
Received: by 10.100.189.17 with SMTP id m17mr496118anf.1185382194910;
        Wed, 25 Jul 2007 09:49:54 -0700 (PDT)
Received: from localhost ( [160.36.232.47])
        by mx.google.com with ESMTPS id c27sm1208125ana.2007.07.25.09.49.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2007 09:49:54 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc2.30.g1c06-dirty
In-Reply-To: <7vps2s2chy.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53699>

These patches fix a problem that caused git-config to replace my
~/.gitconfig symlink with a real file.

[PATCH 1/2] resolve symlinks when creating lockfiles
[PATCH 2/2] use lockfile.c routines in git_commit_set_multivar()
