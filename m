From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9] add strip_suffix function
Date: Wed, 02 Jul 2014 10:41:12 -0700
Message-ID: <xmqqwqbvhd53.fsf@gitster.dls.corp.google.com>
References: <20140630165526.GA15690@sigill.intra.peff.net>
	<20140630165751.GB16637@sigill.intra.peff.net>
	<xmqqlhsbiwmz.fsf@gitster.dls.corp.google.com>
	<20140702163832.GC14404@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 19:41:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OXE-0007zv-AV
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbaGBRl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:41:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57386 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbaGBRl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:41:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C105523888;
	Wed,  2 Jul 2014 13:41:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CNZ9R+b9T1YHWvqHinHh5ZvLE2o=; b=Z1hZPH
	pWqQH7MW4XrcM8tlvFnJXe5m0Bd9ZJ/OXKM0vztgFgUMvOAhZ6sui5u0QqATZ9C9
	mlzELd0XikuQAyAEpFNz3P8xW5IQ3N4W7mG2DLDwT2ZgPdLsFQogUtRxPJVzwO4d
	vj5dxvvWDUwAA53v+o4421R6sdcVhTQKHthZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f3O0TqJ/nAo4nbfm9YZ5SoOT53pNk3Au
	kAO+KC31H5P+tEaXBlj1XO7kCgTD63MhfLN2CA5UASQUtbNtubE1aTWXKnLtX5m6
	oXI9pQVzs1ZkZmzr0GJJ+SByYP8sSWojCKeSIB2Um4/Xd7UREu9ItEQ0hZ+t3B/0
	IEW88YHTv1g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B202223887;
	Wed,  2 Jul 2014 13:41:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A937A23878;
	Wed,  2 Jul 2014 13:41:03 -0400 (EDT)
In-Reply-To: <20140702163832.GC14404@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Jul 2014 12:38:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0E16F926-0210-11E4-A5A8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252803>

Jeff King <peff@peff.net> writes:

> Having had a day to mull it over, and having read your email, I think I
> still prefer strip_suffix.

That's OK.  I was only trying to help you explore different avenues,
without having strong preference myself either way.
