From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Corrections to the mailmap file
Date: Fri, 12 Jul 2013 09:27:01 -0700
Message-ID: <7v7ggvoiay.fsf@alter.siamese.dyndns.org>
References: <7vzjttq9wk.fsf@alter.siamese.dyndns.org>
	<1373629769-23647-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 18:27:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxgBb-0001hg-EY
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 18:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834Ab3GLQ1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 12:27:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932612Ab3GLQ1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 12:27:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DC4030C6E;
	Fri, 12 Jul 2013 16:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qrE15GQH8WLFM5UIKru9mlTCKDY=; b=dRLUfW
	xrJwVIshABlMHbuqGvrk0xAPIfLwTRt3h8jj4Dh0zxOKHXQGcCgevWmaef88g3Rj
	xZnXMvK4kboROykvMlU0WdSRy35V8XRZLliOw1kUs9y1nkpsNa3Ne6Yf7EKBiYqN
	lSBldD02oiYqXcdymu8OrTGoEyESoOG/8vFbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C6oPDIjAEqVjcPqW7cclj9ihjqxmU2Js
	u2dU5/Vzbcp9m7SUocg/01dLYMYj5wwA2My36DuOM4gGXi5zflEWWuJHs2pGH87F
	hrHvb4rCNZDlss17XSGUoNRhX1Fj3DtKHsk35HBggqsrvdyVgqqn1A4Jj70WOil+
	tAGYlai+Z54=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1389A30C6D;
	Fri, 12 Jul 2013 16:27:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EAC230C6C;
	Fri, 12 Jul 2013 16:27:03 +0000 (UTC)
In-Reply-To: <1373629769-23647-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Fri, 12 Jul 2013 13:49:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2A3C0A2-EB0F-11E2-A3A3-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230204>

Stefan Beller <stefanbeller@googlemail.com> writes:

> By now I contacted more than half the people, who might
> get some .mailmap entries. Not all of them have responded,
> but maybe 2/3 of those, whom I contacted.
>
> I used 2 branches to get this work done. One branch having
> all the proposed patches, where each patch just changes one
> name, so I can send it to that specific person for review.
> The second branch would be slightly behind the first branch
> and only have the patches of the confirmed .mailmap changes.
> The following patch is a squashed version of the confirmed 
> branch.
>
> Whenever somebody confirmed their patch, I'd include it
> into the confirmed branch and rebase the first branch on top
> of it. That works fine, if there are no many commits
> in between, so no merge conflicts occur.
>
> Junio, therefore I'd ask to include the following patch as 
> the 1/3 milestone in the mailmap completion, so the number of
> my local patches floating around is reduced.
>
> The 6 patches sent at 4th July are not required anymore,
> but the following patch directly applies to your master branch.
>
> Stefan Beller (1):
>   .mailmap: Map email addresses to names
>
>  .mailmap | 95 ++++++++++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 71 insertions(+), 24 deletions(-)

Thanks.
