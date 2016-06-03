From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH v3 2/2] completion: add git status
Date: Fri, 3 Jun 2016 20:20:05 +0200
Message-ID: <3adf766d-9ae5-dd52-0b2a-5b250aeb566d@virtuell-zuhause.de>
References: <20160601141510.Horde.M2zGuJrzBNqf_2zYLo0P2Sx@webmail.informatik.kit.edu>
 <9ef8cfd8fb89bcacd123ddbebc12f961a292ef8b.1464879648.git.thomas.braun@virtuell-zuhause.de>
 <1464880296.3720.0.camel@virtuell-zuhause.de>
 <xmqqtwhbtq46.fsf@gitster.mtv.corp.google.com>
 <8f5e515b-8efc-0160-820e-d81885fc6c36@virtuell-zuhause.de>
 <xmqqzir2p6yv.fsf@gitster.mtv.corp.google.com>
 <20160603171711.GC3858@sigill.intra.peff.net>
 <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 20:20:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8thh-00058a-BY
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 20:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbcFCSUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 14:20:11 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:39277 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932259AbcFCSUJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 14:20:09 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1b8thW-0007Ne-R5; Fri, 03 Jun 2016 20:20:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464978009;0c6be7ef;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296362>

Am 03.06.2016 um 19:54 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> I know not everybody will the "natural thing" I claim, and if it were
>> easy to support everywhere, I don't mind doing it. But I suspect
>> (without thinking very hard on it) that it would make those case
>> statements a bit harder to read and maintain.
> 
> Oh, I agree with that 100%.  I didn't mean to suggest (let alone to
> demand) to support the possible truncations.
> 
> I simply was hoping that Thomas would respond with your "For a user
> who uses tab completion, it is natural to use --unt<TAB> so by the
> time we use find-on-command-line, we can expect the fully-spelled
> form" when I asked about "--unt=no"; that would give us a warm and
> fuzzy confirmation that the patch author has thought things through
> when designing the new feature.

I understood from Junio's comment [1]

> $ git status -uno <TAB>

that the question was about the short option version not about how
possible truncations are handled.

On the other side I must confess I did not think about the possibility
that the user truncates a long option as in --unt=all. Looking through
the completion file I have not found a place where the truncated
versions are supported.

[1]: http://article.gmane.org/gmane.comp.version-control.git/296220
