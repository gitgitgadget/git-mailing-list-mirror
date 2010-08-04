From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Wed, 4 Aug 2010 19:07:06 +0000
Message-ID: <AANLkTimRPnjeWQ7gXt90Kwx-fxQ_gwCd3vaKLY5-oPAu@mail.gmail.com>
References: <i372v0$3np$1@dough.gmane.org>
	<AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>
	<4C599781.2020603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Joel C. Salomon" <joelcsalomon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 21:07:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgjJB-0004Ou-9G
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 21:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933459Ab0HDTHN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 15:07:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56271 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933597Ab0HDTHK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Aug 2010 15:07:10 -0400
Received: by gyg10 with SMTP id 10so2115246gyg.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bs/mF5a5tNWrpDJkvEAlLxsd1y3Hq7kgGA+1HRQnxJM=;
        b=C8WaX6QzKXTvZ2sW2uJcTONPdoD3XkQuTlMGh3rRGBKukBbBw2UMDW+BnU1vgJtKEo
         ijavZrVyYN1zTSGVz/8Dyfi+e3rHWUjVHgkWbb07o8zRt01EIrWZ/ju4U8Dw6D3E9uS0
         NrDALOQSVIau6maOMl+G5Xa6hQM4c4xcLYMX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WzOYFV4oRjcSCwgDtQrsI0vHzNzOgrLZYHNhoBffVSEMrkzVHNSBTJ2/YTrTqbtXZV
         XOn80fpTfa4ULbCfNdc3FLhn67isCD8pVBigduIRr1vEgUubMEPDWi+k7AW+ySp1dtxA
         WpgnQx1cG6OwqxWLFmVrPlmvc+EZNZNG9KaWY=
Received: by 10.231.183.81 with SMTP id cf17mr10783042ibb.32.1280948828710; 
	Wed, 04 Aug 2010 12:07:08 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 4 Aug 2010 12:07:06 -0700 (PDT)
In-Reply-To: <4C599781.2020603@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152594>

On Wed, Aug 4, 2010 at 16:38, Joel C. Salomon <joelcsalomon@gmail.com> =
wrote:
> On 08/02/2010 05:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Aug 2, 2010 at 18:32, Joel C. Salomon <joelcsalomon@gmail.co=
m> wrote:
>>> I'd figured to play with Git in an unusual way: to create a reposit=
ory
>>> for the U.S. Constitution where amendments are presented as patches=
=2E
>>> E.g., instead of the First Amendment being placed at the end (as is
>>> usual) I'm putting it in Article 1, Section 9 (Limitations of Congr=
ess).
>>> Proposed amendments get branches, which get merged in later.
>>
>> I'd like to ask where this project is being hosted. I've wanted to
>> play with importing law into Git, and it would be interesting to
>> follow this project.
>
> It's local to my machine for now, especially since I can't (yet?) get
> the dates right. Also, I'm rebasing as I tweak the TeX code.
>
> Law-into-RCS has been on my mind since I learned out what RCSs are fo=
r.
> =C2=A0Read any bill that the US Congress passes: there's an intro, a =
whole
> lot of boilerplate, and then:
>
> SEC. 101. EXTENSION OF CHIP.
>
> =C2=A0 =C2=A0Section 2104(a) (42 U.S.C. 1397dd(a)) is amended--
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1) in paragraph (10), by st=
riking ``and'' at the end;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(2) by amending paragraph (1=
1), by striking ``each of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fiscal years 2008 and 2009'' and inserting=
 ``fiscal year
> =C2=A0 =C2=A0 =C2=A0 =C2=A02008''; and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(3) by adding at the end the=
 following new paragraphs:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0``(12) for fiscal year 2009,=
 $10,562,000,000;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0``(13) for fiscal year 2010,=
 $12,520,000,000;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0``(14) for fiscal year 2011,=
 $13,459,000,000;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0``(15) for fiscal year 2012,=
 $14,982,000,000; and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0``(16) for fiscal year 2013,=
 for purposes of making 2 semi-
> =C2=A0 =C2=A0 =C2=A0 =C2=A0annual allotments--
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
``(A) $3,000,000,000 for the period beginning on
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0October 1, 201=
2, and ending on March 31, 2013, and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
``(B) $3,000,000,000 for the period beginning on
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0April 1, 2013,=
 and ending on September 30, 2013.''.
>
> SEC. 102. ALLOTMENTS FOR STATES AND TERRITORIES FOR FISCAL YEARS 2009
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0THROUGH 2013.
>
> =C2=A0 =C2=A0Section 2104 (42 U.S.C. 1397dd) is amended--
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1) in subsection (b)(1), by=
 striking ``subsection (d)''
> =C2=A0 =C2=A0 =C2=A0 =C2=A0and inserting ``subsections (d) and (m)'';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(2) in subsection (c)(1), by=
 striking ``subsection (d)''
> =C2=A0 =C2=A0 =C2=A0 =C2=A0and inserting ``subsections (d) and (m)(4)=
''; and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(3) by adding at the end the=
 following new subsection:
> ....
>
> Sure looks like a patch series to me.

Yeah, I think every legal system has their own ad-hoc patch convention
like that. It can be really hard to figure it all out. Parsing that is
non-trivial, but being able to generate diffs based on that would be a
very valuable resource.

>> There's some Icelandic law currently enacted that hasn't been change=
d
>> since the 1200s. Getting that into Git would be interesting.
>
> Extremely.
>
> I'll put my Constitution project up on GitHub in a few days. =C2=A0Ju=
st note
> that I *will* rebase and publish.

Great.
