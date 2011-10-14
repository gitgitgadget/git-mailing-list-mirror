From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] daemon: give friendlier error messages to clients
Date: Fri, 14 Oct 2011 14:52:22 -0700
Message-ID: <7vhb3bxmuh.fsf@alter.siamese.dyndns.org>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014210251.GD16371@elie.hsd1.il.comcast.net>
 <20111014211244.GA16429@sigill.intra.peff.net>
 <20111014211921.GB16429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 23:52:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REpg8-0008UC-CK
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 23:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933434Ab1JNVw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 17:52:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932407Ab1JNVwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 17:52:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23DB15C36;
	Fri, 14 Oct 2011 17:52:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GtlAm6G9aLtguEkUcWuJh+LHQN8=; b=e2Yc0S
	T2dNcj5YprqWNYGDkkx9ktDzai1DnrSfUNoGKsCJkyJ34291x+H/23zUNiKS+DCE
	LkLp0UnGn2NfJtxuiVHeh4xlumruBN4t8RjZqSMOnXUV9UYDxie6lfb5sz+Sta82
	JPMPoizoJVsvp7nBFPYL2MTsVlIcN2xnTejm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zets9WwSx25j3LoYblSLpG++DHrfOA6T
	MflCOB2YomQRQQX1szYWDSwNrwzdmP4/RSHtEqaV5J4bJWXsZMZnBPTqES1yyqO8
	5qIAEskaAQFlIfn2/0bJO/ESA6WJKEnmmHPSLkwxWp41JS8zGcUwYvCFLa8sbh4w
	p/B1hSIAzNA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A8C05C34;
	Fri, 14 Oct 2011 17:52:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F6955C33; Fri, 14 Oct 2011
 17:52:23 -0400 (EDT)
In-Reply-To: <20111014211921.GB16429@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 14 Oct 2011 17:19:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC81F994-F6AE-11E0-8713-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183617>

Thanks, both. I'll drop the previous one, and rebuild the integration
branches by queuign this version instead.
