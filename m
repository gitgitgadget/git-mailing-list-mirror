From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] The images from picon and gravatar are always used over
 http://, and browsers give mixed contents warning when gitweb is served over
 https://.
Date: Thu, 31 Jan 2013 16:58:46 -0800
Message-ID: <7vvcacdf3t.fsf@alter.siamese.dyndns.org>
References: <1359416492-8597-1-git-send-email-admin@andrej-andb.ru>
 <7vtxq0u1v3.fsf@alter.siamese.dyndns.org>
 <CAGyf7-GJkKDWdykq8iv90tU3TUR5ZKUf2bQc9sJokbq-RFYBYg@mail.gmail.com>
 <20130129041206.GA15442@google.com> <7va9rrq1o3.fsf@alter.siamese.dyndns.org>
 <20130131012853.GD15680@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org,
	Andrej E Baranov <admin@andrej-andb.ru>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 01:59:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U14yF-0006BR-Kz
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 01:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264Ab3BAA6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 19:58:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36990 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339Ab3BAA6s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 19:58:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62098C257;
	Thu, 31 Jan 2013 19:58:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XH8Z78gHdU4v0KTIoh+Bi6r12iA=; b=JkOMga
	T+yNPFIQ2Ky1LYZ7BY+T/4TSYELU63d1AGY3uz0KHbab5/CPUHXqkxkjXaCfMiGK
	ak0Oz6+wBS2YFKKZNSMTO2TPLkOqeFd3ULmdOeGwnVqmSFVIsbI/1rtWzn0oG2OK
	83RKcV+teYPw0+cCUAov6oxk38su+flEVew2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YDh6OOd1FRgGeuda0IpRpUI/UWVTt8E0
	nrt9/Sz4Tb/JOQz12yY5ceaNueCWPuiJoCtLLFF6jlWQ+7jm0WxrfTXsXSqLUgeO
	chlLNR094w9Ttc/wGnuEKMIbAftVqJ3EcztyxQec+Mn8jLA99aG2z249V75M4vEw
	aGZi6PKYauw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5632FC256;
	Thu, 31 Jan 2013 19:58:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5C01C253; Thu, 31 Jan 2013
 19:58:47 -0500 (EST)
In-Reply-To: <20130131012853.GD15680@google.com> (Jonathan Nieder's message
 of "Wed, 30 Jan 2013 17:28:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89085848-6C0A-11E2-A2F8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215194>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Odd.  "https://www.gravatar.com/" also seems to work.  I've put in a
>>> technical support query to find out what the Gravatar admins prefer.
>>
>> Thanks; will hold onto Andrej's patch until we hear what the story
>> is.
>
> Good news: a kind person from Automattic answered that
> www.gravatar.com should work fine over SSL, both now and in the
> future, and promised to add updating documentation to their todo list.
>
> Thanks for your help and patience.

I'll merge Andrej's topic to 'next' in the next integration cycle.
The fix should hit 'master' no later than the beginning of next
week.

Thanks.
