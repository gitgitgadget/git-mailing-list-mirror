From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: trailling whitespace with git am ?
Date: Fri, 14 Aug 2009 22:10:09 +0200
Message-ID: <81b0412b0908141310x7e4acf4fgf4ea71cf53de6eea@mail.gmail.com>
References: <606CC410B038E34CB97646A32D0EC0BF0181FAB4@venusbis.synchrotron-soleil.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?PICCA_Fr=C3=A9d=C3=A9ric=2DEmmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc36g-0000As-3G
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 22:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbZHNUKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 16:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932776AbZHNUKM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 16:10:12 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:47530 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932777AbZHNUKJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 16:10:09 -0400
Received: by fxm11 with SMTP id 11so1368354fxm.39
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 13:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xc2Bu451BwcqA/Kul8ErNNQB9voXsvLw5h9sOroxcJk=;
        b=F/zKfXeWIeJLA8cSrz+BuFYacsQPbx0ryowuNWlbe+ruFsX0jIi7HVYa+/hKx9h7Aa
         7PC2LUKkF3bBBSAL0e/pLE7WffKiFmTcmDXLaQMn2oU5DFErWPEsm8+NhmMP6ZKjsKVY
         kubuDlKfFRKoDtg04o1gFRDUDmnXlV4J2Mt1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i92LmF6O/0FzwSnD/0zuab05HBvycLVscRCRKpmsdpjvIpUfoOPeVXBEK+C0TSx7Oa
         +/vrceygDd1hVrP9FMwVHZpGxqGc11nas7dxWVYZbVIyAkgmjmXU+bfeI/g/0AdWNyzh
         sXm5ZUzgYTxBdg7UnGrBEe0UCip4Ff0pfHbX4=
Received: by 10.204.57.19 with SMTP id a19mr1324951bkh.194.1250280609631; Fri, 
	14 Aug 2009 13:10:09 -0700 (PDT)
In-Reply-To: <606CC410B038E34CB97646A32D0EC0BF0181FAB4@venusbis.synchrotron-soleil.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125944>

2009/8/14 PICCA Fr=C3=A9d=C3=A9ric-Emmanuel
<frederic-emmanuel.picca@synchrotron-soleil.fr>:
> mordor% git am /home/picca/Projets/patches/0001-Add-the-POGO-TO-DELET=
E-comment-to-ComputedAnglesClea.patch
> Applying: 'Add the POGO TO DELETE comment to ComputedAnglesClear comm=
and'
> /tmp/diffractometer/.git/rebase-apply/patch:13: trailing whitespace.
>
> /tmp/diffractometer/.git/rebase-apply/patch:14: trailing whitespace.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* POGO TO DELETE */
> error: patch failed: src/Diffractometer/Diffractometer.cpp:2023
> error: src/Diffractometer/Diffractometer.cpp: patch does not apply

This patch has DOS line endings (like CR, followed by LF).

You can either use dos2unix (or your editor of choice), or update your =
git
to current master branch, where "git am" handles such patches transpare=
ntly.
