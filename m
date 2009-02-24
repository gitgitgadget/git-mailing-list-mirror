From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Tue, 24 Feb 2009 00:00:30 -0800
Message-ID: <7vzlgcjmch.fsf@gitster.siamese.dyndns.org>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
 <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
 <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
 <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
 <7vljrxveqa.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
 <94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com>
 <7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
 <20090224105528.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 09:02:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbsEx-00016B-BH
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 09:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbZBXIAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 03:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbZBXIAj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 03:00:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbZBXIAj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 03:00:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 827379C773;
	Tue, 24 Feb 2009 03:00:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E04FD9C771; Tue,
 24 Feb 2009 03:00:32 -0500 (EST)
In-Reply-To: <20090224105528.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Tue, 24 Feb 2009 10:55:28 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 381ECF90-0249-11DE-9B94-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111234>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>>>>> People already are used to finding the shed in the scenery by loo=
king for
>>>>> that original color, however ugly the color might be. =C2=A0The a=
nswer to your
>>>>> question has to become quite different when you take that into ac=
count;
>>>>> otherwise you are being irresponsible to your users.
>>>
>>> People somehow got used to the ugly color, they'll get used to the
>>> pretty one, in fact, they would probably like it better,...
>>
>> You do not have to send two messages in a row to reaffirm that you a=
re of
>> irresponsible kind.  I heard you enough already.
>>
>> Go away.
>
> Junio, what got into you?
>
> I've always admired your calm and reasoned way to deal with even the
> most obnoxious people, and unlike more abrasive people on this list I=
've
> never seen you say "Go away" to anybody here.
>
> Especially because I agree with you that calling pretty-printing as
> "pretty" isn't so broken to make such a big deal out of, it would be
> better not to chase a potentially useful contributor away on such a
> minor issue.

I may try to be more diplomatic than other people, but it does not mean=
 I
do not reserve the right to get annoyed enough from time to time.

When you hear people complain, and you take a poll and see there are ma=
ny
people who agree with you, a naive thing to do is to assume that you no=
w
got the majority vote.  Over time, you will learn that majority were
happy, were not complaining, and they merely did not bother to object t=
o
the complainers who want to change things.  And the last thing you want=
 is
to find these things out the hard way by bringing a sudden change to th=
em
and giving them something to compalin about, like we did with 1.6.0.  Y=
ou
need to learn to take "let's improve this thing, as many people want it=
"
with a huge grain of salt.

This cannot be stressed enough; if somebody is incapable of understandi=
ng
it, then we would be better off without him or her.

I am not so worried about losing Felipe as a contributor, not because I=
 do
not think he is useful, but because I do not think he is stupid.

Judging from his other patches, I think he is reasonably capable and
intelligent, but just is not experienced enough with the culture around
here, especially about taking the existing users extremely seriously.  =
The
first patch landed in the git tree from him was in January 2009---perha=
ps
I should have tried to be more diplomatic with him as a newcomer for a =
bit
longer, but I am reasonably sure that he is smart enough to realize the
importance of different acceptance criteria between new features and
changes to existing interfaces after having time to think about it for =
a
few days, and will come back.
