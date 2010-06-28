From: Karl Stenerud <kstenerud@gmail.com>
Subject: notify alternative to auto gc?
Date: Mon, 28 Jun 2010 12:10:40 -0400
Message-ID: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 18:10:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTGv5-0001Zl-Nb
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 18:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab0F1QKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 12:10:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40114 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab0F1QKo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 12:10:44 -0400
Received: by vws5 with SMTP id 5so199881vws.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=RGkk3KD/1Czzz0GhY64V0xmJaCQyvdnRa5G6Ati7V1Y=;
        b=dd10rnGscwF6Llrgi2ONNzbuXUwX21iuxb+ada4URSjqez20yPQMwO4qD+z5n7x3Uh
         E1Y/JIloBmLio+EXG4SvZQ4c2f5dXwC1ukr1Ee+5paUoaMv5f4i0iCr2NMuRqVuycuxW
         BiL0hdX1VcxPxBCVuthzK2XUuqDltC+Ez4PhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=LOmDI0gLx8ISywdhdVMeNeRMvaDQcL8jfpdkvHfN0ie8I67U65qJprNMqvkKeCgCJF
         H9fIQrA1jhoUJHO0MNXM+5w4vc6ieYRx4dejLqDqyeZTcZnOMWSfIBVAsdfD1z2DdzZM
         luOrcoQqF5Nc5aClo3nmX/3GAkwEc3oZNIgac=
Received: by 10.224.108.69 with SMTP id e5mr3465645qap.215.1277741442097;
        Mon, 28 Jun 2010 09:10:42 -0700 (PDT)
Received: from [192.168.3.101] ([38.98.193.18])
        by mx.google.com with ESMTPS id t34sm24259454qcp.30.2010.06.28.09.10.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 09:10:41 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149835>

Hi,

As I did a git pull on my project today, git went into some kind of auto gc mode:

Auto packing the repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.
Counting objects: 4531, done.

This is, of course, quite an annoying feature since it could hit at any (inconvenient) time.

The git help tells me I can disable it by setting gc.auto to 0, while the mailing list archive tells me I also have to set gc.autopacklimit to 0.  This is fine, but if I do that, I won't know when the repo is in need of cleanup.  Is there any option I can set to instruct it to simply TELL me when it's in need of gc?
