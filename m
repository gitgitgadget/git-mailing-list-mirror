From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] diff.c: take "prefix" argument in diff_opt_parse()
Date: Thu, 21 Jan 2016 15:01:05 -0800
Message-ID: <xmqqh9i6wn9q.fsf@gitster.mtv.corp.google.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
	<1453287968-26000-3-git-send-email-pclouds@gmail.com>
	<xmqqr3hc57at.fsf@gitster.mtv.corp.google.com>
	<20160120202946.GA6092@sigill.intra.peff.net>
	<xmqqh9i753by.fsf@gitster.mtv.corp.google.com>
	<20160121114844.GA19318@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 00:01:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMOEB-0001oH-JY
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 00:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbcAUXBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 18:01:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751568AbcAUXBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 18:01:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D52703DFF1;
	Thu, 21 Jan 2016 18:01:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=RVB4so
	RlBAnOctz86h03jn+2jfQZMAqyKsIs46HZyh2UGAEoTXlfao+920g5iOYmzzWi0h
	CFklA1+hRs48jw7WZioNoLqX/YufUP85eTj8RvIDWwfQkmjb+K3/OEmTvhNP2jgP
	UQIUN6mAIOV3ZJv2ayJLVZqMFls+exdSVReR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DtrT4NDrfMZjwoQhzvlYsUwlltkg63mZ
	f2FwbXwzJpbpDSRFM7Uq/qeyl7SogojviPKjSEHrHRoJsPv/ty/D4GhYWUvvlaRa
	idFpdS0jyclKHmAy10Dc0hCNgajNhOxtURtf+rRkqyusPrS0ddknjRDXQtynvkbW
	U5uBLKGOG1U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD2753DFEF;
	Thu, 21 Jan 2016 18:01:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1D7113DFEE;
	Thu, 21 Jan 2016 18:01:07 -0500 (EST)
In-Reply-To: <20160121114844.GA19318@lanh> (Duy Nguyen's message of "Thu, 21
	Jan 2016 18:48:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DAAF18AA-C092-11E5-84CF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284540>

Thanks.
