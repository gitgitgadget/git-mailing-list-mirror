From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: add instructions to the commit message when
 editing
Date: Mon, 30 Jan 2012 13:52:54 -0800
Message-ID: <7vhazcamdl.fsf@alter.siamese.dyndns.org>
References: <7vd3a1caxb.fsf@alter.siamese.dyndns.org>
 <0c9a880c7dca27520f957446c6b0e72e93609b03.1327954927.git.trast@student.ethz.ch> <7vy5soaons.fsf@alter.siamese.dyndns.org> <878vkoamu3.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 30 22:53:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrz9q-0001La-3w
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 22:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139Ab2A3Vw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 16:52:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150Ab2A3Vw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 16:52:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A9E16250;
	Mon, 30 Jan 2012 16:52:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nXOd4Tdqfcmy1nL76NI54bVCpdw=; b=CSOoJm
	LOgC8DN7bW1Y/d49fciH7WdpIJLy+JhKGqjyPAEVru9fWk4/1s6ZcVEgLrTzkXlq
	OZ5Vl5tOb9w9NDf9rzx2Dh4tNt2/MJjQwyCcK+4MyFwECH8yh+ebVbmya/8GxAcQ
	rRBZtIRnw/QXG6oU45pubum/OeRynXvZ7fAsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UiQd2Oeg81ertyjzsozNLNvQe989T8xh
	wiIMFCMSXpczLy0fkiaaR3qJbUZhVCdABxR04/auqysf3EPMS7uUuP09MbVVeOop
	1rXLmQVC0YtItl1gsQUs9nLMjpgrjFBlnQjQvN1rsw2nMJ9/Sbpf5wd/g3OUi6jx
	SWVGUm5jtaw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AEEC624F;
	Mon, 30 Jan 2012 16:52:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6AA1624D; Mon, 30 Jan 2012
 16:52:55 -0500 (EST)
In-Reply-To: <878vkoamu3.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 30 Jan 2012 22:43:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C459F40A-4B8C-11E1-B2F8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189433>

Thomas Rast <trast@inf.ethz.ch> writes:

>>   Please enter the commit message for your merge commit.  Explain
>>   why the merge is necessary, especially if it merges an updated
>>   upstream into a topic branch.
>>
>> ... because people who need to be told to "justify it" would probably be
>> helped by a more explicit "explain _why_ it is needed".
>
> Why not.  The "explain..." might be construed as a bit too coercive, but
> I cannot come up with a way to defuse it (well, except again tacking on
> "you should") ...

Would "Please enter the commit message for your merge commit, to explain
why ..." work?
