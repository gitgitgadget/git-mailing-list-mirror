From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: remote-bzr status
Date: Thu, 7 Oct 2010 23:27:13 +0200
Message-ID: <AANLkTi=qmTCX2+Ty5y3FZF5MoK2WrNGFu3Z8rEHv4CzG@mail.gmail.com>
References: <4CA8F2F1.5090407@gmail.com> <20101004061104.GH24884@burratino>
 <4CAA16F8.4050705@gmail.com> <AANLkTin_ziCLfsHOeqwzCSaAGWwxwUPi=1=4Hdhz7uSk@mail.gmail.com>
 <4CABCFDD.4050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 23:27:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3y03-0007rS-Q7
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 23:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459Ab0JGV1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 17:27:35 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37403 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0JGV1e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 17:27:34 -0400
Received: by ywh1 with SMTP id 1so123987ywh.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=AP34IRdv6Nn+w6hlEcOoazqO0IrSJmCXFBnb11vUXHo=;
        b=l8uKowg3Bp4GSC4cXHY61ai4dJGtCR9kW3WWIVwTbp8WJSdGHzFTQGA8pMn22Th3tk
         lQHmn/myCTSjgVFmDKrPBEPVczIekwJqbKZy8mdXmqbPG97+ZlmG08zM2QBPkFt9Ld3u
         EE0V5fwicUtMpaR06t1MtPfH06g1Uk+kJQWy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tjnEDOtZVJXubt2Ip3JeY7EcvciMYtgSUkd0z5Qgddcm7I9NPkUEqDgo7e58l7C+9X
         e0WchS4pC6qGUFNgNdHz1+HCv6ZsothM2Tw6yGVcE9jPosgj8D5SkfpvE/4g/wK0H/Xk
         QqgMYbL3GuebMXityGfUBVGtIncz1X7CWxW44=
Received: by 10.150.201.18 with SMTP id y18mr1836662ybf.329.1286486853600;
 Thu, 07 Oct 2010 14:27:33 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Thu, 7 Oct 2010 14:27:13 -0700 (PDT)
In-Reply-To: <4CABCFDD.4050902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158460>

Heya,

On Wed, Oct 6, 2010 at 03:24, Gabriel Filion <lelutin@gmail.com> wrote:
> I have written a test file that uses test-lib.sh. It is named
> t5801-remote-bzr.sh. I don't know if this name is right so I can correct
> it. I simply took the next sequential number after t5800-remote-helpers.sh.

I also have a t8501-remote-hg.sh, I suppose whoever is done first gets
8501 eh? Easy enough to resolve when the issue arises.

> I've created a clone of git.git [1] in which there's a 'remote-bzr'
> branch. I will be rebasing this branch on top of master and keeping it
> up to date with the other repo's content. (so most operations will be
> non-fastforward pushes)

That's how I've been working too (although I've thrown away the old history).

> Maintaining two repositories will add a little more work but it will
> make it easier for me to post a series on top of git for review and
> possible inclusion later.

You could just drop the non-git repo and work just with the git.git
fork (that's what I'm doing), whatever you're comfortable with though.

> So now, most of my work will be to try and fix bzr-fastimport. I tried
> to get in contact with current maintainers of the plugin via Bazaar's
> mailing list but was unsuccessful. I guess I should e-mail Jelmer
> Vernooij directly since he merged some code in not so long ago.

Yes, Jelmer is involved with the bzr fast-import/export stuff,
definitely contact him if you haven't already.

-- 
Cheers,

Sverre Rabbelier
