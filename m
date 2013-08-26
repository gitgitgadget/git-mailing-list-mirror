From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/2] some enhancements for reporting branch tracking info
Date: Mon, 26 Aug 2013 00:21:18 -0700
Message-ID: <xmqq7gf8kjdd.fsf@gitster.dls.corp.google.com>
References: <7v7gfiojz7.fsf@alter.siamese.dyndns.org>
	<cover.1377500206.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 09:21:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDr78-0002BM-4R
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 09:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095Ab3HZHVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 03:21:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755317Ab3HZHVV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 03:21:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7CB338350;
	Mon, 26 Aug 2013 07:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KaMHD+yKRndLY+KmnqPk0uAefrA=; b=mzC9aj
	xVgGHxQ78BUvj8l5WdczJi/qOOFjxMzxEYHq5l5O+zmKClIANIeuT/6c9+pZHFuy
	NT11un6j70PQBu5GzvgL3aEljqVza1COnhAvb4k4jG/VotQVO3hNA85BVpF2Vi8g
	ugumD5tfdCrwoDXUqfXHhT+m5IirDKV+NHti8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AAOqZZLYCD/mV5wf8sGzZvfB5EhvAJsa
	56kv1tmArjifoaf+iy+PoGu9dLGDhVQbspif57Erswh0MHLHTDcKBWgrp9FnQ68a
	Fm7zs4wZqOBPMDNjPGMJnkCwTXfYeEDCF6CNA1NXKs8x0dRFJGHbyR5vjg+KYPY6
	ei4l6kSTiA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD75E3834E;
	Mon, 26 Aug 2013 07:21:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FAAD3834C;
	Mon, 26 Aug 2013 07:21:20 +0000 (UTC)
In-Reply-To: <cover.1377500206.git.worldhello.net@gmail.com> (Jiang Xin's
	message of "Mon, 26 Aug 2013 15:02:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1AC3E664-0E20-11E3-92C1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232983>

Jiang Xin <worldhello.net@gmail.com> writes:

> Changes since v7:
>
> * Squashed patch 1/3 and patch 2/3 into one big patch.
>
> But not s/gone/absent/ as Matthieu suggested.

Thanks. Will requeue.
