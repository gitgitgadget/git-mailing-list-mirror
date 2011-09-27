From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Tue, 27 Sep 2011 22:31:17 +0100
Organization: OPDS
Message-ID: <DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk> <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk> <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com> <4E81F080.7010905@drmicha.warpmail.net> <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com> <7v39fhyk21.fsf@alter.siamese.dyndns.org> <4E823359.7080602@nextest.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Michael Witten" <mfwitten@gmail.com>,
	"Michael J Gruber" <git@drmicha.warpmail.net>,
	=?utf-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	"vra5107" <venkatram.akkineni@gmail.com>, <git@vger.kernel.org>
To: "Eric Raible" <raible@nextest.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 23:31:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8fEy-0007OC-PP
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 23:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab1I0Va5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 17:30:57 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:64535 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752861Ab1I0Va4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 17:30:56 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgIFAFVAgk5cGntq/2dsb2JhbABBhGSFTZ1PeYFOAQQBAQUIAQEZFR4BASELAgMFAgEDFQMCAgUhAgIUAQQIEgYHFwYBEggCAQIDAYdfCqd5kWiBLIROMWAEnWqHHQ
X-IronPort-AV: E=Sophos;i="4.68,451,1312153200"; 
   d="scan'208";a="355988871"
Received: from host-92-26-123-106.as13285.net (HELO PhilipOakley) ([92.26.123.106])
  by out1.ip05ir2.opaltelecom.net with SMTP; 27 Sep 2011 22:30:54 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182265>

From: "Eric Raible" <raible@nextest.com>
> On 11:59 AM, Junio C Hamano wrote:
>> Michael Witten <mfwitten@gmail.com> writes:
>>
>>> It seems like a more logical approach would be instead for "git
>>> commit" to take a "--root" option that would create a new root commit
>>> based on the current index and then point the current branch head to
>>> the new root commit. Thus:
>>>
>>>   $ git checkout -b new_branch old_branch
>>>   $ # Manipulate or not
>>>   $ git commit --root
>>>
>>> That's how people think.
>
> Not this person.
>
> I like the idea but I'd rather see:
>
> git commit --no-parent
>
> "parent" at least appears in gitk and therefore newcomers will prob
> have a better chance of understanding the intent w/out needing to
> otherwise unnecessary terminology.
> --
I think this feels and sounds sensible.  And better located within the 
'commit' command, rather than 'checkout --orphan' which was more obscure 
(and difficult to find).
Philip 
