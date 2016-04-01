From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/7] t0027: TC for combined attributes
Date: Fri, 01 Apr 2016 15:22:47 -0700
Message-ID: <xmqqegapgea0.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459526908-19907-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Sat Apr 02 00:22:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am7Sx-0000HX-EM
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 00:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbcDAWWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 18:22:51 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752585AbcDAWWu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 18:22:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C89794F7B7;
	Fri,  1 Apr 2016 18:22:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4uwd5LRzcu4Cwa3JolIFPq2KgSM=; b=VhSg4T
	OUvaT/mGrYLIuhO/Oov+ZbT+R19rq/cjpxpRKn+Ksnet9bwSk9ZzqkcC77j1RF8L
	6e3HtTBTRQeq0Bewze3EIzEyl8gErZ+UItnxbMyqWAeKddMNn0EDHMSuQv4jMoIU
	tNACgdDb7vTzDbK5fDYbXHOWOvihzmjAWI5RA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rbUf2+j9/sZZDTusmk3wV4P5UqD1QqJu
	QzBfYWKS417zKTx0ngp2kRW9lvmBS4cte3gzqqy2PtFc4gbvy+PNI6hF5Ph5B7kr
	3ukawmkJdNNYQqpFtikfi0EByJibtzMVh7pmnSkcu+3A8yz8MvK/J2rypbrNLrVL
	tS17SdiDYq8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0BE44F7B6;
	Fri,  1 Apr 2016 18:22:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3A4024F7B5;
	Fri,  1 Apr 2016 18:22:49 -0400 (EDT)
In-Reply-To: <1459526908-19907-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Fri, 1 Apr 2016 18:08:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 445E6B32-F858-11E5-9D8D-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290585>

tboegi@web.de writes:

> +for crlf in true false input;

Style: lose the ';' at the end (there may be other instances of the
same).
