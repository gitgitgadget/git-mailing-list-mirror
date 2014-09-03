From: Mona Lisa Overdrive <mlisaoverdrive@gmail.com>
Subject: How To Make a Distribution Build
Date: Wed, 3 Sep 2014 08:53:24 -0500
Message-ID: <CADLC7KqnMLSja-MbhXG5ajePATuSkF4bNHPV20dNuX8NSwv30A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 15:53:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPB0J-0007LC-Gr
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 15:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbaICNxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 09:53:25 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:48871 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431AbaICNxY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 09:53:24 -0400
Received: by mail-oi0-f42.google.com with SMTP id v63so5527374oia.15
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=DYfbsyBaOqOqCB5vG9k/MjbuAn/96AVaFJBHEGkjNBY=;
        b=N4ysZwdeCgSjvOP/5gr3pox46WKeMBJ4O8niIKf7IjbpFVwn/vgHtF38DzCvSBQ7W6
         8HvzLy+P3qgmvADRgz+8Ja/PignkNPpvf1SVMwKTrtmi4le4iI5uo6U5nyesRIYtKVpc
         gplrXGDrXOF/wALbwOpX/bDXZ8gLBbVVkvTr6Ffp1fR+6UJmL65E2gzhxZ2+JwF0uh1m
         vRHGXosKYvMbSEmGXDrJtLcjEtoSxaVSwSRudef+WoUWC6vrYmQ5bn90kBYmd2O5vS+y
         f/a7YqA7mKN6O+XPLO6u8thZ/QTHmXht5VCIlsX6HIHExLJesH2gZHWeWrmdDMYtVCsQ
         9Mog==
X-Received: by 10.60.150.243 with SMTP id ul19mr2896233oeb.70.1409752404130;
 Wed, 03 Sep 2014 06:53:24 -0700 (PDT)
Received: by 10.76.92.38 with HTTP; Wed, 3 Sep 2014 06:53:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256390>

Hello,
I just finished building and installing git on my Android device.
After testing, I'd like to build it in such a way that I can tarball
and upload/send it.  Are there any make targets that would allow me to
do that or do I need to rebuild with the NO_CROSS_DIRECTORY_HARDLINKS
option and install to a stage directory...like /usr/git or
/usr/local/git?

Many thanks in advance.

MLO

PS: I'm somewhat new to linux-based systems in general and the make
system in particular; obvious follow-up questions may be asked
