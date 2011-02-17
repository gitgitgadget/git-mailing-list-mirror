From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 (v2)] t7406: "git submodule update
 {--merge|--rebase]" with new submodules
Date: Thu, 17 Feb 2011 12:18:08 -0800
Message-ID: <7v4o82bekf.fsf@alter.siamese.dyndns.org>
References: <1297959526-8089-1-git-send-email-olsonse@umich.edu>
 <1297959526-8089-2-git-send-email-olsonse@umich.edu>
 <4D5D7A45.6020204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Spencer E. Olson" <olsonse@umich.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 17 21:18:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqAIz-0001P5-3l
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 21:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592Ab1BQUSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 15:18:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab1BQUST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 15:18:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1408F346B;
	Thu, 17 Feb 2011 15:19:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nODrWP8BuOeWzqxNCaCCKBrblXk=; b=dzsc4T
	yrrtAdZcpjkE9Uldqql+ASQsBDh6XcWuH1IciQdceuRbldkTR2wanoVLqjYB2ply
	b4e3z/8x4v7Y0oAcpFw1R9UXqfXuQNPDfS/2v1L+wX2ZTKwxa7RaW5zSxBLNx+g7
	Ysu2o8dM2OD2Lx2yzW/cwoytLcdhxnfNghKIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d+G3KsZKUvDbnvRgSGEJB6ltBpO4Q4gR
	JI0DAi93eWDip55BfLo6BQjxw4wxpVMZEBv+SFYX0i/svq+AgyZWjGf9Q9B1BOIE
	x6VKU76r+s+yTy0Unly45+OVA7XeFegvgNpPkEhKdxOwp0gbUKRN4fuvKEvc42UA
	2//cxyuseWY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D66083469;
	Thu, 17 Feb 2011 15:19:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 932AD3460; Thu, 17 Feb 2011
 15:19:17 -0500 (EST)
In-Reply-To: <4D5D7A45.6020204@web.de> (Jens Lehmann's message of "Thu\, 17
 Feb 2011 20\:43\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 355505EE-3AD3-11E0-8180-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167112>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> This should be fixed to be able to detect regressions in the future, so
> I came up with replacing the "git submodule status submodule" calls with
> "git status -s submodule", which did the trick for me.

Hmph, is that a bug in "git submodule status" or is the subcommand
deliberately designed to ignore this class of differences?
