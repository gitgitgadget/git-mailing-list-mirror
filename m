From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Grammar fixes to "merge" and "patch-id" docs
Date: Wed, 25 Mar 2009 20:03:53 +0100
Message-ID: <249E343F-DE3D-45B1-B733-BA33FC4F2AB8@wincent.com>
References: <1238005422-7647-1-git-send-email-win@wincent.com> <7vocvp310v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 20:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmYPy-0004b2-4W
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 20:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbZCYTEF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 15:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbZCYTEB
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 15:04:01 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:43613 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbZCYTEA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 15:04:00 -0400
Received: from cuzco.lan (179.pool85-53-16.dynamic.orange.es [85.53.16.179])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n2PJ3rb0021930
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 25 Mar 2009 15:03:55 -0400
In-Reply-To: <7vocvp310v.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114648>

El 25/3/2009, a las 19:33, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> If you tried a merge which resulted in a complex conflicts and
>> -would want to start over, you can recover with 'git-reset'.
>> +want to start over, you can recover with 'git-reset'.
>
> Reads Ok to me either way...

"tried" is in the past preterit, so the second verb, the one after the =
=20
"and", should be "want" due to concordance. "would want" is not =20
actually wrong, but it is bad form. It is a common mistake among non-=20
native speaker to use "would" when it's not required in cases like =20
this, probably due to confusion with the pattern "If X, I would =20
Y" (but note that there's no "and" in that case).

(Speaking as a native English-speaker and part-time English teacher, =20
who this very week has been teaching classes about modal verbs like =20
"would".)

>> diff --git a/Documentation/merge-strategies.txt b/Documentation/=20
>> merge-strategies.txt
>> index 1276f85..ee7f754 100644
>> --- a/Documentation/merge-strategies.txt
>> +++ b/Documentation/merge-strategies.txt
>> @@ -3,15 +3,15 @@ MERGE STRATEGIES
>>
>> resolve::
>> 	This can only resolve two heads (i.e. the current branch
>> -	and another branch you pulled from) using 3-way merge
>> +	and another branch you pulled from) using a 3-way merge
>> 	algorithm.  It tries to carefully detect criss-cross
>
> Hmph, would that be an 'a' or 'the'?

Doesn't really matter, IMO, but some kind of article is required =20
there. If there is literally only one 3-way merge algorithm in =20
computer science, then "the" would be best. I chose "a" because I was =20
thinking of it as "Git's interpretation of the 3-way merge algorithm".

>> recursive::
>> -	This can only resolve two heads using 3-way merge
>> -	algorithm.  When there are more than one common
>> -	ancestors that can be used for 3-way merge, it creates a
>> +	This can only resolve two heads using a 3-way merge
>> +	algorithm.  When there is more than one common
>> +	ancestor that can be used for 3-way merge, it creates a
>
> Do you need an article before the latter "3-way merge", perhaps "the"=
?

Probably wouldn't hurt.

>> @@ -22,11 +22,11 @@ recursive::
>> 	pulling or merging one branch.
>>
>> octopus::
>> -	This resolves more than two-head case, but refuses to do
>> -	complex merge that needs manual resolution.  It is
>> +	This resolves the more than two-heads case, but refuses to do
>> +	a complex merge that needs manual resolution.  It is
>
> Perhaps "resolves cases with more than two heads" is easier to read?

Yes, I agree.

Cheers,
Wincent
