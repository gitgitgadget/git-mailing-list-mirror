From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 00/16] Interactive git clean
Date: Wed, 26 Jun 2013 11:03:01 -0700
Message-ID: <7vsj04vjfu.fsf@alter.siamese.dyndns.org>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 20:03:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uru3j-0006sh-Fj
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 20:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848Ab3FZSDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 14:03:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839Ab3FZSDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 14:03:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 903692BABA;
	Wed, 26 Jun 2013 18:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xdX7O3U/qKLKAKcHBnHZgLNUk54=; b=wVQmNa
	JZVAnAV7nmsIM3P8a82VW98tQWmKTvPpz+bHoTFXSq3pXDvyepSm1SxMYBnXlSCX
	RkXoFshdiJDTLIXbetBi1Dgae/YwUJTByUTK+qfxt4r+muuBg8LILGLL7bOsnx9m
	68OeIJOcBo0aRRs8u2SV75JJ1nYvD9UR8meMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lKcCx51l7qtWOTTfv1iSaA4/KLziy5le
	9jXtxqv3USzFo9yyXm3w8K/nhru65+IRpK5JkaJzRfR5rJEFoSh4siulTMYEr46b
	9ukY0qssMfm8Uci1/eg4ZJJH8zdflrrDvtKjybfDDqTUOLxnlIM8uV5T5pXa3jHm
	Sj21z2bbGSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86EF52BAB8;
	Wed, 26 Jun 2013 18:03:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EFFC2BAB3;
	Wed, 26 Jun 2013 18:03:02 +0000 (UTC)
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com> (Jiang Xin's
	message of "Tue, 25 Jun 2013 23:53:41 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5107CC6-DE8A-11E2-A47A-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229051>

People may have comments and improvements on the actual
"interactive" UI part, but I think the earlier parts up to "into two
phases" is ready for 'next'.  Let's queue them and have them
advance.

Thanks.
