From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .mailmap: Map email addresses to names
Date: Fri, 12 Jul 2013 12:48:07 -0700
Message-ID: <7vy59bk1ag.fsf@alter.siamese.dyndns.org>
References: <1373656881-5187-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 21:48:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxjKB-00025w-Oi
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 21:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757637Ab3GLTsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 15:48:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043Ab3GLTsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 15:48:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2220A306DD;
	Fri, 12 Jul 2013 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cBswlU3QTK9kHpweqNARaOWE53w=; b=PzKACE
	6nxAlBCx2eUAsxQRW1jSaycsVqL7w0Wj/Aqc6ijlws068xcaOxp0Lq7vfkcRpfZS
	A72ICBzajpEf5AQsnJBJqv/EKPciJWYlAM4c6AsmXIZjO3eU27yrUMef/awV9oSe
	Y8gsMzKdO/tY4xhQF6QtmBGTl3BW3+GW3OfPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ddM802VL2hyo/bh11ia1NGJKOoliFSqX
	IVxSUTMtuR9GbkWV0W0W2sZkEVAW6sXqNN0GeYs/Q7O8kbEnvhtvpIB0OL5BK71x
	+qLZCsWgU7/bUj6jofB6cIN/kFZ7AB7ixP3ECJlFCmIV7DwhcVqAP3bpXP06fQQ4
	9ID0I+EyBBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15D4F306DC;
	Fri, 12 Jul 2013 19:48:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62D08306DA;
	Fri, 12 Jul 2013 19:48:09 +0000 (UTC)
In-Reply-To: <1373656881-5187-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Fri, 12 Jul 2013 21:21:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA8C9236-EB2B-11E2-8FA1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230244>

Stefan Beller <stefanbeller@googlemail.com> writes:

> Ok I am sending all confirmed changes now again
> in one big patch, as the sorting was wrong.
>
> Stefan Beller (1):
>   .mailmap: Map email addresses to names

So this corresponds to both of your patches, or just the first
batch?
