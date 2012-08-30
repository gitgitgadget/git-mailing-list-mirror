From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] name-rev: --weight option (WIP)
Date: Wed, 29 Aug 2012 21:10:42 -0700
Message-ID: <7v8vcxuiil.fsf@alter.siamese.dyndns.org>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
 <1346275044-10171-1-git-send-email-gitster@pobox.com>
 <1346275044-10171-4-git-send-email-gitster@pobox.com>
 <7vligxuv6l.fsf@alter.siamese.dyndns.org>
 <20120830033611.GA32268@sigill.intra.peff.net>
 <7vharlujaq.fsf@alter.siamese.dyndns.org>
 <20120830035552.GC32268@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 06:10:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6w5j-0006pO-T0
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 06:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752Ab2H3EKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 00:10:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730Ab2H3EKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 00:10:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D26CE8E6C;
	Thu, 30 Aug 2012 00:10:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h/wZmoCG/pfkMNxfsPr0R4bLdOI=; b=H/Hrd8
	PGJHauU5CaRaaRdLEjbe8YdOU94VClUDPzDNakkTGcf1GxSocoPPOWxMfL2AMtWu
	7lYAjD/I0K6MG6aDOhDbLP1ipXpuubWEo7rstSgU8B4WXkuO5x27iFPHzXWEDeVL
	cjL4pzp1Y0nclXrwKSTMYHEYTuh8sir27q+jE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZE63w+qgiVZHhNy8ZfmhCN6BUYPYOIUX
	xKEkJVgyh12gticDLu8RnxS0cCr8TSdELHVCjWUbnGSEe9mrHxvA//DNfRiL4ruG
	qRAhfIQff50JSA+jdO/AYh9FfsfGVuEr975HAN4GpwVipZ2oamGj2mjxOB9BJpJQ
	px40b078dvY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C03FC8E6A;
	Thu, 30 Aug 2012 00:10:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F4D18E69; Thu, 30 Aug 2012
 00:10:44 -0400 (EDT)
In-Reply-To: <20120830035552.GC32268@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 29 Aug 2012 23:55:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB4A897A-F258-11E1-B5EE-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204520>

Jeff King <peff@peff.net> writes:

> OK. I didn't think too hard about it, so I'll trust you that it is not
> easy. I wonder if using the generation number would be another way of
> defining "oldest" that would be easier to calculate.

Go back to my illustration to Greg and think about the implication
of "TONS!" side branch in the picture has on the generation numbers.
