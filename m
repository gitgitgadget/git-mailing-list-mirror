From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/5] git-checkout.txt: better docs for '--patch'
Date: Thu, 05 May 2011 12:29:49 -0700
Message-ID: <7v39kt6j4i.fsf@alter.siamese.dyndns.org>
References: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
 <1304621328-17184-5-git-send-email-valentin.haenel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git-List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Valentin Haenel <valentin.haenel@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 05 21:30:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4FY-0003jn-Dq
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346Ab1EETaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 15:30:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264Ab1EETaE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 15:30:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F12E4818;
	Thu,  5 May 2011 15:32:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bRNqgsCkSPoQGRhkm5yrQ5U1TRk=; b=gDy67x
	7t8woxERvCd631GWcBxpIZTBWPE2PshkLyBIzKZJP3uocTXy305/CCFfGRyJVLqP
	DnH6DGniUF3PZQFFHPBd2+fOOg+7s+DZZJOMCNH4Nz6b3ZU1sJQkmWSJ9rFnuJMD
	Lb6jQs63ELV90hXJABbZ9ZKXRxjH9iUq3u6z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ex9hBOwTlstYAouJYfBIa3S+p6zhmIlt
	L/PrfNa9D7eV9KNqkIGfTN38GyXfAA5UHvtLZj+kXkgG9hlqJfydZO8CEdDcBMDt
	6Jpm9A0yrFZmVo0rdZxhhtjZtK+RgsYZXrgBheY1Ej2jsv+3b7XidxHGJCG47up+
	DHHh5vDFzSI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 593EC4817;
	Thu,  5 May 2011 15:32:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C37724815; Thu,  5 May 2011
 15:31:56 -0400 (EDT)
In-Reply-To: <1304621328-17184-5-git-send-email-valentin.haenel@gmx.de>
 (Valentin Haenel's message of "Thu, 5 May 2011 20:48:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A08EC2C-774E-11E0-9AE6-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172889>

Valentin Haenel <valentin.haenel@gmx.de> writes:

> * Include '-p' in synopsis and options
> * Include a link to the git-add manpage for a description of the patch-mode.
>
> Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
> Helped-by: Jeff King <peff@peff.net>
> Mentored-by: Junio C Hamano <gitster@pobox.com>
> ---

The order of the sign-off chain is not right (I've fixed them up so this
is not a reason for resending).  After getting somebody's help, the final
version was made by you, so listing them this way

    Helped-by: Jeff King <peff@peff.net>
    Mentored-by: Junio C Hamano <gitster@pobox.com>
    Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>

would reflect the order of events better.

FYI, this patch has become like this:

    Author: Valentin Haenel <valentin.haenel@gmx.de>
    Date:   Thu May 5 20:48:48 2011 +0200

    git-checkout.txt: better docs for '--patch'
    
    Describe '-p' as a short form of '--patch' in synopsis and options.  Also
    refer the reader to the patch mode description of git-add documentation.
    
    Helped-by: Jeff King <peff@peff.net>
    Mentored-by: Junio C Hamano <gitster@pobox.com>
    Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Will queue 1, 2, 4, and 5 with similar fix-ups.

Thanks.
