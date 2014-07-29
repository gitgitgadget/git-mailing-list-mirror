From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] refs.c: write updates to packed refs when a transaction has more than one ref
Date: Tue, 29 Jul 2014 14:11:14 -0700
Message-ID: <xmqqzjfr27m5.fsf@gitster.dls.corp.google.com>
References: <1406310926-4080-1-git-send-email-sahlberg@google.com>
	<1406310926-4080-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 23:11:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCEgA-0005Ox-Kk
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 23:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbaG2VLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 17:11:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56510 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbaG2VLW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 17:11:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EFD982CFDD;
	Tue, 29 Jul 2014 17:11:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GsAyCzxWmVMHZhu9XDNp2MOhcFM=; b=fUt7ox
	o/QeIsmShLUjdY/TbKwisWL1fC0TfvcNkzFcEU7BATQ3KCjpBhUvRttHA9kq0QSH
	TL84v7eYrklIxqNdeB0B/dLMzcFNtCO4saSt4sA1T1wFRLjMnQo4BvwJyCRgDs3/
	ttUlGGoBbbVQzvIOE+yCLr69JmJH1yN+qQ38Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r/lBs1YkOiG0rc+6mGK0hoFH4FSuDxC7
	zW0TRm/5DZbyGiiyK1tai4xovys7+0M0AjwFDXtF4hKO2zYzW5wBaq/alvZnNVQK
	/FJn7LfxtwkGt/HhDET8+IlRSM8tY/xIDugrpb4Sv2dxpmPo4110rc8o7ejpwpiw
	ujD7i0+mRjg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E54282CFDC;
	Tue, 29 Jul 2014 17:11:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 961372CFD7;
	Tue, 29 Jul 2014 17:11:15 -0400 (EDT)
In-Reply-To: <1406310926-4080-3-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Fri, 25 Jul 2014 10:55:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E05C1CCC-1764-11E4-8617-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254471>

Ronnie Sahlberg <sahlberg@google.com> writes:

> +		packed = get_packed_refs(&ref_cache);;

s/;;/;/; ;-)

Sorry, I couldn't resist the urge to type many semicolons ;-)
