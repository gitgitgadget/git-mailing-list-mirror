From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git add -u nonexistent-file
Date: Tue,  9 Feb 2010 17:30:47 -0500
Message-ID: <1265754650-25438-1-git-send-email-judge.packham@gmail.com>
References: <a038bef51002091417o1048c098x898517596115ed90@mail.gmail.com>
Cc: peff@peff.net, szeder@ira.uka.de, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 23:33:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeyeC-0002A3-1e
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 23:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685Ab0BIWdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 17:33:05 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53221 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab0BIWdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 17:33:03 -0500
Received: by vws12 with SMTP id 12so445535vws.19
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 14:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EaL9o4Clkzq8I4b/vLF8InJHssvAzsY5HXuiIpI8CiY=;
        b=malJMCkLOyf/lzSjRYWNmH5LzdDZsyQfbYaiJthwzOh+Im9NDoxafZ91EOSoXC3e8A
         BzUdUOFNaz0gz4+PdsmFAF0gsuxGYVXC0iJUsQqG8ztagwcGqwhKEHdHq/fDnyiCFLJU
         IdPCUuWPK/AZjm0N3LjFXzqDztwPd2Vfn9o3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AtVE7/u+pPqLaMEtME8+EKxaSJXUcPDR9lXZaQj8aDa6jcox0OOW9wTC5yDvCsG8I5
         vQtlh+LxEPULGFnuTc5b6HLUoPiY12/Hjcf8lnSzsZcVulG/G4f3wQq0CjTJYPgNtPNQ
         5Qpw3iRFafqb9iMidurOoLajEkQISCVSFFtTw=
Received: by 10.220.127.28 with SMTP id e28mr1010127vcs.132.1265754781390;
        Tue, 09 Feb 2010 14:33:01 -0800 (PST)
Received: from localhost.localdomain ([66.193.66.34])
        by mx.google.com with ESMTPS id 26sm4516876vws.21.2010.02.09.14.32.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 14:33:00 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <a038bef51002091417o1048c098x898517596115ed90@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139453>

Heres the up to date series with Junios fix and my test. The two test patches
could be squashed together if we want to change the order.
