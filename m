From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Corrections to the mailmap file
Date: Thu, 11 Jul 2013 11:16:24 -0700
Message-ID: <7vppupq7wn.fsf@alter.siamese.dyndns.org>
References: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com>
	<7vzjttq9wk.fsf@alter.siamese.dyndns.org>
	<51DEF0F1.5010204@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 20:16:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxLPu-00024o-Up
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 20:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363Ab3GKSQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 14:16:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39679 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756354Ab3GKSQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 14:16:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB4F83021A;
	Thu, 11 Jul 2013 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i/ATyuemPVBDmgBXqRd7RkWZzP4=; b=Jg7CJI
	H0ZFA/RTjwq1pl995oBzOFCjt2jlDKGIScpveVAYN+D+vlgOct+VqC6iieCqaksE
	NPCTsKzFgFNPLHsokmYfEghNv2TLC4ma6eFX0meFmbs96UsCwPT5v8V0keYp4ifl
	YUj66m7nZFV3qcFy5tFZSMY97ZgZJ4f2YukCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a7UsYtg1nKNcvlsgBzvnF7ZrISVFQTww
	nIA/Yui9Or7XyNQGLbP9JoI2ym5gj2muHo4WpBMfGqch/6BEhryyw1bM+4oYRYV2
	U3FGwVWDrFeIcQFw2GMTUT7vfTnhrPRteJUOFQ9nqIO4N29wGw/1mwHuXBV1r/vq
	54PFgfmL2Rs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFB6130219;
	Thu, 11 Jul 2013 18:16:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ACA730214;
	Thu, 11 Jul 2013 18:16:27 +0000 (UTC)
In-Reply-To: <51DEF0F1.5010204@googlemail.com> (Stefan Beller's message of
	"Thu, 11 Jul 2013 19:52:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00AEB972-EA56-11E2-966B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230124>

Stefan Beller <stefanbeller@googlemail.com> writes:

> On 07/11/2013 07:33 PM, Junio C Hamano wrote:
>> Stefan Beller <stefanbeller@googlemail.com> writes:
>>> ...
>>> I intend to contact each of the persons individually and ask whether 
>>> just their mail address changed, or if they are indeed different persons.
>> 
>> Has anything happen to this topic sice you posted?
>>  ...
> I do see the benefit of the openess, when discussing code 
> or documentation, but I wonder if you'd also like to see these
> 'Hello, are you the person having email x, y and z?' 
> kind of mails put on the mailing list as well. 

I read, from your 'I intend to contact ... individiually', that you
would have already sent such private inquiries.

I was reviewing my mailbox for possible "fell into cracks" topics,
and found that nothing seems to have happened since then. I guessed
that since they you may already have received responses to allow us
to move forward with this series, hence my "ping".

I do not see a need for "are you still at this address?" to be made
in public.  It is fine and probably even preferrable to see a single
patch that corrects multiple .mailmap entries, with a proposed log
message that says "I've contacted everybody whose address is
affected by this change and made sure the replacement address is
correct."  We trust you ;-)

Of course, you may want to Bcc: such a patch to them to give them
another chance to double-check as a courtesy.

Thanks.
