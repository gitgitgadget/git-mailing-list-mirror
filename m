From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] user-manual: Reorganize the reroll sections,
 adding 'git rebase -i'
Date: Tue, 19 Feb 2013 12:56:07 -0800
Message-ID: <7vobfg3tw8.fsf@alter.siamese.dyndns.org>
References: <20130219093429.GA4024@odin.tremily.us>
 <cover.1361267945.git.wking@tremily.us>
 <e9f8a25c05f9cfe89c6bcbefb69f40cd629f9925.1361267945.git.wking@tremily.us>
 <7vwqu45efr.fsf@alter.siamese.dyndns.org>
 <20130219185119.GD8170@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Feb 19 21:56:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7uEt-0004O8-DR
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 21:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934166Ab3BSU4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 15:56:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933578Ab3BSU4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 15:56:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 365E7A7BE;
	Tue, 19 Feb 2013 15:56:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1DnRj5elsHiUhTvkDErWqVzPx2s=; b=Zay7ww
	jfng4x4ujl2oJ2hIZfF3deYBhVX7/FRjuDmtRy6OUBIHO2CzG/WfCr5E8+w/dROU
	oMAl0xjpYyfasqeYDARAtQf7EEN3KILHYgiPhISwdXKy+INpFuzc6sYs6cIe63nB
	X0EOYjR4ilV+wnBNTwIraVtCo9LtcdDdyDVFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rVTAisne0yqDeZeXRpM6O07Yfe4o2OLM
	ZyyKduf2ipXQ+CN9biANt1s3ML+ZVgV4xGSwF0SD1I3ek6GIqzJrCBJ4Lbej3+cb
	Csz1iDslvhfOQIjm9eN4p0O7h8DSnrhlYiKjjZxhqmXZs6Iqr/BBVG1vkZsV8kkW
	bexCEIp/asQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A726A7BD;
	Tue, 19 Feb 2013 15:56:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 878A8A7BC; Tue, 19 Feb 2013
 15:56:08 -0500 (EST)
In-Reply-To: <20130219185119.GD8170@odin.tremily.us> (W. Trevor King's
 message of "Tue, 19 Feb 2013 13:51:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8D6A5F8-7AD6-11E2-9FFB-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216660>

"W. Trevor King" <wking@tremily.us> writes:

> On Tue, Feb 19, 2013 at 10:47:04AM -0800, Junio C Hamano wrote:
>> "W. Trevor King" <wking@tremily.us> writes:
>> > +Sometimes you want to edit a commit deeper in your history.  One
>> > +approach is to use `git format-patch` to create a series of patches,
>> > +then reset the state to before the patches:
>> >  
>> >  -------------------------------------------------
>> > +$ git format-patch origin
>> > +$ git reset --hard origin
>> >  -------------------------------------------------
>> 
>> Technically speaking, this does not "reset to before the patches".
>> You would need "git reset --hard $(git merge-base origin HEAD)" or
>> something like that.
>
> They'll be fine if they haven't fetched since they started their
> branch ;).
>
> It does look like I've got an extra comma an a missing “and”.  What
> about:
>
>   …create series of patches and then reset…

The original doesn't look too odd to me, but I'll amend to what you
just wrote.

Thanks.
