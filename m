From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MERGE_RR is in .git, not .git/rr-cache
Date: Wed, 14 Jul 2010 13:08:33 -0700
Message-ID: <7vaaptygfy.fsf@alter.siamese.dyndns.org>
References: <1279127891-247-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 22:08:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ8G8-0007q9-FC
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 22:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757460Ab0GNUIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 16:08:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972Ab0GNUIn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 16:08:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D4E01C467E;
	Wed, 14 Jul 2010 16:08:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dp/Gd0o/OA/gVRtuKVDTwWMFY/s=; b=AwbAkD
	+AMbJY+myr6J1KYs7fPLfZteOXub96EHrMQ6/KVV0exf1zT3Pz8m6lej+dt0imeY
	i9yKoW/eVaXralYsc7HSqqkKep1gEzTrkPOPOUtsSIDTOn0hRiWnNPKwvsSLcJFu
	AicNNI/niyTauVlGAYStQvNxUnf8eqmGApMXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OsdlYu1KEk7G52J1qnWCe9R0m92DZtiW
	19W9yf891PELeD7IySxh4IuOdlspj8O9tbDgX0HQ2u6oFXYj22EkFgMgECp+ho8v
	xI/kKiNwODVrz+oEoTp6Z5Xj8dr6dln31WucMFFsi5sgIhuuZPow3HaVvHw2A7uR
	Zy9B+MsBqhk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 42AB8C4679;
	Wed, 14 Jul 2010 16:08:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D38DC4677; Wed, 14 Jul
 2010 16:08:35 -0400 (EDT)
In-Reply-To: <1279127891-247-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Wed\, 14 Jul 2010 13\:18\:11 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97A9D69E-8F83-11DF-BE97-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151032>

Jay Soffian <jaysoffian@gmail.com> writes:

> 0af0ac7 (Move MERGE_RR from .git/rr-cache/ into .git/) moved the
> location of MERGE_RR but I found a few references to the old
> location.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> I thought I'd mailed this out, but apparently not, hence the month old commit date.

Thanks.

There still are references in contrib/examples/git-rerere.perl and
git-reset.sh; they are historical and can be left behind without harm, but
we might want to clean them up later.
