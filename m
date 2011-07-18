From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/48] t6036: criss-cross with weird content can fool git
 into clean merge
Date: Mon, 18 Jul 2011 16:38:19 -0700
Message-ID: <7vaacbdus4.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-10-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixON-0002rI-2t
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536Ab1GRXiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:38:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab1GRXiV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:38:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EAF041C0;
	Mon, 18 Jul 2011 19:38:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/6Uzi1BHDf8CizA0Pt2P0nv1xw4=; b=ZNigsdxvpMGQA6zWLjjh
	J4qmsDPJ6cz+AliBdsr6TtlUI9odZJebgubH8kuy1QFzfe3bwVPHgK0czxmplI0B
	Ez4albUZ2QAp3loVm1u1cjUL9FsQ247bsgnSXDcWPA07E/iRng3jfQA58o66jSgO
	gZuZgmxWj3oYxcn6CAtxi0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oXMFizA2I84z7D39xI1paWJUUo3Cz+tzCzYPtlWIwc62aN
	L5pWe362GtyOYT6Srild85QdTPdNwvCYxCUIC3eYZC+zIFNNjJLaIm+zVQ1y1Mbq
	r2Yc+qLW1XzUh/wXZbUGLvqjsXPOHpyC58grgexs33RfFLwgtDecHjQ9fcV3E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76AA541BF;
	Mon, 18 Jul 2011 19:38:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F23141BE; Mon, 18 Jul 2011
 19:38:20 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0573058E-B197-11E0-A8CB-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177417>

Elijah Newren <newren@gmail.com> writes:

> +#   Commit E: file with contents:
> +#      <<<<<<< Temporary merge branch 1
> +#      C
> +#      =======
> +#      B
> +#      >>>>>>> Temporary merge branch 2
> +#
> +# Now, when we merge commits D & E, does git detect the conflict?

This is way too artificial that I personally feel not worth worrying
about.
