From: Natanael Copa <natanael.copa@gmail.com>
Subject: Re: possible bug in using local branches
Date: Tue, 09 Oct 2007 13:07:08 +0200
Message-ID: <1191928028.10822.96.camel@nc.nor.wtbts.org>
References: <1191924707.10822.94.camel@nc.nor.wtbts.org>
	 <20071009105620.GD31659@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 13:07:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfCw8-0001DF-6F
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 13:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbXJILHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 07:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbXJILHP
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 07:07:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:59501 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbXJILHO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 07:07:14 -0400
Received: by ug-out-1314.google.com with SMTP id z38so69641ugc
        for <git@vger.kernel.org>; Tue, 09 Oct 2007 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=ebyqr/ei5r/tgGyWCRz5yOhO+CL5jhaRQU1u+kgPt0g=;
        b=Mpcx5Se+9V5zVPChckkk35+OqYkeUFNPk1pZndTtRKwNbVXR05RrXY2uYggQxWX4y3IsYwKLn7eH2y9+TV81d5lZp2VLJmlxOiv1xiniG88fSH5+PwVii/izKwD/PD9bIiMjeLPnCIzctiirbu+8hasHvxbYA2SouIPQYn+mTXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=S7LQnVVNnmbmZqA57HM7M2S/uvW+BgWo60ejA4ZdnKx3egVPmhPnOOhd4irdvx/gMDp6i8UKyLFt61Ou/2L+fyPhlLJCttennWZd8JkCC7U4aIihyILdeTQ+tFtRRi/G4iaShKakEmY1hlfov5t0YHFGjqJPvQQzLGE0cXeC4mY=
Received: by 10.66.252.18 with SMTP id z18mr679169ugh.1191928032695;
        Tue, 09 Oct 2007 04:07:12 -0700 (PDT)
Received: from ?192.168.65.211? ( [213.234.126.134])
        by mx.google.com with ESMTPS id i40sm425587ugf.2007.10.09.04.07.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Oct 2007 04:07:11 -0700 (PDT)
In-Reply-To: <20071009105620.GD31659@planck.djpig.de>
X-Mailer: Evolution 2.10.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60386>

On Tue, 2007-10-09 at 12:56 +0200, Frank Lichtenheld wrote:
> On Tue, Oct 09, 2007 at 12:11:47PM +0200, Natanael Copa wrote:
> > 
> > http://distfiles.gentoo.org/distfiles/linux-2.6.22.tar.bz2
> > http://distfiles.gentoo.org/distfiles/genpatches-2.6.22-9.base.tar.bz2
> > http://people.linux-vserver.org/~harry/patch-2.6.22.6-vs2.2.0.3-grsec2.1.11-20070905.diff
> > 
> > First unpack the linux-2.6.22.tar.bz2 archive, genpatches archive and
> > add linux kernel to a local repository.
> > 
> > $ tar -jxf linux-2.6.22.tar.bz2
> > $ tar -jxf genpatches-2.6.22-9.base.tar.bz2
> > $ cd linux-2.6.22
> > $ git-init
> > Initialized empty Git repository in .git/
> > $ git-add .
> > $ git commit -m 'vanilla 2.6.22'
> > ...
> >  create mode 100644 usr/Makefile
> >  create mode 100644 usr/gen_init_cpio.c
> >  create mode 100644 usr/initramfs_data.S
> 
> It already goes wrong here. The top-level .gitignore contains a
> vmlinux*, so the file you later test is never actually committed...

You saved my day! Thanks!

>
> Gruesse,

-nc
