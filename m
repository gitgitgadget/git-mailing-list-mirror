From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: add configurable tab size to the diff view git-gui - why not added to git-gui ?
Date: Fri, 19 Sep 2014 10:02:23 -0700
Message-ID: <xmqq8ulfo868.fsf@gitster.dls.corp.google.com>
References: <lvhesi$qqs$1@ger.gmane.org>
	<xmqqd2aro8fx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pb158 <pb158@tlen.pl>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Sep 19 19:02:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV1Zn-0000KJ-Sa
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 19:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580AbaISRC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 13:02:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56095 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757497AbaISRC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 13:02:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A8C239E6A;
	Fri, 19 Sep 2014 13:02:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NZTj/tl1eC5dWkYlEmYEET9TLtQ=; b=v/r0Sp
	XPl/JIn+KgAggfUJHt+4jr+OvEVob3fVyTMEzuy1tyHY2GG8c4/XKsbG4lgg2Sbq
	t3MgMuo7hD5WjbW05MxLQCktAwAHm2YAvrOow+KeYRftJmFKQmY8xyuobgrWv1oO
	BOeKX7/vHJGa1f5+XF0Dr9DvcfIMadCJtF794=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q7ZyntbXquw2vjqm/VqmHepxnVAxci5R
	ZXl9/w9YJYwR20ojDIJ5MxVdrVMhckAtzpG7O+VWJyp/di5GdpWoPcPJMj1euP26
	seNSNcvptA+rRP5Le6jNHt222Gq2m03esQnpep+maZ/7EByTaVFOknvC7j2dCWUo
	kE6SzNvDaVk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E02939E69;
	Fri, 19 Sep 2014 13:02:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BBAD839E66;
	Fri, 19 Sep 2014 13:02:24 -0400 (EDT)
In-Reply-To: <xmqqd2aro8fx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 19 Sep 2014 09:56:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA70A0FE-401E-11E4-909E-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257290>

Junio C Hamano <gitster@pobox.com> writes:

> I do not use git-gui, and I do not speak very good tcl/tk either, so
> I won't comment on the patch itself (Cc'ed its maintainer Pat), but
> thanks for trying to relay, anyway.
>
>> ----------------------
>>
>> For Tk 8.5 the "wordprocessor" mode allows us to get a bit fancy for merge
>> diffs and intend the tabs by one to compensate for the additional diff
>> marker at the line start.
>>
>> The code is heavily based on how gitk handles tabs.
>>
>> Signed-off-by: Michael Lutz <michi@xxxxxxxxxxxxxx>
>
> With this, the author refuses to be contacted if/when any question
> arises wrt the provenance of the patch, which is not a usable form
> of a sign-off.  When you relay a change from somebody else who
> claims that he has rights to contribute the change to the project,
> and you have the rights to relay that change to the project, please
> also add your own sign-off.

Heh, I spoke too fast.  The original is at $gmane/190576 [*1*] and
the butchering of the address is only due to the the spinics list
archive pb158 grabbed his or her copy from.

So we don't need any forwarder's sign-off.  As long as the change is
acceptable (I have no opinion on it), the original can be directly
applied.


[References] 

*1* http://article.gmane.org/gmane.comp.version-control.git/190576/raw
