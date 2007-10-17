From: "Dan Zwell" <dzwell@gmail.com>
Subject: Re: revised: [PATCH] Color support added to git-add--interactive.
Date: Wed, 17 Oct 2007 02:57:46 -0500
Message-ID: <cff973550710170057i7a09eff6m5bd8268498774238@mail.gmail.com>
References: <471045DA.5050902@gmail.com>
	 <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
	 <20071013172745.GA2624@coredump.intra.peff.net>
	 <20071013175127.GA3183@coredump.intra.peff.net>
	 <47112491.8070309@gmail.com>
	 <20071015034338.GA4844@coredump.intra.peff.net>
	 <20071016194709.3c1cb3a8@danzwell.com>
	 <20071017015152.GN13801@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Wincent Colaiuta" <win@wincent.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Jonathan del Strother" <maillist@steelskies.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Frank Lichtenheld" <frank@lichtenheld.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:58:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii3mz-000479-1d
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 09:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbXJQH5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 03:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbXJQH5u
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 03:57:50 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:14770 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbXJQH5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 03:57:49 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1446190nze
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bMwdOPxQQWlTX4DWMvRfOAINJfV6KF/xQs2UOhUloYE=;
        b=aOCkf5XloAySPcOGub6WJ2oWBKjE5IF7SIpD5ABm9sRZwUg2gutLPhegzBuGLID2pSdNWbPMUhXKQw/CTF6w5UqFvGEZsbIRs91ODuRW7HleYt9hxjehgLCknI/huoK7C6FE0Q7NOVlc3ngEstHFDxwQGdHPhE1cA+ADXnlUbCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c5BGb5URiCO4K4VoqUeqvkQQk6oBBSML83tcWKJ+4PNkuJWGPNVQmsPTjl3gDdODmjY1ScEYVd9XHEh2RoRRBvVKMnrQ0CnL66J1oN1Rhr1vDlpcNXgCzhPyxwmdDHuZiBehvNEi93k1Xfh6+nwKic3UOjRYemNg3Hca2CBy6L0=
Received: by 10.142.49.4 with SMTP id w4mr2394137wfw.1192607866793;
        Wed, 17 Oct 2007 00:57:46 -0700 (PDT)
Received: by 10.142.216.17 with HTTP; Wed, 17 Oct 2007 00:57:46 -0700 (PDT)
In-Reply-To: <20071017015152.GN13801@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61351>

On 10/16/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Dan Zwell <dzwell@gmail.com> wrote:
> > Adds color to the prompts and output of git-add--interactive.
>
> I'm probbaly going to publish this in `pu` tonight but I have some
> comments that I think need to be addressed before this graduates
> any further.
>
> First off, no Signed-off-by?  This is big enough that I refuse to
> put it in the main tree without one.  Second it would really have
> helped if the email was formatted with `git format-patch`.  Copying
> the message headers and body over for the commit message was less
> than fun.  I have better things to do with my time.

Sorry, that I didn't read the document on submitting patches before
this. I will make the other changes you mention and re-send this in
the proper formatting.

>
> > +color.interactive.<slot>::
> > +        Use customized color for add--interactive output. `<slot>`
>
> You probably should talk about `git add --interactive` as that
> is what the git-add documentation calls it.  Many end-users don't
> even know that `git add -i` is exec()'ing into another program to
> accomplish its task.  I fixed this up when I applied the patch.
>
> > +Note: these are not the same colors/attributes that the
> > +rest of git supports, but are specific to git-add--interactive.
>
> This is a problem in my opinion.  Why can't it match the same
> names that the C code recognizes?  What if we one day were to
> see git-add--interactive.perl converted to C?  How would we then
> reconcile the color handling at that point in time?
Makes sense. I am adding a bit of code to parse git color strings into
perl color strings (so the user can use the same color names as with
the rest of git). I know this is a small change, but I'm learning perl
as I go, and I have exams this week, so it will take at least a day or
two. I will fix the color issue, and send a properly formatted and
signed-off patch. (Yes, I do agree to the Developer's Certificate of
Origin wrt to this patch.)

Thanks for your patience,
Dan

>
> --
> Shawn.
>
