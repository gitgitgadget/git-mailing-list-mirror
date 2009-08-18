From: Frank Li <lznuaa@gmail.com>
Subject: Re: [msysGit] Re: [PATCH 02/11] Fix declare variable at mid of 
	function
Date: Wed, 19 Aug 2009 00:11:48 +0800
Message-ID: <1976ea660908180911m7469ac20w48a28b90262d25f6@mail.gmail.com>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
	 <1250524872-5148-2-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302>
	 <3f4fd2640908170934w4c48ada1o66745f845ecb7d49@mail.gmail.com>
	 <alpine.DEB.1.00.0908172134150.8306@pacific.mpi-cbg.de>
	 <4A8A3ADE.9010703@gmail.com>
	 <alpine.DEB.1.00.0908181132470.4680@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:11:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRHw-0001zd-Gc
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758620AbZHRQLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758576AbZHRQLr
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:11:47 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:42364 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbZHRQLr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:11:47 -0400
Received: by qyk34 with SMTP id 34so2799210qyk.33
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lAzVkzDgkavkYTNlg00AkQ6eDqUC4nvrxgj5zsBOfCc=;
        b=Bxst06FrT8ecJEwrxu7UrTWNSnU1T/6lGw/l8yND+vunWpL/S93y70H3fElPhKalcB
         Lzgl01bIvi0Y0Wyv/gOtGlOm7P69I2APumxc5LhLlAcM2LZsR5FYzOJCojASpFi7cnOH
         yBEyMD0F5W731Cj7AsRbGtwlFpvqQRG12qeaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PCtQz6hWweVOeHZcyFIrr96MklsOS6twiZ0ryJzefSHuBAZ/gYKBOsD+4sDJeAEwcE
         a+bAaPs2ap315zA3MenBHtdGNkPnUqn9yVDw0JYtauNbQ9E7ViW/yxxYgSt9e/9qGnSN
         57S+1WInw6Od3/QGPYyH83Zq5jok24KpbrRBk=
Received: by 10.224.4.21 with SMTP id 21mr5629824qap.155.1250611908333; Tue, 
	18 Aug 2009 09:11:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908181132470.4680@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126407>

> Okay, I will wait for Frank's updates (just fetched tgit.git and it still
> contains the old branch), merge the early part and add the compiler flags.
>
Today, I just update 5 patch according review feedback.
Do I need send it again?

I have push my change to tgit
git://repo.or.cz/tgit.git
branch vcpatch2

How do I know if patch has been applied main line?
