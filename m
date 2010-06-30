From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test for correct coloring of git log --decoration
Date: Wed, 30 Jun 2010 13:37:38 -0700
Message-ID: <7voces45pp.fsf@alter.siamese.dyndns.org>
References: <7vbpaucs2c.fsf@alter.siamese.dyndns.org>
 <1277797628-32466-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 22:38:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU42g-0001x8-Rm
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 22:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756950Ab0F3Uhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 16:37:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52854 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689Ab0F3Uho (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 16:37:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 416A6C0864;
	Wed, 30 Jun 2010 16:37:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=BuTv2Wuu3UUogDjR2ytsq/p6tBs=; b=oyf0luHEtNCWcQyeCAWX/ct
	Gi0NiGPc7uupUrBB7U46x0cykk5cRQQkmAU5uhpxx0Ueg2IQpYevg45WMY3oF4g9
	JntpdntsYkBKoIsBvrlDv07cXajRgS0gCzsjZ2VltZKWE5I8Gq3FJWW9oxj2G2ZT
	yMwjyh2EDlqUrNXiR8Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=MHMZP4+HOp2rWxi7iNf60HFBhiMQQbc1sJZaUjX1GnCIQs4WS
	h2x7nX6xsyo2bXMtn7J88ggVe6jB72M+ZAffORrfSb1sETcwRxeIe3P6jFGfhx6v
	vY9ofjkrO2UR4gEOrnksnQTRY2ei3/JeNGrebR5ixBftrtSdR+LUiIoI7k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EEA7C0861;
	Wed, 30 Jun 2010 16:37:42 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C516C085F; Wed, 30 Jun
 2010 16:37:39 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 54B4D19C-8487-11DF-B539-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149994>

Nazri Ramliy <ayiehere@gmail.com> writes:

> I've updated the test to also test for the need to print 'reset' right before
> restoring the commit color.  This is done by setting the tag color to "reverse
> bold yellow".  Without the 'reset', the next decoration would be wrongly
> printed in reverse.

Thanks, will queue.
