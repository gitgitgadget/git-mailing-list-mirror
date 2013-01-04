From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: give --reroll-count a short synonym -v
Date: Thu, 03 Jan 2013 16:00:40 -0800
Message-ID: <7vpq1lvmtz.fsf@alter.siamese.dyndns.org>
References: <1357166525-12188-1-git-send-email-gitster@pobox.com>
 <1357166525-12188-2-git-send-email-gitster@pobox.com>
 <A6A2DEC8F88743B88AA03DC5BD8547B7@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 01:01:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tquid-0007fi-Bi
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 01:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab3ADAAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 19:00:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722Ab3ADAAn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 19:00:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9FE4A5ED;
	Thu,  3 Jan 2013 19:00:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ETCx8oSwbCEj1I1J9VE+kEuseIc=; b=LLikO7
	XLdUH3tzYMmlVsLzP6gDSWTmsqN1WkOrN5DaPKZp9lfK8gGA3bldG9d8B4aQKoA5
	RlQ49IH2AuoZEQJgJ3SHsotjCJHpNhXLAIonbttInAwb2RbKISbsbHYlMlSeHFo6
	rPdP9It4e8m5kIWDVxWXLyTk+1sShZNoAJewU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xNufLQzY9jh2TaIuH2hmyueyYK87cbwI
	ILNk+8BGfm4j/gqLu4x64LqZz2Wt8gsw5JN4wxpfK4PVqpcYi0uDimxqbUffjgw3
	6Oynl7E/eM0nD46Am/6PdOa9tkYkwkvSrcPsd0n3tRn8IscL2PRSZJ+i3sgm1N+g
	xKAuEE9OC5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBE8BA5EC;
	Thu,  3 Jan 2013 19:00:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4776AA5EB; Thu,  3 Jan 2013
 19:00:42 -0500 (EST)
In-Reply-To: <A6A2DEC8F88743B88AA03DC5BD8547B7@PhilipOakley> (Philip Oakley's
 message of "Thu, 3 Jan 2013 23:21:35 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7E28274-5601-11E2-A361-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212622>

"Philip Oakley" <philipoakley@iee.org> writes:

>> +test_expect_success 'reroll count (-v)' '
>> + rm -fr patches &&
>> + git format-patch -o patches --cover-letter -v 4 master..side >list
>> &&
>
> Shouldn't this be using the sticked form -v4 as described in the
> commit message and gitcli?

I personally do not care too deeply either way.

Both styles seem to work, and if/when we break parse-options API
implementation, this test will break and we will notice, which might
be an added plus ;-)
