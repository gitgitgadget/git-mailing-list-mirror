From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #08; Mon, 31)
Date: Thu, 03 Apr 2014 10:15:04 -0700
Message-ID: <xmqqmwg2qqqv.fsf@gitster.dls.corp.google.com>
References: <xmqqppl128q8.fsf@gitster.dls.corp.google.com>
	<20140402200409.GA9984@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Ronald Weiss <weiss.ronald@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 19:15:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVlER-0000yZ-U4
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 19:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbaDCRPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 13:15:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35525 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbaDCRPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 13:15:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B809779145;
	Thu,  3 Apr 2014 13:15:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vEXM14KdEpA3MJa8KKZQBBhdnQ4=; b=Vds411
	37wlZwbUnk3gzh6pt6KnICg+5M7rIHgSHLoKl0bvBskCbvGJ5AokPwbzDWNDTydf
	XEMtfWo36wUku+bsHl6evZi2o+ZLbbCHjn+gyOrqsq+liB243a8cnpjqP+RkE7RW
	QmBi1eE2KtchxGg4jJxMAX9+RxFpI1BTim9YQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=arCKhhfOTJmcPZrmVhwso/JlnOMUjTRy
	+0337heIrbUBZ8tOps+OUO4E7ei6KUrSKSHBNTIzxQDTANi1B+yaEOweKLwn81i8
	7OQWPyVz9LtB/di3a8Ec1Q30owqWiguarpOqSRTxHMuFu8K/a6QNCuJTTp+q+wIm
	g6ySCG8B6Jw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A562879143;
	Thu,  3 Apr 2014 13:15:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C204E79141;
	Thu,  3 Apr 2014 13:15:05 -0400 (EDT)
In-Reply-To: <20140402200409.GA9984@sandbox-ub> (Heiko Voigt's message of
	"Wed, 2 Apr 2014 22:04:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 802869FE-BB53-11E3-A34F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245743>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Mon, Mar 31, 2014 at 05:29:03PM -0700, Junio C Hamano wrote:
>> * hv/submodule-ignore-fix (2013-12-06) 4 commits
>>  - disable complete ignorance of submodules for index <-> HEAD diff
>>  - always show committed submodules in summary after commit
>>  - teach add -f option for ignored submodules
>>  - fix 'git add' to skip submodules configured as ignored
>> 
>>  Teach "git add" to be consistent with "git status" when changes to
>>  submodules are set to be ignored, to avoid surprises after checking
>>  with "git status" to see there isn't any change to be further added
>>  and then see that "git add ." adds changes to them.
>> 
>>  I think a reroll is coming, so this may need to be replaced, but I
>>  needed some practice with heavy conflict resolution.  It conflicts
>>  with two changes to "git add" that have been scheduled for Git 2.0
>>  quite badly, and I think I got the resolution right this time.
>> 
>>  Waiting for a reroll.
>
> Since Ronald and Jens picked up this topic[1], I think you can discard
> my series.

Thanks, will do.
