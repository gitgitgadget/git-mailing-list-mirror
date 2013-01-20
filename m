From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aw: Re: [PATCH 1/2] Change old system name 'GIT' to 'Git'
Date: Sun, 20 Jan 2013 13:08:33 -0800
Message-ID: <7vvcark1f2.fsf@alter.siamese.dyndns.org>
References: <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 22:09:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx28P-0004fw-OH
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 22:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab3ATVIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 16:08:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab3ATVIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 16:08:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB1D8A733;
	Sun, 20 Jan 2013 16:08:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fftrDv1zfE7LeP/ZZ76ulnxMbec=; b=bvurmA
	e39SBdkuf/xl9XXRLdO8lIlgAwu/+7jlPlTqFyatSSEgmn6D2bba3no3zZFMbrFe
	i2QsRdJaVWWyODY3swOFI4nsUJRVT6Vjoww0lkm9HuJQi3Jgj7qKeoPcFaP9pFNA
	X6rrX1soSli0vgsi7noTSxPfKueyWmg+ggJUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QHupb9vYuK7ut/RjL7SkbuPzrFv6gMLw
	cci7d8FluETC0rxdEOJGjo6ylC/y/y7xNnGzzgRG5/WGjB+mI99T3o5S+dVUd8+y
	QaQgrmC9DOv/s/nSxCw7nT4tNKN3PywwBa5bEdqWSPrzG8uzGYgsqjAMPngEIDyP
	wNcA9Mp1uX8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7E7EA732;
	Sun, 20 Jan 2013 16:08:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CBD3A730; Sun, 20 Jan 2013
 16:08:35 -0500 (EST)
In-Reply-To: <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 (Thomas Ackermann's message of "Sun, 20 Jan 2013 21:16:50 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DA0994C-6345-11E2-873C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214050>

Thomas Ackermann <th.acker@arcor.de> writes:

>> If I were to decide today to change the spellings, with an explicit
>> purpose of making things more consistent across documentation, it
>> may make sense to use even a simpler rule that is less error-prone
>> for people who write new sentences that has to have the word.  How
>> about treating it just like any other ordinary word?  That is, we
>> say "git" (without double-quotes, of course), unless it comes at the
>> beginning of a sentence?
>> 
>
> The widely used books on Git by Scott Chacon or Jon Loeliger (and
> many others) are using 'Git' instead of 'git' when talking about the 
> whole system. So IMHO it would not be wise to change our internal 
> documentation from using 'GIT'/'Git' to using 'git'. The internal 
> documentation should be a natural continuation of these books 
> by content and style.

That argument is going the other way around (we _are_ the
authoritative source).

But I am OK with "Git" as a proper noun (which always begins with
capital letter), using "git" only when it is something the user
would type.  Just come up with a simple-to-explain rule so that
people will have no doubt which one to use in their new text and
stick to it.

Thanks.
