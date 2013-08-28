From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar to disable display of #
Date: Wed, 28 Aug 2013 14:39:27 -0700
Message-ID: <xmqqmwo18pgw.fsf@gitster.dls.corp.google.com>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
	<1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq1u5da8dp.fsf@gitster.dls.corp.google.com>
	<20130828201803.GB8088@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	j.sixt@viscovery.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 28 23:39:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEnSk-0002YQ-L0
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 23:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040Ab3H1Vjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 17:39:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024Ab3H1Vje (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 17:39:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33C4A3DAC7;
	Wed, 28 Aug 2013 21:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2HzvYD2dijV87eGco9wD03RAa/E=; b=ey+Jvs
	OHyC7PO5BFuMDMO/7unNe4/UCumE7QXE+uUTEyCZA5TUBB3AZeloqqISwUQd2LqU
	KiOQooFNXvdvCbTk9GzXpxrH9be1di1IahIBC/67dcfs5bORvs2ry6D2XSYlraN7
	98Isyt/gx6d5AWU/9bU9+39t99JrnoAYbCdZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wZKcYtu1OGlDl2UpMSMkT4Hawo+oQDde
	sKPweNyPw8oNpXdSbvbX+aoOW2pxwEnDtZbCY9lXJarRrwb+AQPF1qcLbGQVJ/cW
	dV/m0x5iMMwL2OxrDv07OpgC4UbvGhIRy5u7I2khKPCrSyP3pP06tLpsHGWtdnTk
	qk2Tshh9HF0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 273EA3DAC6;
	Wed, 28 Aug 2013 21:39:33 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F3A83DAC3;
	Wed, 28 Aug 2013 21:39:30 +0000 (UTC)
In-Reply-To: <20130828201803.GB8088@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 28 Aug 2013 16:18:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 525B59B6-102A-11E3-95DF-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233220>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 28, 2013 at 01:05:38PM -0700, Junio C Hamano wrote:
>
>> What are our plans to help existing scripts people have written over
>> time, especially before "status -s" was invented, that will be
>> broken by use of this?
>
> I thought that our response to parsing the long output of "git status"
> was always "you are doing it wrong". The right way has always been to
> run the plumbing tools yourself, followed eventually by the --porcelain
> mode to "git status" being blessed as a convenient plumbing.
>
> I will not say that people might not do it anyway, but at what point do
> we say "you were warned"?

OK, sounds good enough.
