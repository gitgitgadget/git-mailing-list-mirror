From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/7] Provide API to invalidate refs cache
Date: Sun, 16 Oct 2011 22:40:45 -0700
Message-ID: <7vty78npk2.fsf@alter.siamese.dyndns.org>
References: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 17 07:41:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFfwZ-0000hr-8t
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 07:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585Ab1JQFkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 01:40:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359Ab1JQFks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 01:40:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C47AE2700;
	Mon, 17 Oct 2011 01:40:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LMUqlUKJg/oAtR0v9dZNWR2m9gw=; b=GXf8xG
	y4dOflh23eiG9qUsAvhBXcdCfbFl5IfVtPH6L0ZGV/Popy/wiO21taO6Yy/uCfs4
	z5dH7pjJ1cy8iEE51kpqbisGHaqn3X1Hgryzf8LfHFNK8UFgsXA8pzV/kcgcS17d
	OCokXZMCes4odYNiwHu5AS+QypLenyUYS9XiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IbOHMpoM4aLIokEXBfqBN49nFfDAzvfQ
	isayvOM5kPQJ6kSiwSx6S2hLp51KZpDELNz9HswomkbHDQZQGp7M2fs5pjy6uBNR
	ei0RHpYeJqvpUz5h1DhB8u8DkCi0NdifzMY9H6JQrbXyyBDMKhtyJWFhIlwZmm9e
	Eq9uabf/kVY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAA3D26FF;
	Mon, 17 Oct 2011 01:40:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4878026FE; Mon, 17 Oct 2011
 01:40:47 -0400 (EDT)
In-Reply-To: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Mon, 17 Oct 2011 04:38:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9069332A-F882-11E0-9228-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183767>

Thanks; will replace the topic with these and re-queue.
