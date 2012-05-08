From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Tue, 08 May 2012 07:53:12 -0700
Message-ID: <7vlil2zpuv.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr>
 <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
 <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
 <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
 <CACBZZX6u7rJer+tSqPddKdAF=bd216pZH5qUQNcrdr4nCmT46Q@mail.gmail.com>
 <7v62c71fl7.fsf@alter.siamese.dyndns.org>
 <CACBZZX7LOKqKNe09636N0xJ_VvmKP58BMDtjoKn1t5e9hJ0OiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 16:53:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRln2-0006Ko-1l
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 16:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719Ab2EHOxQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 10:53:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56232 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755450Ab2EHOxP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 10:53:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 603096AD3;
	Tue,  8 May 2012 10:53:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fszlc/ICLS8D
	YygEk110WKF0EC0=; b=JJJo97RS19e/vocAsXE11yMxW3f/CyZwS4u2C8NDnf7t
	sO6ctnST+wtALBd8NUn8INgrTn4ZIHBITNCSIrUDMac6gSrYlkCH7Mv73YkEBO1k
	EqJmLvBcfYRkt00OzV9TUuvncyQue6WpttjikTIAWCbTZHAub9cm5vy/ZopUmKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Hd4xKM
	5npHQZiztOe9JqTCTIzk9omebJkxH3S/Sf+lXfLzrUE4DlbumqVFifCAiaybcY1i
	0mmuHE6W3WsyrHobBNAEewvI2hsAmIKFRZIdrybY49rJS8HeYZjuHZsoUFixrnUk
	oC5sDUpYS++IowxPm33qNGYE2x2iuRdlRN34c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5668C6AD2;
	Tue,  8 May 2012 10:53:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A772F6AD1; Tue,  8 May 2012
 10:53:13 -0400 (EDT)
In-Reply-To: <CACBZZX7LOKqKNe09636N0xJ_VvmKP58BMDtjoKn1t5e9hJ0OiQ@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 8 May
 2012 10:55:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89759806-991D-11E1-AA0F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197371>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, May 8, 2012 at 6:06 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
>> I didn't necessarily wanted to use "stage", it is "sad" because a
>> new word-hunt may be needed for a replacement to "index" (as "stage"=
 may
>> not be a good word for i18n audience), and then we would need to kee=
p
>> "index", "stage" and that third word as interchangeable terms.
>>
>> Spliting the userbase by introducing a new form to an established
>> terminology was bad enough, and making that three is worse.
>
> I don't think that line of reasoning makes sense at all....
> We should be picking terms that make the most sense in English, and
> then translators will translate those into whatever makes the most
> sense in their language.

OK.
