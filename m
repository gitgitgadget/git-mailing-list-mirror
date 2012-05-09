From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Wed, 09 May 2012 19:25:13 +0200
Message-ID: <vpqehqtferq.fsf@bauges.imag.fr>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
	<vpqehqxmwpj.fsf@bauges.imag.fr>
	<CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
	<CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
	<7v1umv7ub0.fsf@alter.siamese.dyndns.org>
	<CACBZZX6u7rJer+tSqPddKdAF=bd216pZH5qUQNcrdr4nCmT46Q@mail.gmail.com>
	<7v62c71fl7.fsf@alter.siamese.dyndns.org>
	<CAMP44s0DRrqMdHzOBTeQGmKtP7LzFerLZTaNgbHfj0XtebW9wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r?= =?iso-8859-1?Q?=F0?= 
	<avarab@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 19:26:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSAeP-0000n0-29
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 19:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760543Ab2EIR0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 13:26:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34391 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760478Ab2EIR0B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 13:26:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q49HI0W8020728
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 May 2012 19:18:00 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SSAdX-0006FU-1w; Wed, 09 May 2012 19:25:15 +0200
In-Reply-To: <CAMP44s0DRrqMdHzOBTeQGmKtP7LzFerLZTaNgbHfj0XtebW9wA@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 9 May 2012 15:10:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 May 2012 19:18:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q49HI0W8020728
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1337188684.872@NVVZ0qpm/p/iPl913uMNTQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197479>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, May 8, 2012 at 6:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> The word "index" is quite well understood: that which points at the
>> information given a headword that refers to it, which is exactly what the
>> "index" we have is. On the other hand, "to stage/staging area" is not as
>> widely used outside the narrow shipping/logistics circles.
>
> That's what git has, *internally*, but that's not how high-level users
> interact with it.

I agree with that. Explaining users that the <whatever you call it> is
the place where you stage content in preparation for the next commit is
much more productive than explaining that it is an array of
(name, sha1sum) pairs.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
