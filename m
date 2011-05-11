From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I push all remote branches to a new/different remote?
Date: Wed, 11 May 2011 11:00:25 -0700
Message-ID: <7vy62df77q.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=EtRPcjaeCRNgLQ39JsqzS=_69hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Wed May 11 20:00:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKDiB-0007Po-3p
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 20:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab1EKSAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 14:00:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab1EKSAc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 14:00:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B32E4A07;
	Wed, 11 May 2011 14:02:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bYnxmav8xIpZmOVVpde8//f0ALA=; b=oCv7Y7
	bJ25lJ+JOb2Dw/lFtoEsD+DjW24E3u1yUIXSWTKzUfVvW+8LzMVaTXkQzha4Abwz
	tyjHdcij/HoOhjgR452cp2RRBboQKyu1loZSoJVYDrTO4O0gXgQh6FfO0qHlR5/J
	Fakj/7IW+RVxZmk2mJRIm4VnIDOV8wujDR4wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kpfPrz2OtIV3ognVc4sydb+rPhOwINUV
	5bNWNB75PnOEl0odd2T0NKFRXqmyfeFn7qjkJdC0opmv8RJf9JOeWsAuuRk8aG2Z
	+8FnMVfXmWk1RRgcD4guf4BIueZeKWrkIO6RaTAXY3GODrluQ8grt1ovBcwRrC2a
	Hyw+T5amWak=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57BC54A03;
	Wed, 11 May 2011 14:02:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7CEC94A02; Wed, 11 May 2011
 14:02:32 -0400 (EDT)
In-Reply-To: <BANLkTi=EtRPcjaeCRNgLQ39JsqzS=_69hA@mail.gmail.com> (Howard
 Miller's message of "Wed, 11 May 2011 10:55:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D987F8CC-7BF8-11E0-A13C-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173418>

Howard Miller <howard@e-learndesign.co.uk> writes:

> git push ...you tell me..

You can say "please" here ;-)  Shouldn't this work?

	git push $that_url 'refs/*:refs/*'
