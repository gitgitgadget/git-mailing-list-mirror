From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Tue, 24 Mar 2009 10:57:43 +0200
Message-ID: <94a0d4530903240157v2b9aa91dh4c731b77de9d7b58@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
	 <20090323064242.GB1119@coredump.intra.peff.net>
	 <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com>
	 <49C7A8AF.9080500@drmicha.warpmail.net>
	 <94a0d4530903231721i2a2a6fc1yf54d4303283ec415@mail.gmail.com>
	 <7vwsaf4qqx.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530903240052x2c6b882aub7de6d46e9949ddb@mail.gmail.com>
	 <20090324081846.GB660@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 09:59:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm2Tv-0005Qc-VR
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757481AbZCXI5s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 04:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755966AbZCXI5s
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:57:48 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:54555 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbZCXI5r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 04:57:47 -0400
Received: by bwz17 with SMTP id 17so2103310bwz.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wurbfI1SXHNwHuvXVb0FskCDnwbBajnR1nynu2oGX4M=;
        b=vnq8rnexmzL4wJGNKH91vn4CEemvEk0gRrqulKHyo2M4VMQzlKWgFwE7tvL5vWA6G1
         wyfHNrNgpt52QJORROPl7WymZaXakLIzWgNRa1x0uWeifttUspfNZdu5KB+Kl6Y0kx8J
         3Yw29fXcaOzOCeIbKFKdlLtkG/cXvvJSqccmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rOz/h7dpfV9+fpNQZ8SVyzgF3Zm0V+kCFUgtdzdZ9GszzfuX3Ej6cO4/SGTpleBgGC
         NcxdqW4KlLrYO2gHYdRXbTKptWJT6nWh3A+JHefYG5vEq8Gdzi0VyhzB6iptvR1nWGap
         znhupAg/v7CF9F7v3fggRdZtRPMZ8ZV4t3B5Q=
Received: by 10.86.33.10 with SMTP id g10mr4322232fgg.47.1237885063969; Tue, 
	24 Mar 2009 01:57:43 -0700 (PDT)
In-Reply-To: <20090324081846.GB660@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114430>

On Tue, Mar 24, 2009 at 10:18 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 24, 2009 at 09:52:33AM +0200, Felipe Contreras wrote:
>
>> > By the way, are you using a font that is a bit smaller than the bo=
dy text
>> > to render the examples? =C2=A0I find it harder to read.
>>
>> Why do people have problems reading small fonts? That's exactly the
>> same font-size you'll see on Wikipedia, Google, and many other sites=
:
>> 'small'. Do you have problems reading Wikipedia?
>
> Really? They look very different. Here's a screenshot of the user-man=
ual
> with patches 2 and 3 from your series applied, next to Wikipedia. You=
r
> text is smaller, and the line-spacing makes it look more scrunched:
>
> =C2=A0http://peff.net/wikipedia-git-textsize.png

Hmm, strange, can you tell me what is the configured font/font-size you=
 have?

Regarding the line-space I already changed that as you suggested:
file:///data/public/src/git/Documentation/user-manual.html

--=20
=46elipe Contreras
