From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/init-db.c: eliminate -Wformat warning on Solaris
Date: Tue, 20 Dec 2011 16:04:17 -0800
Message-ID: <7vmxamiyda.fsf@alter.siamese.dyndns.org>
References: <1324423661-31174-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 01:04:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd9fV-0002RK-PQ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 01:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab1LUAEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 19:04:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47515 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829Ab1LUAEU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 19:04:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BF9762AF;
	Tue, 20 Dec 2011 19:04:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CrgaA5GNIW03FB5jIORyjda0DtA=; b=Sxj8/y
	Dy9s6cs0C0Y7C3WFDqQ+1xWg9nmUo6u+lBVH3hTkbp16IkezUgBH/yF/KTHXVcSv
	zyChXSqu6BO14ZKeIm8J/K+5YLrkOUEEQi5I66VfchQRV134ePuKMKhgSbd3lxX9
	Zqu45c/O0JQ4682TGdrUhNgjoPD/j3lhmsggc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XWsty4UTuGDmS1fS9ZBCe49rPTQf0Np0
	XR11Q14XMlnhlAv4JsUccUs2C2YlOowRTl93iJd/2cr9q4+UhT1qiIwEyVzVrEEf
	yAK5Eswi/Pq3rcFVHyz/EdYNOMK0AQXxGE4nCEVhNCdp5zY+doSAeHkKjbIadEoY
	TZYDu3kNXBw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6437D62AE;
	Tue, 20 Dec 2011 19:04:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6BB662AD; Tue, 20 Dec 2011
 19:04:18 -0500 (EST)
In-Reply-To: <1324423661-31174-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Dec
 2011 23:27:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 540CA1D8-2B67-11E1-9B49-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187538>

I will queue this directly on 'maint', as I do not think it is worth
fixing immediately on top of 2c050e0 (i18n: mark init-db messages for
translation, 2011-04-10) and merging all the way down to the now-ancient
v1.7.5.X series.

Thanks.
