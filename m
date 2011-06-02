From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status --ignored
Date: Thu, 02 Jun 2011 11:30:37 -0700
Message-ID: <7voc2gcche.fsf@alter.siamese.dyndns.org>
References: <4DE712CE.20509@vpac.org>
 <7vr57cerxo.fsf@alter.siamese.dyndns.org>
 <20110602055449.GA28292@sigill.intra.peff.net>
 <7vk4d4dxn1.fsf@alter.siamese.dyndns.org>
 <20110602172021.GB2928@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Spiers <aspiers@vpac.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 20:30:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSCfV-00046O-Mk
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 20:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459Ab1FBSas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 14:30:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab1FBSar (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 14:30:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 21DA84592;
	Thu,  2 Jun 2011 14:32:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WIr1jePIuCemi8uUxIYGCj68208=; b=YBlupn
	QydjONpZZr/PcAWLkVwchrG1YOlIv5DJthqLRRsSaF6QxYy4t0mKJRvHAmdDX0FG
	QntrzUJ0vaHwmBvmKEnQQaauMmJ1AtSet6dRCUzFWi0xkLF6YVtGV4HpELdMiz47
	GFj1BSkPJ70Y6UVwVoSnOVTglgvKaEFX0+KeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h+KHU4LCgHblW6MQNa0l4w0+epfcc2r7
	+cAZ/XNMD0KkYFfi2kxcUo4IYDL2T65R5nGkD9yyTetcGUVAluy3a93io0diAONt
	NQXydmgMKHKORKcND1G0EzYoqWAxzip/woqyUgwxZzeknGHqRDupbunP2mZLSKr5
	tZ7Jz6LhIDU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE5484588;
	Thu,  2 Jun 2011 14:32:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 95DFC4582; Thu,  2 Jun 2011
 14:32:47 -0400 (EDT)
In-Reply-To: <20110602172021.GB2928@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 2 Jun 2011 13:20:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B95CB42A-8D46-11E0-BFA2-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174968>

Jeff King <peff@peff.net> writes:

> it doesn't change all that much, so maybe it is worth doing. Squashable
> patch below.

Thanks.
