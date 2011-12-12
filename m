From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] grep attributes and multithreading
Date: Mon, 12 Dec 2011 15:44:52 -0800
Message-ID: <7vsjkpz763.fsf@alter.siamese.dyndns.org>
References: <4ED8F9AE.8030605@lsrfire.ath.cx>
 <cover.1323723759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Jeff King <peff@peff.net>, Eric Herman <eric@freesa.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 13 00:45:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaFYJ-00050k-8m
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 00:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418Ab1LLXoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 18:44:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab1LLXoy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 18:44:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 323B96E3B;
	Mon, 12 Dec 2011 18:44:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z5lywzcgjkIjZBHi7K3kIKjY/KY=; b=PLBmLf
	JsSGG61/YE0X+zHMsWWNTjpRGhXy0oN561mBymg6QB+3dotNThEEQXoLjDciR9lB
	cB4vcSgOmYf6Cw2zfq7fG/oW8xo/VnMweg2ZvbDRF/BRaabUBbtiaJ0wCrmDHP3W
	gsFRPVHomhOUcQSVuR7/gMtQ64V0dgr8xsIVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KWa1MrwiSEBsnaFYS8QPAD2zEBEVZ6bU
	z4WUe4r7Ndys9CLFYDFJ3DGnKLbhYMxuRqoWuxGOPxAdyqerzoHjSkq1Mh1ewitd
	a4dRNfVPDaEmvXT7uFEfhWOYQfztExkIVvvORD2oq337kpN/cGKjvt9CL8Ss0Thy
	JFQ7YHci/ss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26DDD6E3A;
	Mon, 12 Dec 2011 18:44:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AED936E39; Mon, 12 Dec 2011
 18:44:53 -0500 (EST)
In-Reply-To: <cover.1323723759.git.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon, 12 Dec 2011 22:16:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A371334-251B-11E1-A6B1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186976>

Thanks; sign-off?
