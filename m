From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 02/10] Show items of interactive git-clean in columns
Date: Wed, 08 May 2013 10:02:24 -0700
Message-ID: <7vmws5flr3.fsf@alter.siamese.dyndns.org>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
	<6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 19:02:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua7l9-0005H4-L8
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 19:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173Ab3EHRC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 13:02:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34993 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757089Ab3EHRC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 13:02:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F4F41AA8E;
	Wed,  8 May 2013 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mJkLW5/qyUs10ZOc7b6UTVm4ZvQ=; b=eB6yr/
	qmxo/NYAXU7psM60M9QD/7nF0Ncc2pXSx7BoA1WtwH8ymDvWdODvBFyNtwLhHHbU
	qA7pgt1a8LJapJbpo31fQD2+6ycaAc0TYDe8X26NCmMf908PHNNejFujDgMe0fmq
	Vc7pY2En9l2EGuuWP1kKdgWNke5edSZggu/bc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e8ldlzbK6TNSr31vEdN7hgM+2mvrYcmv
	UA2EBHx8m2UrcIJ7lIbyJccPeNcojk5uS5MnyRWLMpqePSuMSCckJhmFc80gXA3v
	7I+NCgnzE3CfolHPtla9jqKAVCv5MN8rHL/cpLDcBfW4RgJ50YgyYTy+RcCZO364
	ziB3d/ZXlWY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92EA31AA8D;
	Wed,  8 May 2013 17:02:26 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BA911AA8B;
	Wed,  8 May 2013 17:02:26 +0000 (UTC)
In-Reply-To: <6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Wed, 8 May 2013 19:38:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F08E81C-B801-11E2-A227-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223678>

Nice (I didn't read the code, though).
