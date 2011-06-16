From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Thu, 16 Jun 2011 11:02:09 -0700
Message-ID: <7vtybphcym.fsf@alter.siamese.dyndns.org>
References: <20110616003800.GC20355@sigill.intra.peff.net>
 <7v39jai94h.fsf@alter.siamese.dyndns.org>
 <20110616065146.GA30672@sigill.intra.peff.net>
 <20110616075621.GA12413@arachsys.com>
 <20110616174653.GD6584@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Webb <chris@arachsys.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ren?? Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 20:02:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXGtV-0003eP-Bv
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 20:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758530Ab1FPSCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 14:02:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758508Ab1FPSCL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 14:02:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A24EA5A5B;
	Thu, 16 Jun 2011 14:04:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dbtrvQP85PPrDN0gGM5CM7uNgJc=; b=Z3oZ6m
	YSyPyj4LqoJiwa8qQ3RfR78S5tdR+W8Q59ESaFEMSw2/wOYOs+XsstMUca9h6JRv
	6IF/sXgk2OuCRc8HBQKK9p6q7jUfvWgRq16qnznPQ/m2aJAHY/JjWpple8mQ5/lo
	ogF4pEpYg8mb04B/wQ9zDIX0aSvs6K5bIhf5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HgCgkRK+himDWFr65X9hkdy5vgDs27UI
	hFscO53AQumpWtNILkihxS5+WazCUhBAHMr+/XnjI3/jWX47Sgil3UE3hIz2ajjf
	kOnOLcc/lw8+WNLm0vCnKv0KIQ9jMQgtxT6LezxtTlBsdiyVsgPrkOcEspXI8tJs
	GdYVgXhpdww=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 996EE5A5A;
	Thu, 16 Jun 2011 14:04:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F1ED15A59; Thu, 16 Jun 2011
 14:04:20 -0400 (EDT)
In-Reply-To: <20110616174653.GD6584@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 16 Jun 2011 13:46:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F6F9164-9843-11E0-A93E-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175908>

Jeff King <peff@github.com> writes:

> OK. I'm totally willing to accept that people actually prefer the "-n"
> behavior. I don't care either way myself. I just don't want the reason
> to default to "-n" to be "because our test scripts need it" and not
> "because this is what people actually want".

Surely I share the exact feeling, and that is why I quoted the other "-n"
added to gitweb because that was what people actually wanted.
