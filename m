From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/11] Simplify "How to make a commit"
Date: Thu, 29 Aug 2013 11:16:42 -0700
Message-ID: <xmqqr4dc4b1x.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<878772375.34519.1377626477170.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:16:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6m1-0002Nb-Kk
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513Ab3H2SQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:16:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769Ab3H2SQo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:16:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8575B3D79B;
	Thu, 29 Aug 2013 18:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NhE3KRNWhvNfdIYc6H2vvku0fTw=; b=Kh0jxS
	twbBuQBwpr7S0OYNe1roicMsFRcynkwfuWe+ISmcs6k+O3ID5OLE5lrA5qm6zDPS
	43Qxx+QrP5+t3pgt1T2ThrftScKtMQAzAYc7UsBrY3RP1k+lDUj+THcyB64XrSbg
	huWOwYUzaWCKXo97mtUb+nMyf9hmx25ApyhQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q7r0l1DYDegZ1u3mVXwWoXw8oblaRdE2
	HTJOlCTp4xgDKJplEhG5qcZCAAMg5cDFU/H0cHFISA+I6daQj6hyOT+k0zzQcvf8
	sjNiKUygv9TF3XTy33ZelirxIzAvxoIrOJtL8b5tjVfbvPug/kOkMp3HfatNCyo3
	x+Md0wlIfw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A4623D79A;
	Thu, 29 Aug 2013 18:16:44 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAB3C3D796;
	Thu, 29 Aug 2013 18:16:43 +0000 (UTC)
In-Reply-To: <878772375.34519.1377626477170.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 20:01:17 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 28A3E7F2-10D7-11E3-998B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233308>

Looks good; thanks.
