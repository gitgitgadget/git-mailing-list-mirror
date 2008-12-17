From: "Mark Ryden" <markryde@gmail.com>
Subject: white spaces in a patch
Date: Wed, 17 Dec 2008 09:31:06 +0200
Message-ID: <dac45060812162331k19272488r4e95e0555e7a6db9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 08:32:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCqtT-0007EW-7z
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 08:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbYLQHbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 02:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbYLQHbJ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 02:31:09 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:29079 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbYLQHbI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 02:31:08 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1502076ywe.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 23:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=5avbCeUyxtKoU9i04YV2QNvNp9GoWWYzqlh/y+x8Elg=;
        b=bMpSlyWOD5bO9nL2MA4bOpvTbRX/yBoFH5+g18CN8WqZIV27M6+k60sZTALKIfdrMx
         TNwxbAIlox8QUI4vIt3TZr54Ya/5Th0iRNvLSGs70LS0NBwYnGeixaurrn8ci9NDYdwO
         0RInFGMsSpO3iGutCrl4LTxuM6hUDVacshnj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=JynLfts2kWnOLDXkm6aNhslPcQZqhn2wwclfCmKEfyZCajBF78EjQxzsR5q9aOgiuI
         MmXhpEWuWRAb9ENeeDLcNA4YYuirOx60YoweHsU3WV9tYnGXo2YZVuVY5SHkxEwvHUBM
         L+BqMZbzOYsGATFUZu1V7S9ayt+bVTMeLiOWc=
Received: by 10.90.53.4 with SMTP id b4mr181108aga.88.1229499066916;
        Tue, 16 Dec 2008 23:31:06 -0800 (PST)
Received: by 10.90.26.11 with HTTP; Tue, 16 Dec 2008 23:31:06 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103307>

Hello,

It occurred to me that I prepared some patch for a git tree, and
then when testing git-apply on it (on the original tree) I saw
some "white spaces" errors.
I know that I can run:
"git --whitespace=fix apply" on my patch and than create the patch
again ; in this way it will be created without white spaces.

Suppose I create a patch file (let's say : patch.txt)
1) Is there a way to check whether there are white spaces in this
file without running git-apply?
2) Is there a way to get some messages about that there are white spaces
when creating a git patch?

Regards,
Mark
