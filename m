From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] Teach rebase the --no-ff option.
Date: Wed, 24 Mar 2010 14:45:33 -0700
Message-ID: <7vr5n9xuki.fsf@alter.siamese.dyndns.org>
References: <7vaatxskwc.fsf@alter.siamese.dyndns.org>
 <1269462844-13468-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 22:46:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuYOd-00073q-Ag
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 22:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab0CXVpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 17:45:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab0CXVpp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 17:45:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76AC7A4253;
	Wed, 24 Mar 2010 17:45:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8q1nzDYouF77w5s21L+byYajWQE=; b=X1u3Fd
	4U77NMrRI5rByf8X1ypDIB0vJ483BE2OPs0zSvw0xh3wK2VE5eo7YZILbPzVrNcX
	ZjoaZWwQrJjtIFsBUzqnfFu1CBUUJy5E7Q10N5MPE0y5zKQye83/KSMDDNK9Y4iG
	E30N21UjLJmIrI8WnHaJu+zZKJSTZ+tg/NSys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b4JAGLE8Ef9bZWLTovkdPV7eX2B1mCHu
	gXD/CsscI/VeUMhc4qeHMDbLa3XDh7WkBCCi6Xvg+NPfDRiqWRnAmF8aq5lydhaO
	Ugw+3niNesnnqRBJhfL60ICWbrRp7tAzjEG8V9/WP/OhNLLHc+hNUSb/tBorHGMY
	6T11Z6WiqLU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16262A424B;
	Wed, 24 Mar 2010 17:45:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14B1BA4245; Wed, 24 Mar
 2010 17:45:34 -0400 (EDT)
In-Reply-To: <1269462844-13468-1-git-send-email-marcnarc@xiplink.com> (Marc
 Branchaud's message of "Wed\, 24 Mar 2010 16\:34\:04 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 96D140EC-378E-11DF-BABE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143132>

Marc Branchaud <marcnarc@xiplink.com> writes:

> For git-rebase.sh, --no-ff is a synonym for --force-rebase.

Thanks, will queue.
