From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2013, #03; Wed, 6)
Date: Wed, 06 Feb 2013 11:39:29 -0800
Message-ID: <7vsj59b5am.fsf@alter.siamese.dyndns.org>
References: <7v8v71cn3m.fsf@alter.siamese.dyndns.org>
 <5112AE34.6080107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:39:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3AqZ-0006Q4-S8
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 20:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757943Ab3BFTjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 14:39:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755031Ab3BFTjc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 14:39:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD837BE83;
	Wed,  6 Feb 2013 14:39:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MiHsa9HslUkW9kFYT2cM7TubJDI=; b=QMMXpI
	oOC+f/Fn/fAvZ9mVSGbC9y6MqljMXsFXA/l2n73uF7kTZ7PmMYT5mu7XQg+fgs2S
	TxxdVxGTb9KtZcUe03Fa1ap97h2LJmChkw4RhQ0bKqqbFFBQNPHebypOOepx4ViP
	At/sd0VRkxUsC4eAEdWbIAHzFR8Zb9JdTCPFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rLeHbrpiha6KHj0Fnw9ls3XGzd+NCVUv
	6Xi1pSkuuFhfLP12NQUZCg11b21IDQriVBZPnKdNd0xVuDm2HZzhINOpLI+j9zs+
	B+0JIShYTJumq/dUMGS/YmgpiE1q/wledD3vtlPSP8K/eKh2Glr1pUDyeI/pfb/Z
	+lRVhRvNcbY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0582BE81;
	Wed,  6 Feb 2013 14:39:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D62ABE7E; Wed,  6 Feb 2013
 14:39:31 -0500 (EST)
In-Reply-To: <5112AE34.6080107@web.de> (Jens Lehmann's message of "Wed, 06
 Feb 2013 20:25:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED38E268-7094-11E2-8BB4-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215626>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 06.02.2013 19:29, schrieb Junio C Hamano:
>> * jl/submodule-deinit (2013-02-04) 1 commit
>>  - submodule: add 'deinit' command
>> 
>>  There was no Porcelain way to say "I no longer am interested in
>>  this submodule", once you express your interest in a submodule with
>>  "submodule init".  "submodule deinit" is the way to do so.
>> 
>>  Will merge to 'next'.
>
> Oops, I though you were waiting for a reroll. Currently I'm having the
> appended interdiff compared to your version. Changes are:
>
> - Add deinit to the --force documentation of "git submodule"
> - Never remove submodules containing a .git dir, even when forced
> - diagnostic output when "rm -rf" or "mkdir" fails
> - More test cases
>
> And I wanted to add three more test cases for modified submodules before
> sending v4. You could squash in the first two hunks into the commit you
> have in pu and I'll send a follow up patch with the extra tests soon or
> you could wait for me sending an updated patch. What do you think?

I haven't merged it down to 'next' yet.  So please proceed as you
planned.  Thanks for stopping me.
