From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: 6d4bb3833c3d2114d (fetch: verify we have everything we need before updating our ref) breaks fetch
Date: Sat, 1 Oct 2011 11:38:08 +0100
Organization: OPDS
Message-ID: <BED2B875AEDF4E52843F1C9211A8D2A1@PhilipOakley>
References: <1317225869.30267.18.camel@bee.lab.cmartin.tk> <m3y5x8o527.fsf@localhost.localdomain> <1317426849.4331.29.camel@centaur.lab.cmartin.tk> <20111001060353.GA25228@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat Oct 01 12:37:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9wwa-0000O3-Jd
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 12:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab1JAKhQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 06:37:16 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:62469 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755190Ab1JAKhO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 06:37:14 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AggFAOvshk5cHKZm/2dsb2JhbABBhGWFTZ1/gQaBTgEEAQEFCAEBGQ8BBR4BASELAgMFAgEDDgcDAgIFGgcCAhQBBBoGBxcGARIIAgECAwGHYgqlUpEugS2BbIJ4MmEEpSA
X-IronPort-AV: E=Sophos;i="4.68,472,1312153200"; 
   d="scan'208";a="356388346"
Received: from host-92-28-166-102.as13285.net (HELO PhilipOakley) ([92.28.166.102])
  by out1.ip05ir2.opaltelecom.net with SMTP; 01 Oct 2011 11:37:12 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182545>

=46rom: "Jeff King" <peff@peff.net>
> On Sat, Oct 01, 2011 at 01:54:08AM +0200, Carlos Mart=C3=ADn Nieto wr=
ote:
>
>> > Have you tried
>> >
>> >   $ ./git fetch git://repo.or.cz/git
>>
>> But this would execute /usr/local/libexec/git-fetch, wouldn't it? Th=
at
>> is precisely what I don't want to execute, because I changed some co=
de
>> in builtin/fetch.c that I want to test.
>
> No, but only because fetch is a builtin. However, it still doesn't se=
t
> up exec_path correctly, so your rev-list problem would not go away.
>
>> I guess I'll have to either properly install git from 'next' or base=
 my
>> changed on 'maint'
>
> Just use bin-wrappers/git. That's exactly what it's there for (and it=
's
> what the test scripts use to make sure we are testing what is compile=
d).
>
> Your change isn't the problem; only your testing method.
>
> -Peff

Peff,

Is there a write up of the the git testing method and how to use=20
bin-wrappers etc. I didn't see anything in the Documentation, but I may=
 not=20
have looked carefully enough

Philip=20
