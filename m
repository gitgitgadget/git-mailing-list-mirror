From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: My git repo is broken, how to fix it ?
Date: Mon, 19 Mar 2007 19:32:26 +0600
Message-ID: <200703191932.26856.litvinov2004@gmail.com>
References: <200702281036.30539.litvinov2004@gmail.com> <200702281754.42383.litvinov2004@gmail.com> <Pine.LNX.4.64.0702280802150.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 14:32:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTHym-0001Ex-0D
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 14:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933907AbXCSNci convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Mar 2007 09:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933900AbXCSNci
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 09:32:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:64690 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933889AbXCSNch convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2007 09:32:37 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1314132uga
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 06:32:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ct09NtyPreMLzK5ddOALxGkcQ6FB8WILzsusbiUIgnZxXGY4gPwVmMBDjpsnTJTvaT7/Hk3MYCsJX0NMDMc6JUQJdeqhyl2ZTekWifPc3B3Qx7YBpL+Bxy9u42fx1rMT/UJojaPzPCcWnvLOihJD/MmTG1F/AdMpvgMBrHIavAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AZXj9ShxZo3vfgCD6VGedzGSbHvQstf7Mju9S08rxmUWfoUxrWYxc+rvWNN2qhGEPmGfsv1PM1ZaEIn9jpae5liauAXQTkl/b0ZZUgWyXjNa4lrEXgt3rKcXrmRfq4pDYW/Igqq+vIcXotKgtOu/ZaBQ8ppJ+wYw2McEhr1BVjU=
Received: by 10.66.244.10 with SMTP id r10mr9844378ugh.1174311155981;
        Mon, 19 Mar 2007 06:32:35 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id c1sm4930020ugf.2007.03.19.06.32.33;
        Mon, 19 Mar 2007 06:32:34 -0700 (PDT)
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.64.0702280802150.12485@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42617>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Wednesday 28 February 2007 22:19 Linus Torvalds =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BB(a):
> On Wed, 28 Feb 2007, Alexander Litvinov wrote:
> > Thanks for answer. I have found this blob in cloned repo. I just co=
py it
> > into objects subdir and repack repo again. fsck works without any e=
rrors.
>
> Good to hear.

Hello, its me again.

It is pity but my repo was corrupted again. I have WinXP + cygwin +=20
git-1.5.0-572-ge86d552. I was doing=20
git-apply/git-am/git-reset/git-cvsexportcommit and broke repo somehow. =
I have=20
two broken blobs that should be done by my recent patches.

Will try to recover them and report the result.

Is there any way to catch and solve the problem ?
Thanks for help.
