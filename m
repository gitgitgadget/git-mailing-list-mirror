From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH ALTERNATIVE v6 0/2] http.<url>.<key> and friends
Date: Wed, 31 Jul 2013 15:01:43 -0700
Message-ID: <7vr4eetmm0.fsf@alter.siamese.dyndns.org>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com>
	<1375298768-7740-3-git-send-email-gitster@pobox.com>
	<1375298768-7740-5-git-send-email-gitster@pobox.com>
	<72dacc4d84caf9831f5e12ece7f38f2@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 00:01:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4eSt-0001PI-Ek
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 00:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705Ab3GaWBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 18:01:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab3GaWBq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 18:01:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A9643537C;
	Wed, 31 Jul 2013 22:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rJEJShjpSYL/6cagY55Z7rUHtsU=; b=K9Yd8K
	2YeANdw1IyKfYB1QTMmRjCEk3KveM/uxFMsVPMQuJ6Z04w8tyjiERYlLIqGAGSlA
	hkUB99upPF2IdvSs82DY92npkcfaGsPS9HNIy8p6iqqySU26D72usABOlAflsYk4
	et/uxYuFeLx39PWNpuULfySVT+VJJyw+5/yI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NvaxTIXjr1DTfBWGZiIrJTjl2U8ogvwK
	dWoIwFBLlMgygymlSU8FlfngzHpRe+qVdB6qV1cOL89jOboTBeWVxhRgbiC13acb
	tEQRjX0AbwdOO4VDADbO6dbz+16foiYZvJu4SPec16IUc9NAujo3zPNg7WvjQlbp
	ETjePSDYjXA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D7EC3537B;
	Wed, 31 Jul 2013 22:01:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A042935379;
	Wed, 31 Jul 2013 22:01:44 +0000 (UTC)
In-Reply-To: <72dacc4d84caf9831f5e12ece7f38f2@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Wed, 31 Jul 2013 13:51:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9DBA2B6-FA2C-11E2-B132-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231470>

Thanks for a quick turnaround.  Will replace the two patches with
these and queue.
