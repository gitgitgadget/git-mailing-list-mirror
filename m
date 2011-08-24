From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Looking for a way to turn off/modify ref disambiguation
Date: Wed, 24 Aug 2011 10:48:46 -0700
Message-ID: <7vr54apuo1.fsf@alter.siamese.dyndns.org>
References: <CAPRoxBXjL3Y3KRd8R2guX9Ar374sw-pBhz1bCzNZxn1vC6XNPw@mail.gmail.com>
 <7vei0brdiq.fsf@alter.siamese.dyndns.org>
 <4E54C373.1070702@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 19:49:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwHZa-0002Mw-Bx
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 19:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab1HXRsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 13:48:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816Ab1HXRst (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 13:48:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E02CF4163;
	Wed, 24 Aug 2011 13:48:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0vtu3Q+LAs0EeNFp1qSKaYyKLxo=; b=JMzS3w
	Z/2k5J/xd8vKPooQLtu60cv2ySKLkY6q3CXHzvWcwBnVFhO7n7M82kYn6P3R3VWK
	WjcQtAa5qUSBB5LVOSjjHfZlCQEj12EjSL9ekpzFnIOyiBbnTQhYlJDXqwPGUHHe
	OCF2dFwFou1dpGH4qiiEFnnotMiufcnCoIzsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n/JwQOPFhYHTJPQcTK9givAMFR149E72
	lVAIHB0CU/9DQ8DympEYIlRgMMF71HY/94zv/SWvOajWVxm1l8LCxUN1OqjJ4rI2
	7l55PYwpn4adV+t7DlHa/CBNd/M+4d5O20dHLSHLoPMGpQkSQyT7JGrHAASCp39N
	hPJvUdeWLtg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D695C4162;
	Wed, 24 Aug 2011 13:48:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F6F24161; Wed, 24 Aug 2011
 13:48:48 -0400 (EDT)
In-Reply-To: <4E54C373.1070702@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 24 Aug 2011 11:25:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 520268BE-CE79-11E0-89A7-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180019>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I haven't come across advice like that....
> I consider that advice very bad indeed:
>
> If "origin..master" is resolved to...

Perhaps origin..master was a bad example for you [*1*]; but the point is
you can say "origin" to mean the commit at the tip of the remote tracking
branch that the repository you cloned from deemed as its primary branch
anywhere we expect a commit on the command line.

So if you do not like "log origin..master", then say "git log origin"
instead and the point still stands.

[Footnote]

*1* "origin..master" is still a perfectly good example in tutorials to
teach people who use the workflow with a single at the central repository,
i.e. the simplest for esapee from CVS/SVN. You may have "frotz" topic and
"nitfol" topic branches locally cooking your own changes, and you can
measure their progress against the central repository with "origin..frotz"
and "origin..nitfol".
