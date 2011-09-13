From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: basic configuration of
 notes.rewriteRef
Date: Tue, 13 Sep 2011 10:16:17 -0700
Message-ID: <7vty8gwefy.fsf@alter.siamese.dyndns.org>
References: <7vzki92wdc.fsf@alter.siamese.dyndns.org>
 <95a35723c2ac7e3accfceec2cdededcd213fb59b.1315899036.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Sep 13 19:16:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Wav-00087C-Lt
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 19:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718Ab1IMRQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 13:16:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755698Ab1IMRQU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 13:16:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A724E5F72;
	Tue, 13 Sep 2011 13:16:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/Eo7BOt/a3jhY+bmB7wEn7tIm3s=; b=m/Q86zNqtZdNFE+tD69p
	Y0Wk//keaFdQ64kF7GKS3SNpX19X7XDZIEDZ5sueb9KUETQzG/7b2Q8wckEotuKk
	OElvOYVOT+uxAJuyEfk4d06oycOL1vry0uJXeNlZnbfHOo2BDXLBOBw6Kb6W5+2a
	8SPoHAAkebeDswOyk/VtIbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=SgxDx9umZWYoMDoHxmp1JjhMhmMN4zyNl5/FDPOfLosEK0
	xFqT6zmE8RvjGTFseJs/KOpaaspk7ZGR1ZaeaJYWR8TausypOQ+pF6GhWljIcb0U
	v/WlqZUtT/I+E5w8+j2bdAF78mJWiF+FI/gr4IX+rTWlHlAiRLvRyOBbNZ6qw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FDD85F71;
	Tue, 13 Sep 2011 13:16:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 220265F70; Tue, 13 Sep 2011
 13:16:19 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1877174E-DE2C-11E0-AFF5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181296>

Thomas Rast <trast@student.ethz.ch> writes:

> Users had problems finding a working setting for notes.rewriteRef.
> Document how to enable rewriting for notes/commits, which should be a
> safe setting.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> Junio C Hamano wrote:
>> Should we drop this post 1.7.7, or (preferrably) replace it with better
>> instructions?
>
> I'd replace it with this bit.  Users who have trouble setting the
> variable to something useful will likely not know how to edit
> non-default notes trees, either.

Ok. Thanks.

> +enable note rewriting.  Set it to `refs/notes/commits` to enable
> +rewriting for the default commit notes.
