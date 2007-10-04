From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: WIP: asciidoc replacement
Date: Thu, 4 Oct 2007 19:55:46 +1300
Message-ID: <46a038f90710032355t77c38d30p781743a6f248fab5@mail.gmail.com>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site>
	 <7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
	 <39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com>
	 <85abr0y5ua.fsf@lola.goethe.zz>
	 <1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com>
	 <7vd4vwfou9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Wincent Colaiuta" <win@wincent.com>,
	"David Kastrup" <dak@gnu.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 08:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdKco-0000G3-15
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 08:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbXJDGzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 02:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbXJDGzt
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 02:55:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:53396 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbXJDGzs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 02:55:48 -0400
Received: by ug-out-1314.google.com with SMTP id z38so273879ugc
        for <git@vger.kernel.org>; Wed, 03 Oct 2007 23:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=y4bQ83pCJuxM1DDO+h36zxXyi8QXoTYQe2l1cnkkSXg=;
        b=UQEz0BMWKyNIAdMhzltR9VETR/i3pJ5Hl3nwyI1vR6jJxHxqTJkNT8KuF92TD6LlL6pGedqdKmom55U6dzFfLp42McQmBc5DdptT4W3V5CnifRxLLD/vG5M3tZ0Kbt9xLKzRMBLiFADTMBNuzIqxb5uBweJY1vNAOvT4XYxx4VY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nw8ZCVQhahR3vuxU+p0Vs57jrTfvv2CIoTNA1lc6jtXPNvrHBTbpO39Lc3Y46150J54SJfvwTMgsnMEj5CrT3wXJog2/ACRu77bzkJhyJmIsWii0C7cQiuRs6aO3CZ9M0x9P2JXikuceZmqNCT4XAu1sXMopy1PPPIDm2L/7Dl4=
Received: by 10.67.19.13 with SMTP id w13mr1605964ugi.1191480946826;
        Wed, 03 Oct 2007 23:55:46 -0700 (PDT)
Received: by 10.67.23.15 with HTTP; Wed, 3 Oct 2007 23:55:46 -0700 (PDT)
In-Reply-To: <7vd4vwfou9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59922>

Junio,

great summary!

On 10/3/07, Junio C Hamano <gitster@pobox.com> wrote:
> One thing Linus had to say about the issue from early on, and I
> still agree with, is the last paragraph in:
>
>     http://article.gmane.org/gmane.comp.version-control.git/2298

I'm in complete agreement here...

...
> I've seen markdown used elsewhere, and I regularly read pod.
...
> How good are HTML and manpage output support from these (or
> other candidates) formats these days?  Output to help page
> format Windows folks use (I am assuming Mac people are happy as
> long as man is available) would be a definite plus.

And something that leads to PDF (perhaps via latex).

The problem I see here -- and that I've bumped into several times in
other projects -- is that readable & easy to edit text formats for the
source are key, and those can do most of what we need for
man/info/html outputs. But documentation formats that produce high
quality print output usually need  arcane formats _and_ a
high-maintenance toolchain.

With AsciiDoc we've managed to avoid the arcane format, but we are
still laden with a horrid toolchain. In that light, I actually like
what Johannes is doing, even though it's a timesink.

Do the other text based alternatives these days have a workable high
quality PDF/latex output format without pulling in brittle
dependencies like XSLT?

cheers


martin
