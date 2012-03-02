From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: fix spurious error when run directly with Solaris
 /usr/xpg4/bin/sh
Date: Fri, 02 Mar 2012 10:38:23 -0800
Message-ID: <7vd38uetls.fsf@alter.siamese.dyndns.org>
References: <f3294212cbaf9bc0d6446d2cdf13619d0317b9e4.1330684369.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 19:38:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3XN8-00062h-Ph
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 19:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043Ab2CBSi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 13:38:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753812Ab2CBSiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 13:38:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90A02643A;
	Fri,  2 Mar 2012 13:38:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1IHBkBQYLBbfxL3bkvzBmSN6C5Y=; b=RpswMn
	0MfmQE4Kq/A/uLNGzI62EzksUnXKkMqx9BBuhqu4mkUwdCI+LmarOy9cA5NoaaZ8
	WBOrEXpwt9IwekOJwHTGwfgiW5J0Z4JKFhKwlgvVr+7tZ0IVSpsO5zEG1P2Zv7/S
	b30O39TfdkOQs27CJ7Fx1acUqyXbNOS5IU9Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KTNKss36NzS/FffbKfi+km6jDTsvBrxQ
	H23/n/ELlpgKeJUe978KdoIBzk0baF+wWUVaeUIpyDYnbDLuCU9QsL5AmU5oCkKn
	x0LhNyAb5Pt55JpPDGbCsddP/EoBOTJpoG3tyFqFlg+K/oTzkvpJN8TTPoo7iKCS
	5vb7OgwbN6U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80F1C6439;
	Fri,  2 Mar 2012 13:38:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 181F66438; Fri,  2 Mar 2012
 13:38:24 -0500 (EST)
In-Reply-To: <f3294212cbaf9bc0d6446d2cdf13619d0317b9e4.1330684369.git.stefano.lattarini@gmail.com> (Stefano Lattarini's message of "Fri, 2 Mar 2012 11:33:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5340C6A-6496-11E1-9BB9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192057>

This patch looks good, but please sign-off.
