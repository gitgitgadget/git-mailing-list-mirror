From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Tue, 24 Mar 2009 09:52:33 +0200
Message-ID: <94a0d4530903240052x2c6b882aub7de6d46e9949ddb@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
	 <20090323064242.GB1119@coredump.intra.peff.net>
	 <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com>
	 <49C7A8AF.9080500@drmicha.warpmail.net>
	 <94a0d4530903231721i2a2a6fc1yf54d4303283ec415@mail.gmail.com>
	 <7vwsaf4qqx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 08:54:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1SZ-0003Lj-3s
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 08:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbZCXHwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 03:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753704AbZCXHwh
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 03:52:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:53614 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbZCXHwg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 03:52:36 -0400
Received: by fg-out-1718.google.com with SMTP id 16so501713fgg.17
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zLRnpO2URoS9ajmSbQELu4mMFNWTRw6FYYR/aMl1LFU=;
        b=RYN7txreNtJVx+QgTyw6nn0dhwJTMRZG3NRT2DQy49Of4diptEjBQVI+5DWmHlztmu
         1oKqEOmMw5aRrV6ncTqRMYeaRVD+b5EFhuDlNnM6KLtJns0Og7kGh9KkTXb486m8P/+p
         oRmsU+QyGWPRAYmCbrGfG/isdKGGmJEt4IPgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X83+njWGfOafjCSXRmYIyZmy8GJb1lxXjp4H+fsIXYXYFaT40vtUHJBseDGTAjdu/A
         M8ZajT3gADLRxnnOf8CPx0h7MQ0bCpozlnbdnlUfU9ZTN3SivYbT8ui3xo6VlOmXt92x
         0g/vq0zCaUEMVL317m4nOPGOWuKCl82W6Mbpg=
Received: by 10.86.70.3 with SMTP id s3mr4328308fga.65.1237881153351; Tue, 24 
	Mar 2009 00:52:33 -0700 (PDT)
In-Reply-To: <7vwsaf4qqx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114409>

On Tue, Mar 24, 2009 at 4:08 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Also, it seems that everything which is not black is blue, except f=
or
>>> terms, which are green and slanted. I don't think that looks nice
>>> together. How about slanted blue?
>>
>> What's wrong with having 2 colors?
>
> I personally also do not like pages that are too colorful. =C2=A0If y=
ou can
> convey the same information with smaller number of colors, please try=
 to
> do so. =C2=A0And remember that some people are colour-challenged.

1 more color makes a page 'too colorful'? Keep in mind that we already
are using 2 colors of blue, links by default have yet another color of
blue and visited links have a magenta color.

The color-challenged people would already see that text as italic,
there's no reason for the non-color-challenged people to _not_ take
advantage of being able to distinguish a different color. If you don't
like green, then fine, the other options are a) pick a different color
b) make the text bold.

I think bold is too distracting and a color that is a) hue-similar to
blue and b) closely dark to black, is the best choice: green.

> By the way, are you using a font that is a bit smaller than the body =
text
> to render the examples? =C2=A0I find it harder to read.

Why do people have problems reading small fonts? That's exactly the
same font-size you'll see on Wikipedia, Google, and many other sites:
'small'. Do you have problems reading Wikipedia?

But meh, I'll revert it.

> I thought that browsers typically have user control to let you set th=
e
> standard font size and choice independently for proportional, serif, =
sans
> and mono, and people who want to see typewriter face in smaller font =
would
> already have set their browser to do so (I don't do so myself because=
 I'd
> rather want to see them in uniform size). =C2=A0I haven't checked you=
r CSS, but
> if you are doing "monospace smaller than usual", aren't you effective=
ly
> (1) doing disservice to people like me, and (2) doing disservice to p=
eople
> who do want smaller monospace and configured their browser already (t=
he
> outcome would be doubly smaller, which may become too small)?

By that logic no web site should ever choose a different font-size
than 'normal', and of course they do.

--=20
=46elipe Contreras
