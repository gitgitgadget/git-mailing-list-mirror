From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 15:59:45 -0700
Message-ID: <7v1un0euqm.fsf@alter.siamese.dyndns.org>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com>
 <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
 <20120501111415.GD5769@thunk.org>
 <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
 <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com>
 <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com>
 <7v62cf8v2d.fsf@alter.siamese.dyndns.org> <4FA054BA.80601@palm.com>
 <86ipgfmw05.fsf@red.stonehenge.com> <4FA05C66.2060608@palm.com>
 <CAMOZ1BuiznhrzEOHe0N+uu=mLEw5wWTQyDpnwG8PuF1f_aNaXw@mail.gmail.com>
 <7vipgddl9m.fsf@alter.siamese.dyndns.org> <4FA30A68.5010002@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Fri May 04 01:00:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ511-0006WS-OH
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 01:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758937Ab2ECXAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 19:00:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55199 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758922Ab2ECW7s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 18:59:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8833F7280;
	Thu,  3 May 2012 18:59:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LG6QLJ+0LZUtLDssVT9sXWXzppY=; b=tWrzYi
	41zDmmWCa56/1g2HBtqZp5ykrRuCLz6sgQHIpDL+mrOKjJex99kqps3dLunAX6z6
	iTaA9YIU+mIMuagno9ALstiHHR7OwbFnf30uHA1xuXUqQgZAWh0Gw/4/1ZEUob43
	ydere5wvj/J/+1kIrPZaah+Ri7sOU9GzLlovQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=slhFzcEfbxAtON8WvOjPSxdh6Y4f5B/h
	TqmZxRYDYzQeHulRWUKNCeYVhyA/fcKxQCisMDGXvdqheB6eTEF9GL12R8+IofVx
	ki97F5n0mJHyLM1m2gYlUJkJ5L26ior/jdm8A8ZT8yu6jaccDFs6znJ7727hInpn
	ZmB0nONxzXs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E884727F;
	Thu,  3 May 2012 18:59:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AD26727E; Thu,  3 May 2012
 18:59:46 -0400 (EDT)
In-Reply-To: <4FA30A68.5010002@palm.com> (Rich Pixley's message of "Thu, 03
 May 2012 15:44:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ADFDFDEC-9573-11E1-8458-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196974>

Rich Pixley <rich.pixley@palm.com> writes:

> On 5/3/12 14:09 , Junio C Hamano wrote:
>> Michael Witten<mfwitten@gmail.com>  writes:
>>
>>> (Note, though, that Junio has done a laudable job of keeping the
>>> whole experiment going strong).
>>
>> You are giving me too much credit, and at the same time insulting the
>> people who polished Git enough to suit their workflow.  To them, the tool
>> has past "experiment" stage long time ago.  They found what was lacking
>> and what would help the need in their workflow.  I just have helped them
>> shape their ideas into a coherent whole.
>>
>> That does not mean there is nothing missing, still appears experimental,
>> or inconsistent in the parts of the system that these people do not use
>> nor care about, and when you bring in people coming from different
>> background, they will notice the behaviour or default that do not match
>> their expectation....
> 
> ...  The motivation to
> change it would be to make it easier for the next person.

That is how the workflow support elements that were originally missing
like reflogs, stashes, tracking branches, etc. all came to exist.  Making
it easier for the next person is why we had a large discussion on the
default behaviour of unconfigured push andthe follow-up implementation of
the "simple" push behaviour.  It is a good example that community members
are willing to help new person even at the expense of inconvenience to old
timers.

What does _not_ happen is to chase down people who whined and left without
giving us something concrete enough to base design of new workflow support
elements, but the community cannot police the behaviour of those who come,
whine and then leave, so...
