From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add grep.fullName config variable
Date: Tue, 18 Mar 2014 13:16:35 -0700
Message-ID: <xmqqmwgn6z4s.fsf@gitster.dls.corp.google.com>
References: <874n2w3abu.fsf@igel.home>
	<xmqq7g7sbh56.fsf@gitster.dls.corp.google.com>
	<mvmy507stf1.fsf@hawking.suse.de>
	<xmqqzjkn8i78.fsf@gitster.dls.corp.google.com>
	<87d2hj9tfg.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Mar 18 21:16:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ0RK-0000Ue-2Q
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 21:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757478AbaCRUQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 16:16:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757169AbaCRUQk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 16:16:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84F4373E1E;
	Tue, 18 Mar 2014 16:16:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bTbdwW2z9zFaZgThnf6LaZwBKvI=; b=BThHM3
	tzMgPq1tX4tPImTXcIn8icumqE+/srfvlhmRTdJO6ns8BlME4L0b9a/P6B7Wbvwb
	+Tf29mr3R3jt/aGetkJeQmBeXnf7QO1M1c2DuMSO4vY6VufpfgmiKQsbvkLjiW4F
	V0mLHCz2fR3jzaDuL7oMuD9w9ul1uehMYlGEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V+IbKrf1sHDCPR7PVgjgsfo4bY58cIL9
	g7mOmfO78s/FAVhkOHJk3mVU3MVy4dKt2pV2oWRmSN1Rl3dFjbq2O01Rj36huXUp
	ucZrn6DZIaOvnakmeJpzVXsaFpzgMOgnPOPaw+ov6g+STaH689MzivIICE9osBuI
	viSjGQX6YB8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7751A73E1C;
	Tue, 18 Mar 2014 16:16:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1E8B73E0F;
	Tue, 18 Mar 2014 16:16:38 -0400 (EDT)
In-Reply-To: <87d2hj9tfg.fsf@igel.home> (Andreas Schwab's message of "Tue, 18
	Mar 2014 20:51:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 363DD4B2-AEDA-11E3-9E18-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244381>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Don't we have the exact same issue for the editor, by the way?
>> Shouldn't we be running it in the original subdirectory as well?
>
> It's called with an absolute name, so it shouldn't care.

But we should not have to call with absolute paths when a short and
sweet pathname relative to the user's current directory. That is the
primary point of my comment.
