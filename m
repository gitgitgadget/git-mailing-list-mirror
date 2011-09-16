From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH 4/4] Add documentation for ref namespaces
Date: Fri, 16 Sep 2011 09:20:04 -0700
Message-ID: <7v1uvgh32j.fsf@alter.siamese.dyndns.org>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
 <1307470885-4018-1-git-send-email-jamey@minilop.net>
 <1307470885-4018-5-git-send-email-jamey@minilop.net>
 <CACBZZX4bow8vwrwSL5uRJQtAgeg10_K+5ss8u-HvCHOn3+0Tuw@mail.gmail.com>
 <7vaaa5pc8q.fsf_-_@alter.siamese.dyndns.org>
 <20110916034051.GH3144@oh.minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Fri Sep 16 18:20:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4b9F-0008VU-Lf
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 18:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab1IPQUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 12:20:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab1IPQUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 12:20:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 777E45974;
	Fri, 16 Sep 2011 12:20:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t7SdvrHAhr2Nmt45CEs6+jPZhgg=; b=AtpHhe
	8Pm0ptVf8On8cMkKKVBDANwSrF2n3liI4ReD183Y3k8B51PO8qXpU/v3VMs/JXE5
	2Cak9QJjMYTsVEmj78zcT8iKiVTC4yf9cdi8XcuM6rWZIfs1ndpJsnaZy1qbQzug
	RxER3jWmuEjTINuov4KbswA0eDEnV2ieNjaKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GEzb2aCPBHxVf8nTo4GaedvQczgRg5PH
	MvkhZss6kicgTt4obQimvq3D0P4MulhP7fGmZ0/gDE5IMGkI7xTKthZfe6TNuEcz
	PUj747CrqSH2EAfiOmulsB211p5T11uWpSAcdLP6tATQCs2/IX06Wl/ahsWD8MdI
	QqSpmPUgcaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D0345972;
	Fri, 16 Sep 2011 12:20:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07BBB5971; Fri, 16 Sep 2011
 12:20:05 -0400 (EDT)
In-Reply-To: <20110916034051.GH3144@oh.minilop.net> (Jamey Sharp's message of
 "Thu, 15 Sep 2011 22:40:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD2E728C-E07F-11E0-8F6D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181537>

Jamey Sharp <jamey@minilop.net> writes:

> Assuming that you're happy with this level of detail, and that the
> AsciiDoc syntax is correct (I'm not familiar enough with it), I'm happy
> with the patch you propose---
>
> Reviewed-by: Jamey Sharp <jamey@minilop.net>

Thanks.
