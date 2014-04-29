From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] PAGER_ENV: remove 'S' from $LESS by default
Date: Tue, 29 Apr 2014 10:01:05 -0700
Message-ID: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
References: <20140425154722.GC11479@google.com>
	<1398674062-24288-1-git-send-email-Matthieu.Moy@imag.fr>
	<87vbtt6dyq.fsf@fencepost.gnu.org> <vpqsioxn82l.fsf@anie.imag.fr>
	<87k3a96cj9.fsf@fencepost.gnu.org> <vpq38gxlk3m.fsf@anie.imag.fr>
	<20140428162439.GA9844@sigill.intra.peff.net>
	<xmqqk3a9qoib.fsf@gitster.dls.corp.google.com>
	<vpq4n1cxqrp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org, jrnieder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 29 19:01:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfBPA-0001it-EP
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 19:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933727AbaD2RBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 13:01:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933227AbaD2RBL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 13:01:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B52C81178;
	Tue, 29 Apr 2014 13:01:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LfLa10kCNVtBXnU4MJjm9L3F6N4=; b=OmRf8P
	zdYUHCNldTHAbsObGfPTsOKBccg1KFdABSTFcvukS2GaOcIx+ZnTHv4LEru/DOCB
	2R2tLRdousXnJdFD1cYwvNRyla+bWa+vSpA+L4+ZMuubf/XaKUzBGXyKf9NHwE4i
	TF4+9xABvqnwp1K5A4ZFX17jx2Q5gftSmwOI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pWeDC85Gym/tOtN0kmkC3y8ESNbm/Uuj
	Gr3zZzG2eyiGFXO4wE0aDsO5C9KQ3hhp+umZ4Llys5WID09YZvzM/NzEeloDEoQr
	kMRNI3aqDZtV4R9YPp6kkEn1KPqVtodpCrmKl7XDvLGUn469IH78wXuwE1m1N2K6
	3B3c6uSbw1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12C3681176;
	Tue, 29 Apr 2014 13:01:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B9A38116D;
	Tue, 29 Apr 2014 13:01:07 -0400 (EDT)
In-Reply-To: <vpq4n1cxqrp.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	29 Apr 2014 14:29:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DB561C2E-CFBF-11E3-B099-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247591>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> I also agree that droppage of S does not have to wait for that
>> topic.
>
> So, shall I rewrite my patch on top of master? (not hard, but there will
> be a minor conflict to resolve when merging with Peff's cooking series).

Sure, the one near the tip of 'pu' can even be dropped, especially
when nobody is actively looking at it, if it turns out to be too
much of a nuisance.

Thanks.
