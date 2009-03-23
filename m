From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/8] docbook: radical style change
Date: Mon, 23 Mar 2009 12:47:19 +0200
Message-ID: <94a0d4530903230347h6cabe800k258547b6c8ce7689@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com>
	 <20090323065004.GC1119@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:49:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhiA-0000r8-4y
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbZCWKrY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 06:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbZCWKrY
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:47:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:39344 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbZCWKrW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 06:47:22 -0400
Received: by fg-out-1718.google.com with SMTP id 16so348593fgg.17
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v2htodhFQcpISodTmsSpfowysyps9nWnAyWNp+jlhBQ=;
        b=aSXS42n6S8vR0sLcmT4L4N7AQkzk8tMrOk2VbsQkS0F3aW+WypF24J53uu5ArlWkim
         Idq59USd4F88Pk21XhTtqp1sgklxdXaEJcAqiJq6/V7ZzBv9x6tFv0HUDKwhLCvknfff
         iW+ybJQBj4nGDh7juUDW3kJtzevy2iIf3kiyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Od7n57rr0WA8IQQrnGNOa+ieNoXMEq3xMmnGe01CpkZzQaT0o2gqZxLQu69swZgcjU
         /U9pw+OrfXGv34Qj8BABMX6lrLvDr2lMBXxf9izWqWzWdT4UiDktwUzaLgDRgKuPR0wp
         hVWRoHP5JS/k+gKMhFpSZlSq9bjok3FIUPk/8=
Received: by 10.86.79.19 with SMTP id c19mr3496071fgb.71.1237805239755; Mon, 
	23 Mar 2009 03:47:19 -0700 (PDT)
In-Reply-To: <20090323065004.GC1119@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114284>

On Mon, Mar 23, 2009 at 8:50 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 22, 2009 at 08:05:16PM +0200, Felipe Contreras wrote:
>
>> Use smaller 'sans-serial' font. Sans-Serial fonts are supposed to be
>> easier to read in screens. This format is similar to the one of
>> Wikipedia.
>
> I started to look up "sans-serial" before I realized it seems to be j=
ust
> a typo for "sans-serif" (or is there something I'm missing)?

Right, I meant sans-serif.

> Is there a reason to apply this style change just to docbook-generate=
d
> HTML? Most of the HTML documentation is generated directly from
> asciidoc.

Nope, it's just the one I'm working right now.

>> =C2=A0html body {
>> =C2=A0 =C2=A0margin: 1em 5% 1em 5%;
>> - =C2=A0line-height: 1.2;
>> + =C2=A0line-height: 1em;
>> + =C2=A0font-family: sans-serif;
>> + =C2=A0font-size: small;
>
> Personally, I think collapsing the line spacing looks worse.
>
> I'm not sure I see the point of putting "small" text for the entire
> body. Since it covers the whole page, you are not "small" with respec=
t
> to anything else, but are basically just overriding the user's choice
> through their browser of what is a reasonable default text size.

Well, Google, Gmail and even Wikipedia have a 'small' font-size. I'm
sure people don't find Wikipedia hard to read :)

The only difference with the user manual is that it actually takes the
whole screen, so it might be difficult to follow such big lines with a
small font. I haven't made up my mind yet... I think a 'normal'
font-size also looks good.

--=20
=46elipe Contreras
