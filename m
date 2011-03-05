From: Miles Bader <miles@gnu.org>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sat, 5 Mar 2011 13:53:21 +0900
Message-ID: <AANLkTimX3n5PNdK9YpA92SQM7G-WAiC1aPP7qJ-UEudq@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
 <20110214231920.GA24814@elie> <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
 <20110227084317.GB3356@sigill.intra.peff.net> <1298820840.19827.69.camel@drew-northup.unet.maine.edu>
 <20110228230311.GA7533@sigill.intra.peff.net> <AANLkTi=LPqu9zDiAJpxqC=ZCLig+aCv5ztXw668ERtH7@mail.gmail.com>
 <op.vrnq8gk856e9f9@xman.eng.oslo.osa> <1298997963.5247.30.camel@drew-northup.unet.maine.edu>
 <AANLkTinAUsY-d3Ec6HpKbjzC+eUjGcq1LK5ODjxRC-yz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Drew Northup <drew.northup@maine.edu>,
	Alexey Feldgendler <alexeyf@opera.com>, git@vger.kernel.org,
	David <bouncingcats@gmail.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 05:54:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvjVJ-0003D8-M6
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 05:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab1CEEyE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 23:54:04 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65505 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab1CEEyD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 23:54:03 -0500
Received: by bwz15 with SMTP id 15so2599219bwz.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 20:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VFla0X4GEXOhPheF88gHTchyOhuPafM7+cFghLEEU9s=;
        b=G0qJR+SO+pXIjvLswoNSLVzP2+lO/5rxYmjiOilnTlXQA5EsGMUvT782S8WIYLysjK
         AeXeljKFzdLXoPSLNOGnN+xTgsGZDq1HC0cXs3X+o+3VTT9FTAgWzdIf5F9gsdQEaS8x
         lygS6itLHCztFMVhBubJVsyO9yGmvyDIgrHUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=Ytvo94gnViqBNJn296fxBjWDPIXvT0R08f5pc3k39fjGGW413jHIeKXXlU/9nyQYjp
         Ruge/olHsvmCx06AErQUHNrjUH1efARVOqQN8OBePLkTYZ9+fxfBwfYd4uUSzbMOPBg5
         4cENqQEPXkYrgxBvCsujsDU40K/D+QyO4EJo0=
Received: by 10.204.20.70 with SMTP id e6mr1244961bkb.145.1299300841092; Fri,
 04 Mar 2011 20:54:01 -0800 (PST)
Received: by 10.204.83.97 with HTTP; Fri, 4 Mar 2011 20:53:21 -0800 (PST)
In-Reply-To: <AANLkTinAUsY-d3Ec6HpKbjzC+eUjGcq1LK5ODjxRC-yz@mail.gmail.com>
X-Google-Sender-Auth: BulrZKy00BaaODmjbC9bHLDV8zk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168478>

2011/3/5 Felipe Contreras <felipe.contreras@gmail.com>:
> First I liked this proposal, but then I thought about 'git diff
> --preped' (doesn't really sound right). I think the term should:
>
> =A01) Have a nice noun version; staging area, preparation area
> =A02) Have a nice verb version; to stage, to prep
> =A03) Have a nice past-participle; staged, cached
>
> Casting? Forging? I don't know, staging always seems right.

I agree.

I don't why so many people seem to be trying so hard to come with
alternatives to "staged" and "staging area", when the latter are
actually quite good; so far all the suggestions have been much more
awkward and less intuitive.

It's true that "staging area" and "stage" as a verb are most intuitive
for native english speakers, but so far none of the alternatives
really seem any better for non-native speakers.  _All_ of these terms
are "learned" to some degree, and in that sense are arbitrary, but the
smoothness and intuitiveness of "staging area"/"stage" for english
speakers is a real plus I think.

As for translations, is it even an issue?  If term "XXX" is the
optimum term in some other language, then that should be the
translation for that langage, _regardless_ of what the english term
used is.

-miles

--=20
Cat is power. =A0Cat is peace.
