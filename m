From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] submodule config lookup API
Date: Thu, 12 Jun 2014 15:04:41 -0700
Message-ID: <xmqqtx7p4wee.fsf@gitster.dls.corp.google.com>
References: <20140605060425.GA23874@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 00:05:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvD7A-0005yR-3O
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 00:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbaFLWEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 18:04:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60519 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbaFLWEr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 18:04:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1463C1E1A2;
	Thu, 12 Jun 2014 18:04:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sGr+vWGkXsUHeD0xk7f8wILhGJg=; b=DxrUtS
	SAzmuCRF2wRmBZRvwuKhJSC9xJg/PNe4lgTr3TRVOefR4ISnj1hlnepqI6vcrc+7
	kGMh7ijYeCpX4vdxIaCuHyez6GjA/VOj1B3bOnm1I4aCQ7BNG7+e73j/msUz6n7U
	9xM+oHjzUM0WYrppJgCPrfbn2ZpkoeskxXGis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DSGDrNwXF9MlTxHa+pHubuO82jNm71uv
	ncUysN1YaW4bevdlmB8vUf4KM1NHDOhSDWnQNvui0t4aM+U/zfKf7NLgjc8utg5T
	RaATcJAVyDNAAwtKOhV2yB0QX4puQi3C1fdNdbJIokD2f02W0wtML7XX2Zq6px9A
	4REBifEYBUg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 080281E1A1;
	Thu, 12 Jun 2014 18:04:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E2F611E199;
	Thu, 12 Jun 2014 18:04:42 -0400 (EDT)
In-Reply-To: <20140605060425.GA23874@sandbox-ub> (Heiko Voigt's message of
	"Thu, 5 Jun 2014 08:04:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8EA780C6-F27D-11E3-9EDE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251500>

Hmph, this seems to conflict in a meaningful (and painful) way with
Jens's "jl/submodule-recursive-checkout".
