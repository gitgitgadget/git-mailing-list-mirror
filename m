From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Mon, 16 Apr 2007 23:06:45 +0700
Message-ID: <fcaeb9bf0704160906m3a2ffe60gf28570be1014403e@mail.gmail.com>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
	 <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com>
	 <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org>
	 <200704152051.35639.andyparkins@gmail.com>
	 <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
	 <20070416021729.GH2689@curie-int.orbis-terrarum.net>
	 <20070416030103.GB27533@thunk.org>
	 <fcaeb9bf0704152023xaa119a4s8590452ff03befcf@mail.gmail.com>
	 <Pine.LNX.4.64.0704160805280.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Andy Parkins" <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:06:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdTj9-0007mU-41
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030803AbXDPQGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030810AbXDPQGr
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:06:47 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:64041 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030811AbXDPQGq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 12:06:46 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1247400nze
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 09:06:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wl0y7TJPxSXnmyaKMK9hN2CGd8+iQigJ5ssFkMQkr5b2rsmc2fQ36ldfwZC4ap3K8d6PlfeJSl5W66zS8w+WsYvE2cEYfDFidAsUtR8B9lvJ7gw8yXtAxTKEdII1QKob4t8rS3edyAAOBmfzPXOT9mIBTXMHwZ02XUdF1mEsV9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VrnXjuvk5NYUMuIil+8RGY5Ja8GPVKpMlK23mP/Zh4vLKPiEkdqfOgmwAzG/kIO88d374lQVzLseop9qv/CBIBPABLbToTh1ckQzXyOewKmKastTgCFFwSFHmnaZHRycw3cApyL+hfNRbJTCZ3U6tSFViCK93VCchwLYJy6Yzl4=
Received: by 10.115.32.1 with SMTP id k1mr1963868waj.1176739605596;
        Mon, 16 Apr 2007 09:06:45 -0700 (PDT)
Received: by 10.114.66.6 with HTTP; Mon, 16 Apr 2007 09:06:45 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704160805280.5473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44655>

On 4/16/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Mon, 16 Apr 2007, Nguyen Thai Ngoc Duy wrote:
> >
> > Changing Gentoo release process won't make Git the best choice while
> > other SCM candidates can provide the same functionalities that Gentoo
> > needs without changing the process.
>
> Ahh, the old "argument by blackmail" approach.
>
> You know what? Nobody really cares. Arguing by blackmail ("we'll use
> something else then") just means that you should go somewhere else. If you
> cannot respond intelligently to intelligent arguments, you really *are*
> better off using SVN.

All right. I didn't mean to blackmail you or any Git developer. What I
wanted to say is that Gentoo is currently using an old, brain-damaged
SCM called CVS. I would like it to use Git but Git in its current
state can not fully replace CVS regarding to Gentoo usage. To do that
Gentoo needs some changes itself but Gentoo repositories are big ones
and it's just hard to change such beast s from bottom up. So I would
like to see a compromise from Git (which, I think, does not harm other
projects from using Git) to ease the migration.

>
> A billion flies aren't exactly wrong: crap really *is* good. If you're a
> fly or a maggot.
>
> But if you ever actually want to be something *more* than a crap eater,
> come back then.
>

I would want to _slowly_ evolve from a crap eater to something better
because I couldn't become a non-crap eater in a flash :)

>                         Linus
>


-- 
Duy
