From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] send-email: align RFC 2047 decoding more closely with the spec
Date: Mon, 15 Dec 2014 15:13:39 -0800
Message-ID: <xmqqr3w0bj6k.fsf@gitster.dls.corp.google.com>
References: <1418572787-2056-1-git-send-email-dpb@corrigendum.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJzInYCdeJ1EnXxsoQiAbJEInJSdgJ18naSdWJ18nXCdgGyhC?= 
	<dpb@corrigendum.ru>
X-From: git-owner@vger.kernel.org Tue Dec 16 00:13:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0epn-00082c-E1
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 00:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbaLOXNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 18:13:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750878AbaLOXNn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 18:13:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5267C27474;
	Mon, 15 Dec 2014 18:13:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PH+ycFcsFV75UFzcFfgg+HyMFrM=; b=DKZA0H
	jXHra/fddCCDuc+2GFoSlR+UCeqFsFfS8AkMFbyxFXEGgQ5wxcvPpxoY2UcQwWNt
	dAuO3Y3vpB+6rhuBu08STRoUs+pgKuOWM845CLAkrMs67ldNsGDk6gp6czBoeuG1
	1dhgK/KXU+LtHcp/MZeCZgDXUOlpv0FesiGLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dl60MoNlAs2+AfyDcG1fEGwYPplc0Tz/
	KGpQ4GrCV/4EHpVvLkcQWKjY5A85W3vL3PPseMvbFymQF/H2S6rDSfl7btNYKplU
	JasxYOW4Y7tBcYsADTKXCCL6SW2ZWyM67yO/S3v1Ywql36X4EzahGkryeQk3a9qS
	nAk2GbhqlQw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4942527473;
	Mon, 15 Dec 2014 18:13:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCD3027472;
	Mon, 15 Dec 2014 18:13:40 -0500 (EST)
In-Reply-To: <1418572787-2056-1-git-send-email-dpb@corrigendum.ru>
 (=?iso-2022-jp?B?IhskQicyJ2AnXidRJ18bKEIJGyRCJyUnYCdfJ2knVidfJ1wnYBsoQiIn?=
 =?iso-2022-jp?B?cw==?= message of "Sun, 14 Dec 2014 18:59:46 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 01D5C354-84B0-11E4-976C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261434>

Thanks; queued both patches.
