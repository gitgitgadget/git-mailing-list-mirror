From: Junio C Hamano <gitster@pobox.com>
Subject: Re: When and how to to contact the Git developers (gist)
Date: Sun, 12 Apr 2015 23:01:32 -0700
Message-ID: <xmqqbnis4ldv.fsf@gitster.dls.corp.google.com>
References: <CAEcj5uW2Shh4QvtmenW2h6KXYUCoEe5bHYNv_HVFQgUit=cJ0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 08:01:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhXRD-0005ux-AV
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 08:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbbDMGBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 02:01:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751347AbbDMGBe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 02:01:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B9E393A9A1;
	Mon, 13 Apr 2015 02:01:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JStzxzC06WXXlTqeMk+S3nrp8nU=; b=RrBiKt
	NRIIlzigPKZlF7QmVFaC7xzgSltL9Nx9KF3/cVQMQWTsYMNKl6f0qdOhIoIxH79J
	jure7tEoMUs1yzy/98SuYvnQLs1lbl6JRLywOxX7++aW5oQEuB6xu2w5nw8cxFga
	9PWkjmJgLryYAVvQQ6gkNlUG13yKg5nYVYtd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z6tDqysqJZmhEXdA+gwCokP9rGOfglHU
	dAzycADKoUO0WLiV5n8+dJzeFDdigl/SSbTBzgk9XlP+L3UCqhi2Ow2xX1N6fFW0
	Lm1EcH1yRo3dkRuKwr6MvYvE+7UF1pv5o7w9S7mgaluQkgmRz2DpAPsLdePoe7Xs
	6NFsY3OgBGM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB55F3A9A0;
	Mon, 13 Apr 2015 02:01:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32DB43A99D;
	Mon, 13 Apr 2015 02:01:33 -0400 (EDT)
In-Reply-To: <CAEcj5uW2Shh4QvtmenW2h6KXYUCoEe5bHYNv_HVFQgUit=cJ0w@mail.gmail.com>
	(Thomas Ferris Nicolaisen's message of "Fri, 10 Apr 2015 15:40:17
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 894A3334-E1A2-11E4-B795-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267066>

Thomas Ferris Nicolaisen <tfnico@gmail.com> writes:

> At the Dev Summit, I mentioned this gist I've got lined up for
> whenever someone should consider sending an email to this list:
>
> https://gist.github.com/tfnico/4441562
>
> It's a handy link to share in some encounters, exemplified by Konstantin here:
>
> https://groups.google.com/d/msg/git-users/Md72iVvPHqw/Zi3yFIRrR2AJ
>
> I see that Peff already improved the git-scm.com/community late last
> year to cover some of the same points, but it is weighed a bit
> differently. Perhaps someone here would prefer to use my gist when
> redirecting people with "user questions" away from this list, or
> inspire them to write better bug reports.

As to "better bug reports", I often find people pointing others to

    http://www.chiark.greenend.org.uk/~sgtatham/bugs.html

Even in a better report that gives specific precondition, input,
environment and output, sometimes I see one thing that is crucial
missing: what the user expected to see and how the output is
different from that expectation.  Such a "bug report" may report the
designed behaviour, leaving the developers to scratch their heads,
"yeah, thanks for a detailed write-up, we can reproduce it exactly,
and everything is working as expected---how did you expect it to
work in what different way and why?".
