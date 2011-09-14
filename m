From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Wed, 14 Sep 2011 13:57:38 -0700
Message-ID: <7vsjnysuyl.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
 <7vipox2wd6.fsf@alter.siamese.dyndns.org>
 <D3CA81F2-647B-4AD0-A4FC-4C22772FD791@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan McGee <dpmcgee@gmail.com>, David Aguilar <davvid@gmail.com>,
	git@vger.kernel.org
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 22:57:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3wWg-0006cU-RN
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 22:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933311Ab1INU5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 16:57:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50238 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933235Ab1INU5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 16:57:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C78294DA8;
	Wed, 14 Sep 2011 16:57:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lfm2WOhFUB7hkVmCjf4XeSTOdbA=; b=FPYPZI
	OP2gd4xLH/mbwOQw5ms61jy/uF4lPUYYjFOOeA8h9rbFvcafK3AYGzMbhlxu0Zr/
	rI4LUe0OL439O9PNSGNQQ7Xuy5XcJMAfuieYTrM7emHj4wxGIWVNUbcIaakIu2T9
	Szp6wa1TV7MGgeEF6n4wX6JHH0spnmBVXfI80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Btueikl0y/laGkGdOc0oeoZVPWuzGmrf
	gMNH9H8axg3TdyO4R6Cf7n1NFXeO0pPidvm7JF25y9H9kPOh+XC45t4FOvjjDFLg
	atgE6idVV2CEDQR6T+DGVXSKO7cE7zekUmrsiQuA4aGbcJsf0LOFFzqgyplB8S8p
	x9feE0MjciU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFD224DA7;
	Wed, 14 Sep 2011 16:57:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 541744DA6; Wed, 14 Sep 2011
 16:57:39 -0400 (EDT)
In-Reply-To: <D3CA81F2-647B-4AD0-A4FC-4C22772FD791@JonathonMah.com> (Jonathon
 Mah's message of "Tue, 13 Sep 2011 19:34:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E7F72D2-DF14-11E0-917D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181400>

Jonathon Mah <me@JonathonMah.com> writes:

> On 2011-09-12, at 14:59, Junio C Hamano wrote:
>
>>> [Stalled]
>>> 
>>> * jm/mergetool-pathspec (2011-06-22) 2 commits
>>> - mergetool: Don't assume paths are unmerged
>>> - mergetool: Add tests for filename with whitespace
>> 
>> What's the plan for this series? Do we still want to pursue it within the
>> timeframe for the next round?
>> 
>> Is there any mergetool/difftool expert who volunteers to help moving this
>> topic forward?
>
> I'd love this to stay alive. As I've mentioned before, my relationship
> with shell is tenuous. My biggest problem is...

Hopefully volunteers can help moving this forward with "coding".

  http://thread.gmane.org/gmane.comp.version-control.git/176215
  http://thread.gmane.org/gmane.comp.version-control.git/176216

There were issues with the patches that were _not_ about the coding but
about the documentation and design.

Topics with a stale version in 'pu' that are stalled are not even alive--
they are zombies that need to be wiped at some point, or replaced with
updated series, whichever comes first.
