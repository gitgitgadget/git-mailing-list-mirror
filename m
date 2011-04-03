From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.el: Don't use font-lock-compile-keywords
Date: Sun, 03 Apr 2011 12:26:34 -0700
Message-ID: <7vr59jb0gl.fsf@alter.siamese.dyndns.org>
References: <m3oc501rja.fsf@e4300lm.epcc.ed.ac.uk>
 <20110403001902.GA25671@elie> <87ei5j2prc.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Lawrence Mitchell <wence@gmx.li>, git@vger.kernel.org,
	David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Kevin Ryde <user42@zip.com.au>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sun Apr 03 21:27:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Swx-00049y-Md
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 21:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254Ab1DCT07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 15:26:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab1DCT06 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 15:26:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9D344383;
	Sun,  3 Apr 2011 15:28:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+y1nfqQvtdatoNPo7Aih33x0Sd4=; b=ZvwNXY
	l3OIAjBqU6QK3lIaxnozFgWqI/KgvRW+oQi7O7D5g2o4SBaF7UEdVyztst/iJbIn
	y995dZyaoyZpR5T7ssa58G3MHy3m+J7b4JGpQj+BNYypI7Uzn6dWWxZDsHNnyYQW
	vS7ft+v4/1YyZVAmPgfsqy9NY+m3hhUwkbEWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=khGUT0M6eUXIf5J0uaJMKxgFJgMWh1tO
	r1Y8FFFLaYzpDyYuR42sePeL/KZG9cprNjqrCoyE9n8oxV0Te8Sjy9/yKqF62v7T
	UrPreAiCqufA4axvtNvSkfRwiextJV5iR7501I01abplQFycXljWIf1wMcNxynNt
	9XvIT3N6+hQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 889164382;
	Sun,  3 Apr 2011 15:28:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E5F9C4381; Sun,  3 Apr 2011
 15:28:27 -0400 (EDT)
In-Reply-To: <87ei5j2prc.fsf@wine.dyndns.org> (Alexandre Julliard's message
 of "Sun, 03 Apr 2011 19:44:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 918D81E2-5E28-11E0-9C8F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170777>

Alexandre Julliard <julliard@winehq.org> writes:

> Looks good to me.

Thanks.
