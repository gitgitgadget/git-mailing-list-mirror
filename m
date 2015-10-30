From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Handle p4 submit failure
Date: Fri, 30 Oct 2015 10:57:59 -0700
Message-ID: <xmqqy4ekkzmg.fsf@gitster.mtv.corp.google.com>
References: <CAJA=mv4Tr_DoBMwR8hK_fEJ1PFCYTu17HHvEnFWMANGFcf0Wpg@mail.gmail.com>
	<xmqqeggcmhle.fsf@gitster.mtv.corp.google.com>
	<CAJA=mv7ydNCm-yy9Ukk2XB-xvAJ1VkyqHEGcCTA2PEg=5y9cFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Pete Wyckoff <pw@padd.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Etienne Girard <etienne.g.girard@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 18:58:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsDwI-00030B-FG
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 18:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760065AbbJ3R6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 13:58:04 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760062AbbJ3R6D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 13:58:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2AFD26C0B;
	Fri, 30 Oct 2015 13:58:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LZ/ijlTlXfIEvbo+Vrpg19c1Lc8=; b=J9DEHD
	R2Nuu6Ck7NDMcHUeH3jo1/ZWyDoIO99QAxdzzZqNPM5HxWN5q7zmYpYAslVPjzeV
	C+JOpTwbWg3/cVFyYdinNcTTVBp9SFVRgchNK6ObD6gEybmF0oFKr8KdbJ+XstAf
	Cl7zM4izvXV7ZFOgqUcE+DELj0CPia29tXWic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X4ApxkOFbJlEo8lP5wIGcOpsxoM45sm8
	5OqZ9lWWqPutSnHFzFwOkAuy/kYso2McxoQFo1mpHe8SG61Kq5JAmwE5QraKHtIJ
	A+3xI2LXgOR5eJYHQeuWJ/5vK0PhFqTl1E4uh8NtkJsYXBtmcKrIxRVoXqpKSuYc
	pvZAGhjWrK4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A99F426C09;
	Fri, 30 Oct 2015 13:58:01 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 99B7B26C08;
	Fri, 30 Oct 2015 13:58:00 -0400 (EDT)
In-Reply-To: <CAJA=mv7ydNCm-yy9Ukk2XB-xvAJ1VkyqHEGcCTA2PEg=5y9cFQ@mail.gmail.com>
	(Etienne Girard's message of "Fri, 30 Oct 2015 18:33:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C267FF7C-7F2F-11E5-95C0-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280501>

Etienne Girard <etienne.g.girard@gmail.com> writes:

> Yes, however if `p4 submit` fails the corresponding "Command failed"
> error message is displayed, and the p4 error message itself is
> displayed if any.
> Tthe script will also terminate successfully if self.edit_template
> returns false but it will exit with error code 1 if p4 submit fails.
>
> So the user will get "Command failed: [...]" followed by "Submission
> cancelled, undoing p4 changes", to let him know that the script failed
> because of p4 and that nothing was submitted.

OK, then it sounds like all I have to do is to update the log
message with the "How about this" version and correct the authorship
to use your murex address, and then wait for reviews from real "git
p4" reviewers.

Thanks.
