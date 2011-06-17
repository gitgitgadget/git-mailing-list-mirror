From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: link shell libraries into valgrind directory
Date: Fri, 17 Jun 2011 14:28:37 -0700
Message-ID: <7voc1wf8qi.fsf@alter.siamese.dyndns.org>
References: <20110617082956.GA20414@sigill.intra.peff.net>
 <20110617203632.GA27793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 17 23:28:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXgar-00053X-34
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 23:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875Ab1FQV2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 17:28:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab1FQV2j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 17:28:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 140935291;
	Fri, 17 Jun 2011 17:30:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qlh5XrQCBdKTMT/5Omebywsm7ug=; b=eU2TlP
	qPrRi8jufUk6vOetxz89Pf2jojubPGSiPtHeOT6wt5++bznPRFi+E4ALxyaOeAFY
	43c/cf5mVGqvB8FvylZPXNIk2O7xCNwu5AT3dXiOBBzr7s0rbxw+RaICUoDy/Hyl
	q/qYIotXeJSCyA1NpxK1RX9tDkyr4vZYT7ik8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AobPdlwfPXqihSE74rvfe4BrqIMCILb8
	ga1+NYYVFiIvnKLlmg9rwb/g9WGmaz3VxwLDyEPYPavMd3LPcaqO9r8ckrg0RP9q
	puxeZLCT3ShOQPVt9tZHXt0l91vIUHKkumgyNxGqvHm5+HC/XvKbHOknIgaa/Ti6
	emG9L2tcgaY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B73D5290;
	Fri, 17 Jun 2011 17:30:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 68C03528F; Fri, 17 Jun 2011
 17:30:50 -0400 (EDT)
In-Reply-To: <20110617203632.GA27793@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 17 Jun 2011 16:36:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12828E92-9929-11E0-9526-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175960>

Thanks, will queue both.
