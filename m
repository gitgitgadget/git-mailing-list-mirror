From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: set PERL_PATH and SHELL_PATH unconditionally
Date: Tue, 20 Oct 2009 09:18:29 -0700
Message-ID: <7vtyxuox7u.fsf@alter.siamese.dyndns.org>
References: <7vr5syshat.fsf@alter.siamese.dyndns.org>
 <1256029588-24128-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:18:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0HQ8-000191-8c
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 18:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbZJTQSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 12:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbZJTQSg
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 12:18:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbZJTQSf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 12:18:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A07A604F2;
	Tue, 20 Oct 2009 12:18:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i5Fd3X7+GgjKqEaULy0qNWa1Qeg=; b=iFQL9l
	yLx9GXQume5ApV6F1ONzY8DihhEjY2xQSyJxpMHq1gIEDw2fwQn7YVeCdseunPgx
	1lZ7u3PfFsjHkJ3Q4pbmhNMHzp1HXKi6XBibsHuytz+bjjsaxvuNfa8gArH1moIC
	WqSPja8NT/dzjJlz81pWu/K/ABBaQMqndydJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QN8QrvSQOyeo0p6hV1xZZFlFrq46b9Vz
	6UlN4OwoJkAb5DrhNBgSX5GpJq2L7yvfaLGcurrNnuS0q5P1SaCTMOvjD3Fjr+/+
	WZbtOVZuaMbSQuuN/1fYH81ZtxM+hWupsoowGC2SC7OSWAlk2r80e0a00dfPlQWU
	TByeXiaoFOs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BF09604F1;
	Tue, 20 Oct 2009 12:18:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84ABA604EF; Tue, 20 Oct
 2009 12:18:31 -0400 (EDT)
In-Reply-To: <1256029588-24128-1-git-send-email-kraai@ftbfs.org> (Matt
 Kraai's message of "Tue\, 20 Oct 2009 02\:06\:28 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 36DBCE1A-BD94-11DE-ACF7-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130805>

Matt Kraai <kraai@ftbfs.org> writes:

> Do not check whether PERL_PATH and SHELL_PATH are undefined before
> setting their default values.  This prevents them from being set via
> environment variables.

Is there an upside of "preventing them from getting set", by the way?
