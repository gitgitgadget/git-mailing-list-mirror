From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/5] t4041, t4205, t6006, t7102: use iso8859-1 rather than iso-8859-1
Date: Thu, 04 Jul 2013 23:47:04 -0700
Message-ID: <7vy59la4gn.fsf@alter.siamese.dyndns.org>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
	<cover.1372719264.git.Alex.Crezoff@gmail.com>
	<cover.1372939482.git.Alex.Crezoff@gmail.com>
	<38cdab6c314e858ec580b1d0fbf87098c2d92cb0.1372939482.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 08:47:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuznV-0000Jb-T9
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 08:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab3GEGrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 02:47:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49370 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428Ab3GEGrH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 02:47:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9781528CF0;
	Fri,  5 Jul 2013 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=95kg8zobeWZVhn36YI79bUti8GA=; b=Ylp+gv9mMTbf5HHn1eAW
	k5yUi+oL+/OpQnvV5Mi3rCjAdK0kR8snqlWxNyZiwOXKXERMmEjENnayyJNdfbQC
	3UMuaT4mMmq8ph5NxLkU5Fv5XGicDsvbMuRotE/9dgmGocZFwOfuvmVVBH3uY13m
	39TAT8i9z+fQ78Aec+5LHtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=cKLnhd3s/J094ckGp410U6TIT5IOHGgeuc9bxWgbJ2Marm
	YnTyUSIlv3Gh/mGGoiEs+MTFHDrIrsTakP1/3wMoWm2/k2JBSumsHFqEwegmK2Ta
	8wEk91kB9nNgisLYTS6VzeJPyqtdKcL0q6tKx847Mz80uFemFyS+8An85tJYw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C23128CEF;
	Fri,  5 Jul 2013 06:47:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC96428CED;
	Fri,  5 Jul 2013 06:47:05 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4DF068A-E53E-11E2-A9D1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229626>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> This is actually a fixup of de6029a2d7734a93a9e27b9c4471862a47dd8123,
> which was applied before final patch series was sent.
>
> Also, see 3994e8a98dc7bbf67e61d23c8125f44383499a1f for the explanation
> of such a replacement.

These are not very useful in a log message.  People who read the
history 6 months down the road would want to see why we want to use
iso8859-1 not iso-8859-1 explained.

	Both "iso8859-1" and "iso-8859-1" are understood as latin-1
	by modern platforms, but the latter is not understood by
	older platforms;update tests to use the former.

        This is in line with 3994e8a9 (t4201: use ISO8859-1 rather
	than ISO-8859-1, 2009-12-03), which did the same.

> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> Reviewed-by: Johannes Sixt <j.sixt@viscovery.net>

I do not recall this exact patch reviewed by J6t, but perhaps I
missed a message on the list?
