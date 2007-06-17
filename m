From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT vs. guilt: What's the difference?
Date: Sun, 17 Jun 2007 09:54:35 +0100
Message-ID: <b0943d9e0706170154v75603612qe85bbc4d8f2b2049@mail.gmail.com>
References: <4671B96A.1080202@midwinter.com>
	 <20070615030542.GA30110@diana.vm.bytemark.co.uk>
	 <tnx1wgds1pv.fsf@arm.com>
	 <20070615200139.GS6992@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070617035923.GI7025@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Yann Dirson" <ydirson@altern.org>,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Steven Grimm" <koreth@midwinter.com>, git <git@vger.kernel.org>
To: "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Sun Jun 17 10:54:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzqWu-0004by-S1
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 10:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859AbXFQIyh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 04:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754055AbXFQIyh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 04:54:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:31093 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbXFQIyg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 04:54:36 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1172429ugf
        for <git@vger.kernel.org>; Sun, 17 Jun 2007 01:54:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bBUODXj5HaauMTS0QgFOT9KRnd9G1G2Jd/gOEObWH8t3c/60wK66/DSaSAgCB/WonBYBKdiruYejiPKPokbvfI1t6rUvCkbyp7hW5t0wEf5AHdBmBjwGW188l7L/VBbxAUDeaKSpDiQWTM5x7Rk7yz+60X3ULN+ZPOwpGaPW+qY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lcjgYHeaLsLvYeI/KFzd4KijlD0Wyx6gr3GlMsap4WpPiGy8GiT00aDHxBHHcC6pE4Rcp2MTOBomar/9Mkrqgo7H1TxN29aFDmd5s4Ww+iqruQ6vL5/4f9DuGTG528KcCy/KZIOqDz6zrQZ5ROn2zLLCZKVzvy6Ao8Xg8uHuztI=
Received: by 10.67.93.7 with SMTP id v7mr4138604ugl.1182070475069;
        Sun, 17 Jun 2007 01:54:35 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Sun, 17 Jun 2007 01:54:35 -0700 (PDT)
In-Reply-To: <20070617035923.GI7025@filer.fsl.cs.sunysb.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50342>

On 17/06/07, Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> Then there is the psychological effect. If I have a directory full of
> patch(1) compatible diff files, I can forget about guilt and just use the
> diff files directly. With stgit's way of storing the patches, I'd assume
> things can get a bit harder if you just want to give up on stgit.

I do this a lot to refine patches but I export the patch and re-import
it (I can even merge it with the old version using 'stg fold
--threeway' and it will prompt me for the differences via xxdiff or
emacs).

> Btw, does git-prune & friends do the right thing and not destroy the
> patch-related objects?

StGIT patches are git-prune safe. The commit ids are stored in
.git/refs/patches.

> > Well, people may not like python, but IMHO it is a lot easier to learn
> > it if you don't know it (that's what I did, although I did not start
> > from zero), than writing a robust and maintainable software of even
> > moderate complexity in shell script.  Shell script may be good for
> > prototyping or gluing tools in a simple way, but for advanced sofware
> > on which to rely to store my own data, it is just not really suited.
>
> So, why do you use git? ;)

Well, I guess he's mostly using StGIT which uses only the built-in GIT
commands written in C :-).

-- 
Catalin
