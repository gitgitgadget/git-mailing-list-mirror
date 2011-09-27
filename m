From: Eric Raible <raible@nextest.com>
Subject: Re: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch
 head'
Date: Tue, 27 Sep 2011 13:34:33 -0700
Message-ID: <4E823359.7080602@nextest.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk> <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk> <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com> <4E81F080.7010905@drmicha.warpmail.net> <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com> <7v39fhyk21.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 22:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8eRX-0003Xs-Qv
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 22:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777Ab1I0Ujq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 16:39:46 -0400
Received: from smtps.nextest.com ([12.96.234.114]:55992 "EHLO
	exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753771Ab1I0Ujp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 16:39:45 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Sep 2011 16:39:45 EDT
Received: from [131.101.151.13] (131.101.151.13) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Tue, 27 Sep 2011 13:34:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <7v39fhyk21.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182262>

On 11:59 AM, Junio C Hamano wrote:
> Michael Witten <mfwitten@gmail.com> writes:
> 
>> It seems like a more logical approach would be instead for "git
>> commit" to take a "--root" option that would create a new root commit
>> based on the current index and then point the current branch head to
>> the new root commit. Thus:
>>
>>   $ git checkout -b new_branch old_branch
>>   $ # Manipulate or not
>>   $ git commit --root
>>
>> That's how people think.

Not this person.

I like the idea but I'd rather see:

	git commit --no-parent

"parent" at least appears in gitk and therefore newcomers will prob
have a better chance of understanding the intent w/out needing to
otherwise unnecessary terminology.
