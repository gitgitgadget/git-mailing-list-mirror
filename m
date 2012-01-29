From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: fix -l/-L interaction with decoration lines
Date: Sun, 29 Jan 2012 15:49:12 -0800
Message-ID: <7vhazedq87.fsf@alter.siamese.dyndns.org>
References: <CALEc4zGV6Oo-WR0vPE6=oEmm=fo4dd=nyBWFuK1oU7rmF9K41A@mail.gmail.com>
 <74777e0e8633d980fee9a1a680a63535be042fdc.1327340917.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Albert Yale <surfingalbert@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 30 00:49:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RreUz-000203-RV
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 00:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab2A2XtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 18:49:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50816 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334Ab2A2XtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 18:49:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 476AE7B9F;
	Sun, 29 Jan 2012 18:49:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=8OC63p4RmhpK+22CyYQuoNWp2sw=; b=FpC3cEwU0/+dY1c/aGga
	cnA/VwJFS2FA+If/ZaH577EjTaxeoDw6qqSwX+hahl8vJDP6oFRnsyMPRYQp29kT
	g6oDYFVvG148/d2m1Hjv0PRGb0xoTfHwLk+aNctiUrgeW+Dwe+n5IqJDWucLii2S
	kYPbEiJl+kykA8PnAT5mLOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Wi+dKgCj0/bny+8YaQpo8nmhacBOYmDeNc5N/LUaZJLgEh
	bBwcnfCFf5J+58/MZ264hAA+ogn9/Pl/OrHlQkS9oGnEKNsxb/+EHsXpyJScaKgj
	wkcL4SpdEdkAuEzBMsohp1RUz8h4m3U06kPaTYKEr5OcdcwfewiBoaAX9YWgc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E2017B9E;
	Sun, 29 Jan 2012 18:49:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C587C7B9C; Sun, 29 Jan 2012
 18:49:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D911EE8E-4AD3-11E1-83E2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189308>

Thanks, makes sense.
