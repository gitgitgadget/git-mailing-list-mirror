From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] git-remote-mediawiki: no need to update private ref in non-dumb push
Date: Thu, 29 Aug 2013 12:09:43 -0700
Message-ID: <xmqq1u5c48lk.fsf@gitster.dls.corp.google.com>
References: <vpqsixvfvdk.fsf@anie.imag.fr>
	<1377802704-30881-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377802704-30881-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 29 21:09:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7bL-0006If-B2
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 21:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab3H2TJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 15:09:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54544 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585Ab3H2TJq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 15:09:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 630D53DB72;
	Thu, 29 Aug 2013 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nkQgGX7P0RsEkwtofh/iWKQaJYk=; b=FzW2Pg
	DiYoNjzIYAl42MEHPio9uukFXR55vWQbifTG6tODWS4rRnwYVmSoxH/82rDOcKDD
	NvLtFjwA8+ea92VAvuJouJ7cUC4qU6OXTLyLxdiuJyRKwN/GGgJmnCfWMP3/4yz3
	I4CfeowWYWl+VrfZl4frumUNZ1I/Akz3oVpyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=snwLx57USBZn4vq0qjxkt+F/D4K6cQCG
	DOq4sdpWSWmc82REZQtF7tMhRzQKGBLaA0pkVICLcSVqSbWxqX5u4HeXXqiO5WSu
	7ZhQ+v8acbEXzA+BrX9q5cdughpCJi1wQy6izJd8XLQDtHSx4ycDMMkoOowwZFKB
	moI+rJsGf80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55C823DB71;
	Thu, 29 Aug 2013 19:09:46 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A03783DB6C;
	Thu, 29 Aug 2013 19:09:45 +0000 (UTC)
In-Reply-To: <1377802704-30881-4-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 29 Aug 2013 20:58:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 913BC562-10DE-11E3-9B6D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233342>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> We used to update the private ref ourselves, but this update is now done
> by default (since 664059fb62).
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

Thanks; will queue all four.
