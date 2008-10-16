From: "Ian Brown" <ianbrn@gmail.com>
Subject: git and filesystem problems (ext3 and vfat)
Date: Thu, 16 Oct 2008 18:03:30 +0200
Message-ID: <d0383f90810160903p6f8ffe77o86fdad5387f82481@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 18:05:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqVLC-0005fs-5L
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 18:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbYJPQDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 12:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbYJPQDd
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 12:03:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:33978 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbYJPQDc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 12:03:32 -0400
Received: by nf-out-0910.google.com with SMTP id d3so33060nfc.21
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=yE5bxKzw/su/NRIrx4Z2lvyQXj1VwADYQIbRdAme73E=;
        b=Yg8S8UCJ1ZrFcplXwo9hYWfLS09zNahrg5NqiHWczAd2fBeCBcTB0HRMo6E/V6fLGv
         sa+LmXcNAs+5L7idlP/vDzsy7uCeRtc1iFb/rdA58YO3KaJkgEWZ3wMqsp1ltbuMbs+y
         ZJSh09Xc2En8GKeiNimx+8YcmsE3eL8ixNHts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=eOpr4qLKT5cqG2n9dUhOhCN3T+NEFdSPGtDhm9U2xN32nV1Bnp6AJcAYpbALv9mLz2
         6x2t46d6yFQkg7qI3Xabvs04oEqOMirvQqK/y6HOuzklCBKCRXpcu/5EhAuUJbjJulhC
         TjXcqOnGPS6trlLAi6YOQ9L8Vzn7zCly5v6M8=
Received: by 10.86.95.8 with SMTP id s8mr2846876fgb.38.1224173010422;
        Thu, 16 Oct 2008 09:03:30 -0700 (PDT)
Received: by 10.86.27.16 with HTTP; Thu, 16 Oct 2008 09:03:30 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98394>

Hello, ]

 I have a diskOnKey which has a vfat filesystem.
I ran there:
git clone git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
the I copied all the wireless-2.6 folder to an ext3 partition.
There I ran git diff.

I get many messages like these (probably on all files of the repository):

diff --git a/COPYING b/COPYING
deleted file mode 100644
index ca442d3..0000000
--- a/COPYING
+++ /dev/null
@@ -1,356 +0,0 @@
-

and then all the lines of the file with "-" in the beginning, as if
they are empty.

Why is it so ?
Is there any way to overcome it ?
Must I run "git clone" on an ext3 DiskOnKey only ?

Regards,
Ian
