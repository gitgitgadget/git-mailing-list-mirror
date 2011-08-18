From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] rev-parse: Allow @{U} as a synonym for @{u}
Date: Thu, 18 Aug 2011 11:31:33 +0200
Message-ID: <4E4CDBF5.4040709@drmicha.warpmail.net>
References: <CAMK1S_hZkdXiQb_UTB=snLAXPmo5yrCnFaQFHZqYq5AXqOgWng@mail.gmail.com> <1313287071-7851-1-git-send-email-conrad.irwin@gmail.com> <7vhb5fd4zy.fsf@alter.siamese.dyndns.org> <CACsJy8CX7X3u4i_kXChVHkFK=Q--pRBrxmdvjxrF7wr5_SyakA@mail.gmail.com> <4E4CBC29.7080703@drmicha.warpmail.net> <CACsJy8Dr5q=h-9MhNV0gKtVEn13+DxWwcNn2Prem6-+DyrDmHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Conrad Irwin <conrad.irwin@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 11:31:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtywv-0007pv-BD
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 11:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382Ab1HRJbh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 05:31:37 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38375 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755199Ab1HRJbg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 05:31:36 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ADE212082D;
	Thu, 18 Aug 2011 05:31:35 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 18 Aug 2011 05:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=1P3erzKEkXfqmSA19546GA
	Ubirs=; b=s8IdzFaJQ5SIO+bJ/zF8RgMIqXej4Uc7U2zqj5WoENl7pvRovgEBan
	wWVV/zroDgFTTnSoAd3eR5rZmei34jl1l0yMexczBmjFh2+0z04QFQ6h9rmgNP2M
	bPME6wY1j5KLcPFfak1orzhN95AExa/+/nmP9nAxp2/cK0/RpQAW0=
X-Sasl-enc: CE2pLoaXqiVsOLgHyhTVVYGB0q5afp8Z9/2Aljwj9Uq0 1313659895
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D1D916E0266;
	Thu, 18 Aug 2011 05:31:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CACsJy8Dr5q=h-9MhNV0gKtVEn13+DxWwcNn2Prem6-+DyrDmHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179586>

Nguyen Thai Ngoc Duy venit, vidit, dixit 18.08.2011 10:54:
> On Thu, Aug 18, 2011 at 2:15 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> For a german keyboard layout, you get @{u} from
>>
>> hold AltGr (Meta)
>> press q
>> press 7
>> release AltGr
>> press u
>> hold AltGr
>> press 0
>>
>> For me, an improvement would be to have the alias
>>
>> @{=E2=86=93}
>=20
> While it's convenient to type, the output now looks strange. If you d=
o
> a screencast, or someone is watching you, they may not understand wha=
t
> that syntax is.

just like with any shell or git alias.

>=20
> Also..
>=20
>> As a simpler case, a user could tailor to her keyboard layout with
>>
>> git config revalias.=E2=86=93 u
>=20
> We may also have encoding issue here. What if config file is in utf-8=
,
> but the console is not?

It's a user setting, tailored for the user's environment.

> So I don't we should go this way. There may be a better way to deal
> with different keyboard layouts.
>=20
>> Well, this patch is actually specific to a particular keyboard layou=
t!
>> It improves things only for a layout where you get @ and { using a s=
hift
>> key.
>=20
> Fully agreed. While it does not help non en-US keyboards, it does not
> cause any harm (jealousy is not classified as harm to me, rather
> motivation ;).

If you sell it as

"rev key is like a config key, so make it case insensitive. As a side
effect, it helps certain keyboard layouts and does not harm others."

it may fair a better chance ;)

I guess this should apply to rev^{<type>} as well, then.

Michael
