From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] build: trivial cleanup
Date: Sun, 09 Jun 2013 16:07:03 -0700
Message-ID: <7va9myopd4.fsf@alter.siamese.dyndns.org>
References: <1370731138-32681-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 01:07:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulohf-0005KN-5x
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 01:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab3FIXHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 19:07:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371Ab3FIXHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 19:07:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C641F26648;
	Sun,  9 Jun 2013 23:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5hUXPidfE1CvXqY1KlylVmlWk1k=; b=qBDUY/
	Wou4tXQTPzcmSl40PTi1znxlgpF+gJcTTjrvOgBW0ykgzByb3hlra4emaqinc1/4
	YJnY49x33DYfRILrg/7KRvNDxtYNj3mtPRA1egmyQOwOURxC4YPsUgoWzzXGdwnh
	zkB/q+vn7ZOVQIZL3E1KtR4IO2HFJ4/Oa1Vg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pwopYxv7AK9xm9b94c0WoxcL916ZnoXf
	3851R8i5mdc2AzyUCOGiwuXK9Q2dFkUGFdmWFUGw4H4v+Ap1+AHZ2ltlK5SBQNuU
	2wbpDclwqak+kZpugQfHH29RB0kn5P3WkROkrV2KrQUfu8r40mVc3YYzTR05mX6K
	B0XyK/ecs3M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC8C626643;
	Sun,  9 Jun 2013 23:07:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34EDA2663E;
	Sun,  9 Jun 2013 23:07:05 +0000 (UTC)
In-Reply-To: <1370731138-32681-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 8 Jun 2013 17:38:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D369F28-D159-11E2-BB4B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227206>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There's no need to list again the prerequisites.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Makes sense. I'll retitle to keep shortlog a bit more information
rich while queuing the patch, though.

Thanks.
