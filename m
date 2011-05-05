From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2011, #02; Wed, 4)
Date: Thu, 05 May 2011 08:59:53 -0700
Message-ID: <7v39ktb0jq.fsf@alter.siamese.dyndns.org>
References: <7vsjstc1pp.fsf@alter.siamese.dyndns.org>
 <m3sjstv7kz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 18:00:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI0yK-0006J0-VT
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 18:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab1EEQAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 12:00:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab1EEQAD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 12:00:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B07BF50AE;
	Thu,  5 May 2011 12:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lQjPiPgLKSmiaxBeuSyLYhRmVYE=; b=jpCHKr
	l5wb43LBP8aUrOHOY/O3hwB7v1llFKFWJt6TuFdSGKkq16V5drGDgd/md5Od3BnN
	K3+BOGEZ1lkn7lw9yq0ZGLohbOruswsxkCHHbmbo6sbiE/3PMDoMFcpfKY/z26Ql
	TVZTv3T04l8RBz90lS5GRUzWMauCJOdWFHelo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nrqU0TYhxcgYSfiA9e6/5LiuSPkKg+Ke
	T82EaUGrugCfRBKB8hAmpbk7bYDIs6gQYevVt+l5X0psMOKUB16OfrPbzX89kq9D
	7enpPI+W60zkT5/2nsdS0LuQxweRXGjwPtGOg1MeFKzyqeuLPM6PIWoFkUV+yMGd
	cgxAJFYz0bo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8EDF550AC;
	Thu,  5 May 2011 12:02:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8ED0750AB; Thu,  5 May 2011
 12:01:59 -0400 (EDT)
In-Reply-To: <m3sjstv7kz.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu, 05 May 2011 02:08:32 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03FBBB10-7731-11E0-89EF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172842>

Jakub Narebski <jnareb@gmail.com> writes:

>> Rerolled.  Waiting for comments.
>
> Should I extract first two commits i.e.
>
>    - Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
>    - git-instaweb: Simplify build dependency on gitweb
>
> into a separate patch series?  Even though their existence was
> ...
> I think this cleanup is worthy on its own.

Sounds like a good idea.  Thanks.

>> * jn/ctags (2011-04-29) 6 commits
>>  - gitweb: Optional grouping of projects by category
>>  - gitweb: Modularized git_get_project_description to be more generic
>>  - gitweb: Split git_project_list_body in two functions
>>  - gitweb: Mark matched 'ctag' / contents tag (?by_tag=foo)
>>  - gitweb: Change the way "content tags" ('ctags') are handled
>>  - gitweb: Restructure projects list generation
>> 
>> Waiting for comments.
>
> Should I do and post benchmarks for
>
>    - gitweb: Restructure projects list generation
>
> change (when 'forks' feature is used)?
>
> Note that "gitweb: Mark matched 'ctag' / contents tag (?by_tag=foo)"
> has ACK from Petr Baudis ('pasky').

... meaning the first three in the series?  I missed that.  Thanks for a
reminder.
