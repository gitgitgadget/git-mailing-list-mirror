From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v3 [PATCH 1/2] status: introduce status.short to enable --short by default
Date: Mon, 10 Jun 2013 11:02:24 -0700
Message-ID: <7vvc5lj13j.fsf@alter.siamese.dyndns.org>
References: <vpqehcaf0wr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>, git@vger.kernel.org,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:02:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6QS-0006mG-8o
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab3FJSCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:02:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436Ab3FJSC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:02:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F526270DE;
	Mon, 10 Jun 2013 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5t9PG+0C3aUcVvwOdTH2yNxIr1I=; b=IfDZkn
	9cBxcpAt1LlT5vjNZfzgYZjZguGwTawaXcqr4kCDEmRCJfRZtGEhqo0QIKrPvl3Q
	e5H+SNsRPt6rBGjqQvarohx8j46kHE8GH88ZCdxlBUJ1RoVIHr9/QzYxqPveQzGb
	hPCVVInyhr7iNiRiTLi6ROkqkTQOdGbVaiRhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i7NpTZDz+tyk4UlIzynG9VnKMBYDfdO3
	nSEDKBDLGjq8OcqVWtSPOnjseYBSRAQLBZKAkahh6RDzEvHdaRM5jV4oRa2EtAps
	A4e8OFMVjsKKor7p3wmmigi/f6YOlB2LK8k2PeO7Ff/8oJ7br66duaAWul7QErNZ
	7keolsjNCsg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 725BF270DD;
	Mon, 10 Jun 2013 18:02:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7FB8270DC;
	Mon, 10 Jun 2013 18:02:26 +0000 (UTC)
In-Reply-To: <vpqehcaf0wr.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	10 Jun 2013 17:20:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8E4A106-D1F7-11E2-BE33-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227335>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> y@ensimag.imag.fr writes:
>
>> To: y@ensimag.imag.fr
>
> Common mistake, but you're not supposed to answer "y" when you're
> prompted for an email ;-).

Didn't we introduce safety against this in v1.7.12.1 and later?  Is
the new release taking more than 9 months to percolate, or are there
still other codepaths that allow this to happen that we need to add
further safety?
