From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn: add support for merges during 'git svn fetch'
Date: Mon, 19 Oct 2009 23:32:08 -0700
Message-ID: <7vvdiashhz.fsf@alter.siamese.dyndns.org>
References: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Oct 20 08:32:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N08Gd-0000s8-Ue
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 08:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbZJTGcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 02:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754936AbZJTGcL
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 02:32:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbZJTGcK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 02:32:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C1D27E650;
	Tue, 20 Oct 2009 02:32:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7SSwnr3DgFYkrBfaSsfKz7v1TjQ=; b=HNam7C
	HnI7t60GR0vtDe/+B7dPZ+JyJ8fXtXw3OPnWwR4p0rUXz4t6T0VtVH+StMS47w2v
	qUMUK/avtgdMZCO3nxcDOH28t+L8gtVZe7gYLr/TNoY5dNlfQZ4bilS12kG7FEjB
	KYk995YOOaLfD3CSHpd1hAEjtRupf1FPMPLhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fq5BTinBnQGFATKZFV/KrvSHoV5hoLxf
	oKcq+v7MzFXPvh9VdCBnZa8AwPjAAdv7eHfV9d6XzH6G5GFEEpcab+X4BGlS2e8w
	ui5mOQf/Un5pHsXCGw3+nHmhraA8IYcEgvB3Khz4+9gyPeIH0MQUkoGG9qJy12KS
	wlZuOcB3jeY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 769A07E64E;
	Tue, 20 Oct 2009 02:32:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 86AFE7E641; Tue, 20 Oct 2009
 02:32:09 -0400 (EDT)
In-Reply-To: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
 (Sam Vilain's message of "Tue\, 20 Oct 2009 15\:41\:58 +1300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4CF3EF0E-BD42-11DE-82F8-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130764>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> This series adds support for converting SVN merges - in the two
> popular formats, SVK and SVN 1.5+, into git parents.

Nice ;-)
