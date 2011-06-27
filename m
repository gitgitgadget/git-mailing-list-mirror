From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 20:56:57 +0200
Message-ID: <4E08D279.7060202@web.de>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org>  <4E08C89E.5020109@web.de> <1309200722.2497.294.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 21:01:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbH3o-0008J4-RV
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 21:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785Ab1F0S7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jun 2011 14:59:06 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43157 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab1F0S47 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 14:56:59 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 65A181A3CD472;
	Mon, 27 Jun 2011 20:56:58 +0200 (CEST)
Received: from [93.240.101.84] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QbGzS-0003OS-00; Mon, 27 Jun 2011 20:56:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <1309200722.2497.294.camel@Naugrim.eriador.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+UifCq6feHlwYtQZMoA2XAPhKG5dc0YZCB1QhM
	BWx0MoZ6XeKZS6MRdeUHoKRZSMNt5iLVQ4KEjpTD0fpf8xXPrw
	srdDq3sss7ZVIlv3GxtQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176363>

Am 27.06.2011 20:52, schrieb henri GEIST:
> Le lundi 27 juin 2011 =C3=A0 20:14 +0200, Jens Lehmann a =C3=A9crit :
>> Am 27.06.2011 18:51, schrieb Junio C Hamano:
>>> One possible working tree organization may look like this:
>>>
>>> 	-+- lib1
>>>          +- project1/Makefile -- refers to ../lib1
>>>          +- project2/Makefile -- refers to ../lib1
>>
>> This is what we do at work and it works really well for us. The
>> possible downside (that you can't tie project1 and project2 to a
>> specific version of lib1 in their own repo) is not a real problem
>> in our experience, as the superproject ties the correct combination
>> together.
>>
>=20
> That is a good starting point.
> I have used this method for some little projects and it work great.
>=20
> But I had never find a mean to handle the case of project1 depending =
on
> both lib1 and lib2.

Hmm, but isn't that covered by having lib1, lib2 & project1 right next
to each other in your superproject?
