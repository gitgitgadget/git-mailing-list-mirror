From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] Improve hideRefs when used with namespaces
Date: Thu, 05 Nov 2015 12:46:34 -0800
Message-ID: <xmqqegg45g45.fsf@gitster.mtv.corp.google.com>
References: <1446703651-9049-1-git-send-email-lfleischer@lfos.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Thu Nov 05 21:46:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuRQg-0000MD-67
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 21:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbbKEUqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 15:46:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751522AbbKEUqh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 15:46:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2DE5127F1E;
	Thu,  5 Nov 2015 15:46:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UBIl5xIDgLu4hfUmJSt5v6eObgw=; b=Psc38k
	oubm08ZsoAEQv0tOfKiSGpnaZvgvfFO39G33QepVTXHcffT8KRTR8MbN/C6HCp9J
	fTFDx0NTVAsjiZ9QkuK22RK33X/kyOkjJ2U5vEbuXWkr7IY1+3nuvNO7AKXW/xQA
	W9BwJeNsoRsrz+Q4/PF3f6fF83D0Ccd/U+7uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uvw1OVmMznVq4yfkSgGPJUwt3HN+ff6c
	ko/XOYG42EEo8UGFTYbfpXZDPXJQJ9Fp8+qCU5LhexgrRvlQrW8DUClSbxs0irfc
	R/6K4tj2CbmEN/Uq76164QMLR9E3llXsNhk2lnuWuzCGRSJeW6nzbbKKV0Zei/ge
	nT3AXScG0KI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2434827F1D;
	Thu,  5 Nov 2015 15:46:36 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5AC8827F1A;
	Thu,  5 Nov 2015 15:46:35 -0500 (EST)
In-Reply-To: <1446703651-9049-1-git-send-email-lfleischer@lfos.de> (Lukas
	Fleischer's message of "Thu, 5 Nov 2015 07:07:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4DBD0914-83FE-11E5-A2AA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280938>

Thanks; will replace what has been queued.
