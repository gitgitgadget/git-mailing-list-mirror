From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2009, #01; Wed, 07)
Date: Thu, 08 Oct 2009 23:46:10 -0700
Message-ID: <7vk4z56p59.fsf@alter.siamese.dyndns.org>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org>
 <m3iqepgxcc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 08:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw9G4-0003ce-Td
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 08:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbZJIGrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 02:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbZJIGrB
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 02:47:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbZJIGrA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 02:47:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE4C470423;
	Fri,  9 Oct 2009 02:46:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MQpEsiox4sgPUSKBFJUdnbyMkjI=; b=tA9gJT
	UP/Gy8zgvTypdFPcNR2KpAqX9Fb/+1Ag74izdNktkcG04YFVjCAdUteBr5BYVqtF
	fr4+0hY3S50qAF1QTr97rjV6lLc0UdgV4NTdeYqYb6cdAm2aPzWD+HuQ9JooZBrj
	DDi/E9Kd4W7cklYJU6OjfaLCnvZapMPgk/Bxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S17HgD0PCOnYinccc+2bFphCrEo3HUQv
	sYV4ZVkfmG7S35Fg+lq8YXAJZ7xapUl/cJES27BUqgGQHXvf/3+DdSSRBiGWEjRJ
	ko21T200zQMRI3zVwD8sXl7vSLbHfa3X8bRr65oqi9i+7PtKndxj6zaqfoqKM99V
	FCPKOJkFMgk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0C5F70422;
	Fri,  9 Oct 2009 02:46:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BD2A670421; Fri,  9 Oct 2009
 02:46:11 -0400 (EDT)
In-Reply-To: <m3iqepgxcc.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu\, 08 Oct 2009 18\:38\:48 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7082F8DA-B49F-11DE-8D60-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129739>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> --------------------------------------------------
>> [New Topics]
>
>> * jn/gitweb-patch (2009-09-30) 1 commit
>>  - gitweb: Do not show 'patch' link in 'commit' view for merges
>> 
>> jk: After some comments with Jakub, I think the code is right but he
>> promised a re-roll with more in the commit message.
>
> Not only better commit message, but a more complete patch as well.

Ok; I'll wait.

>> * mr/gitweb-snapshot (2009-09-26) 2 commits
>>  - gitweb: append short hash ids to snapshot files
>>  - gitweb: check given hash before trying to create snapshot
>> 
>> jk: He posted a v5 of his series. I didn't look at it closely, but Jakub
>> ack'd it.
> ...
> In short: first patch is a go, second needs more work.

Ok; I'll merge fdb0c36 (gitweb: check given hash before trying to create
snapshot, 2009-09-26) to 'next'.

>> * jc/pretty-lf (2009-10-04) 1 commit
>>  - Pretty-format: %[+-]x to tweak inter-item newlines
>> 
>> I am not happy with this one yet.  I am contemplating to introduce a new
>> syntax "%[magic(param)<anything>%]" to generalize expressions of this and
>> line wrapping features in an extensible way.
>> ...
> So... it is magic %[...%] or %{...} or %{...%}?

The escape does not matter. %() is fine, too.  It is non-essential for the
purpose of the upcoming release so I have backburnered coming up with and
thinking the details through.

>> --------------------------------------------------
>> [Cooking]
>
>> * jn/gitweb-show-size (2009-09-07) 1 commit
>>  - gitweb: Add 'show-sizes' feature to show blob sizes in tree view
>
> What this one requires (beside better name for a feature)?

Name before 'next', and then the usual cooking, I guess.

>> * jn/gitweb-blame (2009-09-01) 5 commits
>> ...
>> Ajax-y blame.
>
> I reordered patches so JSMIN one is first (as it is less
> controversial), but the 'create blame_incremental links' one needs
> more work.

Ok; I'll wait.

Thanks.
