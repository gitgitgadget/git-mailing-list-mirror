From: Mitar <mmitar@gmail.com>
Subject: Re: post-fetch, tweak-fetch hook
Date: Mon, 7 May 2012 01:54:40 +0200
Message-ID: <CAKLmikNYewaRL3DUG9+NvpH3Y6sf=oJVdOo2DQSDw4vKH+Km-Q@mail.gmail.com>
References: <CAKLmikNaqVRb=pGUhbvVQTX2tYWT0HSS2R6Ezmico3X0rMgvYQ@mail.gmail.com>
	<201205062310.q46NAHnM022630@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Mon May 07 01:54:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRBHp-0006T0-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 01:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab2EFXyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 19:54:41 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63318 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754717Ab2EFXyk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 19:54:40 -0400
Received: by vcqp1 with SMTP id p1so3015004vcq.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kYUrh7o/MZceZctrnz2+kmzaKWb9yJ27tSs7vpMYFZo=;
        b=Oii5D11QFf7l0oxDzXMWU63r7O9/jOOxpfyxBNmhb19GhAlrd5tcpkOCYa9v2LoATG
         zNIDaz/TwtjlnjptUlystQZkC6pLaO5+l5MZlCpg8WFF3X2whoTwZ3PLzkT4dtcax58+
         7MsSr9UnhDjPOz+steuF7qdzvnBs3Du2ope5835CM2AyYcCG24Fyl8dV5TCEpHNISfwr
         o5sEgLvkx0elvrvSVVNL82LX6DG8Z8cfsqnfxeDHFGWepnwDp0DLqUiLImRSkQYUnW4d
         geyY9wzGxDMXRZL960xv1BUf472ycrY6w7Mph3tDJq3o4NAV6v1LB3r5IfJ5ygJIV8tQ
         OqNA==
Received: by 10.220.218.136 with SMTP id hq8mr8620714vcb.68.1336348480109;
 Sun, 06 May 2012 16:54:40 -0700 (PDT)
Received: by 10.52.28.13 with HTTP; Sun, 6 May 2012 16:54:40 -0700 (PDT)
In-Reply-To: <201205062310.q46NAHnM022630@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197223>

Hi!

Thank you for examples. They guide me in good direction. But still ...

On Mon, May 7, 2012 at 1:10 AM, Seth Robertson <in-gitvger@baka.org> wrote:
> I'm in favor of more git hooks myself, but there is a solution to your
> needs without it.

Of course there is a solution. Bash is turing-complete programming
language. But the question is how easy and fast it is to use
something.

> If you care about race conditions (and really, a lockfile(1) call can
> take care of that easily enough),

If git would support post-fetch hook, I would get this for free and
would not have to care about race conditions.

> then parse the output of fetch which will make it clear what *this* call did.

Yes, because it is really easy to parse it? There are so many
different things it can output and I am not sure how to find which one
should I take care of and which one should I ignore. Yes, I could
learn much more about git and all possible things which can happen
with fetch and its output, but I am trying to avoid this. Why? Because
I believe it should be much easier.

I am sorry if I look a bit negative, but I am quite frustrated that
for something so simple is so hard (in a time/knowledge meaning) to
achieve. Of course there is a way and that if you know all git command
this is maybe obvious, but why it couldn't be easier, if it is really
a very simple patch to make it easier (and it was already posted to
this mailing list few months ago).


Mitar
