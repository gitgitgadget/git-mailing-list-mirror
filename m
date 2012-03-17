From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [fixup PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Sat, 17 Mar 2012 20:42:24 +0100
Message-ID: <4F64E920.7010008@in.waw.pl>
References: <20120313232256.GA49626@democracyinaction.org> <vpqipi7zh3n.fsf@bauges.imag.fr> <7vty1rqek5.fsf@alter.siamese.dyndns.org> <7vlin1gl9l.fsf@alter.siamese.dyndns.org> <4F64C58B.4000207@in.waw.pl> <20120317184649.GA320@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, peff@peff.net,
	Clemens Buchacher <drizzd@aon.at>
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 20:42:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8zWb-0006mP-H9
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 20:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633Ab2CQTmo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 15:42:44 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55866 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511Ab2CQTmo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 15:42:44 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.2.82])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S8zWL-0003gP-B8; Sat, 17 Mar 2012 20:42:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <20120317184649.GA320@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193346>

On 03/17/2012 07:46 PM, Christopher Tiwald wrote:
> On Sat, Mar 17, 2012 at 06:10:35PM +0100, Zbigniew J=C4=99drzejewski-=
Szmek wrote:
>>   static const char message_advice_use_upstream[] =3D
>> -	N_("Some of your local branches were stale with respect to their\n=
"
>> -	   "remote counterparts. If you did not intend to push these branc=
hes,\n"
>> -	   "you may want to set the 'push.default' configuration variable =
to\n"
>> -	   "'current' or 'upstream' to push only the current branch.");
>> +	N_("Updates were rejected because a tip of your branch is behind t=
he remote.\n"
>> +	   "If you did not intend to push that branch, you may want to exp=
licitly\n"
>> +	   "specify branches to push or set the 'push.default' configurati=
on variable"
>> +	   "to 'current' or 'upstream' to always push only the current bra=
nch.");
>
> I prefer the "Some of your local..." language to "Updates were
> rejected..." as a reader, but I think you're right about providing th=
e
> reason git rejected the push up front.
>
> My concern about this particular message is "tip of your branch is be=
hind
> the remote" reads to me like my _current_ branch is the offender, whe=
n
> that cannot be the case (it'd hit message_advice_pull_before_push
> first). Maybe something like this might make it clearer?
>
> "Updates were rejected because a pushed branch tip is behind its remo=
te
> counterpart. If you did not intend to push that branch, you may want =
to
> explicitly specify branches to push or set the 'push.default' configu=
ration
> variable to 'current' or 'upstream' to always push only the current b=
ranch."
Yeah, that's better.

Zbyszek
