From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 13:13:46 -0800
Message-ID: <7v1ueol6ut.fsf@alter.siamese.dyndns.org>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-2-git-send-email-chris@rorvick.com>
 <7vhanlnnz7.fsf@alter.siamese.dyndns.org>
 <17103971665F4C4495C6C96086A58B8F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Chris Rorvick" <chris@rorvick.com>,
	"Git List" <git@vger.kernel.org>,
	"Andrew Ardill" <andrew.ardill@gmail.com>,
	"Tomas Carnecky" <tomas.carnecky@gmail.com>,
	"Woody Wu" <narkewoody@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:14:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tki0m-0004Pj-6A
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 22:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582Ab2LQVNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 16:13:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180Ab2LQVNu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 16:13:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3996A930F;
	Mon, 17 Dec 2012 16:13:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c4BrJmeD+NKKtknmmXSzLm3md4I=; b=eg0NyD
	meQozeYy2MOCsqLTI4fDcEETyGD3a+Ku6tIKULAZj7b7IaglkwuGVevA3yP/vS4Q
	RfyOD9lezJcDFFsqjEttHdV+xodBGXvztRTOEH0AKcFtqWnuVwt8q+5g59Vctu5V
	e9k+03R+HE7+ZLee4q5wNZMxxaneGwfzyCJwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oE9qPQV7ejuvRPdHDDn6R87pdCs4Z+W5
	AHCDYsvQqSXxR+7cU/asH+Q0TK7P1MAfjo2iQoGpW9H1BA+1mslh0ZlqzJZeJw9r
	3sb3YO5q40F/x073QjcBkqRZKHMDGfO1KWnrjxOmV3TIUlkKQUcldZu+/L51GqZH
	ADja0Hdcs+A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26B31930E;
	Mon, 17 Dec 2012 16:13:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9553E9309; Mon, 17 Dec 2012
 16:13:48 -0500 (EST)
In-Reply-To: <17103971665F4C4495C6C96086A58B8F@PhilipOakley> (Philip Oakley's
 message of "Mon, 17 Dec 2012 20:51:32 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A63E8F80-488E-11E2-9995-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211703>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com> Sent: Monday, December 17,
>> This is to "check out the branch" ;-)
>> ...
>
> From a user perspective it's better to refer to the working directory
> first rather than the internal mechanics.
>
>    Prepare to work on <branch>, by updating the files in the
>    working tree and index to the branch's previous content, and
>    pointing HEAD to it.

I agree that the mention of "pointing HEAD to" may be better to be
rephrased in the user facing terms.

Because the primary purpose of "git checkout <branch>" is to "check
out the branch so that further work is done on that branch", that
aspect of the behaviour should be mentioned first.  Updating of the
working tree files and the index is the implemenation detail of
starting to work on that branch.

So your suggestion is going backwards, I'd have to say.
