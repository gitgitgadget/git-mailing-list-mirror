From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/38] rename_ref_available(): add docstring
Date: Thu, 09 Jun 2016 08:08:38 -0700
Message-ID: <xmqqh9d2jt6x.fsf@gitster.mtv.corp.google.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
	<5eb96cc20c0f76aff39d1556803ebd4f9f422cea.1464983301.git.mhagger@alum.mit.edu>
	<xmqq7fe0rhts.fsf@gitster.mtv.corp.google.com>
	<57596A7E.9020407@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:10:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB1Zp-0006G9-0n
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 17:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbcFIPIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 11:08:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752562AbcFIPIr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 11:08:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CD8E6213AF;
	Thu,  9 Jun 2016 11:08:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DELg24woCeHsVVGuD0L8vct/ARY=; b=SvAaxu
	srqjWeJ+/WDUjUEiDaWr4otUAn37J4FIBPkdeMn5nfnOiRr+Q3GKDfSemk5i9ebN
	RwWJ6zP64p277Gtxk5ve9kZmo00RWETF9hdLUK+uKS1vhUt2vpzlnEi1czhN/lTC
	pTUu9HlvOO9EKdA4osTg/xlha9pK3JfThddCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nQ6wipB0QxyzFdCm1k99oZJTlXXtHXoh
	9kh3cRORXKUKAuwY481HOdxylDt/GcnDOtltIptSBLJY3eamP76xKtLfSjBp82h5
	H1YrOQW4IHN6ZkFIuBf4pOliEVIX+6YBaFfkLOTx/dcq2ciEa3PTL8YTqLpjI4NN
	DB9NXssjMag=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C3BEF213AE;
	Thu,  9 Jun 2016 11:08:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46B16213AD;
	Thu,  9 Jun 2016 11:08:40 -0400 (EDT)
In-Reply-To: <57596A7E.9020407@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 9 Jun 2016 15:09:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C865210-2E54-11E6-BE40-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296892>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I propose to change the parameter names to `old_refname` and
> `new_refname` and to change the docstring to
> ...
> Does that sound good?

Yes.
