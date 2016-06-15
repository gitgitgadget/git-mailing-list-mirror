From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2016, #04; Tue, 14)
Date: Wed, 15 Jun 2016 11:32:39 -0700
Message-ID: <xmqqd1ni716g.fsf@gitster.mtv.corp.google.com>
References: <xmqqtwgv77az.fsf@gitster.mtv.corp.google.com>
	<20160615023658.GA21270@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 20:33:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDFcv-000080-MG
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 20:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883AbcFOSdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 14:33:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933012AbcFOScx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 14:32:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C1D321521;
	Wed, 15 Jun 2016 14:32:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pgkSXWMJpcYKFpqqaZC4lFyGUfU=; b=HX/UjP
	8Ym6Ap5Z0MYYZC9VDSjSv+FRzu4z//yz6sQ3zGtsmOaqqzhjWoaoQ+dhjz5vnWPb
	ZLUqtzXFnsHEAUkqwuJnRsb/STUHl4epiI8+WnjrGR5uwq0uoJLhAZNnB7NStlbj
	UzdCgtjLqfu8EuYKkUbGUMGv+R60aPQ2ErSEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LYjXE5BqerM+mw5WmqM0uk/CvaSv1Xk4
	q2T0ltGfKPiEpOuhcopJm8sK8AhlQ8eMPf7ngXmPfk40y8g6vjd44YhYTAqRqcVn
	cNkHcZVHxC/xo8ppJoVHlUpKMCARJ2zu59+eumq4rfPLPsYOdobmW7W7d4l1e35Y
	upU6U+69VyM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83CFB21520;
	Wed, 15 Jun 2016 14:32:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C57A2151E;
	Wed, 15 Jun 2016 14:32:40 -0400 (EDT)
In-Reply-To: <20160615023658.GA21270@glandium.org> (Mike Hommey's message of
	"Wed, 15 Jun 2016 11:36:58 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B06E1E0-3327-11E6-B5E0-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297387>

Mike Hommey <mh@glandium.org> writes:

> On Tue, Jun 14, 2016 at 03:08:04PM -0700, Junio C Hamano wrote:

>> * mh/connect (2016-06-06) 10 commits
>>  - connect: [host:port] is legacy for ssh
>> ...
>>  - connect: document why we sometimes call get_port after get_host_and_port
>> 
>>  Ok, folks, is everybody happy with this version?
>
> $gmane/296609
> $gmane/296610

Oh, I have seen these, and I know you two are happy.

But I am having a hard time coming up with a few-line summary for
this topic.  I can write the beginning part, i.e. "Git-URL parsing
routine has been rewritten", but the concluding part of the sentence
cannot be "... has been rewritten for no good reason." if I were to
mark the topic as "Will merge to 'next'".  The best I can come up
with is "... has been rewritten (hopefully) without changing the
benaviour.", but that is not a strong-enough justificaiton to make
the change to the codebase, either.

In short, while the update may not introduce new bugs, why would we
want to have this change in the first place?

By the way, please do not quote the whole thing when you are
responding to a tiny part of the original message.
