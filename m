From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 04/10] git-clean: use a git-add-interactive compatible UI
Date: Wed, 08 May 2013 10:02:37 -0700
Message-ID: <7vip2tflqq.fsf@alter.siamese.dyndns.org>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
	<6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
	<d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
	<e7cf5d7ffd83e238078b4585ac4bef4ec9a48e21.1368011946.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 19:02:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua7lL-0005Sm-V3
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 19:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441Ab3EHRCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 13:02:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174Ab3EHRCj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 13:02:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 328FD1AAB0;
	Wed,  8 May 2013 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mJkLW5/qyUs10ZOc7b6UTVm4ZvQ=; b=SY5O57
	qRn/4Em21csV5vkyL56UhZsHNLVslwhX7eDzlYqPArFZwDv97CxmSXbJHxKAmF8O
	MYGUUAYEbYHIve3pJK3FaezckoG+bepghLGr5K5+sTzR83UmMTECkKDsU3MuBO4s
	6MHLpI9ZUuQZBiVbod+kmVGfz3kajXXq1Ns88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BrYsP2kM1ybUCIIwVkitdX9aawBk/aUz
	AhDnoxhoTmKWoR3PkKmVwG4Tx1O1rJOf4VyS+fDpNt28CEyQ0yppYMCumyB8zIXL
	AfUpQMlRCj9WQetsG+agt/d9vpDUGbuQtzTvFGonleGeJaoTTsIn+x678p0Bw+VH
	efOcajjJ0vw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 296431AAA2;
	Wed,  8 May 2013 17:02:39 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99D7C1AAA1;
	Wed,  8 May 2013 17:02:38 +0000 (UTC)
In-Reply-To: <e7cf5d7ffd83e238078b4585ac4bef4ec9a48e21.1368011946.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Wed, 8 May 2013 19:38:49 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 167E6A86-B801-11E2-B06D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223679>

Nice (I didn't read the code, though).
