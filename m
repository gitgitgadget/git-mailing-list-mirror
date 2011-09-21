From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] read-tree cleanups
Date: Wed, 21 Sep 2011 05:14:06 -0700
Message-ID: <7vaa9y2hom.fsf@alter.siamese.dyndns.org>
References: <4E7996AA.4040909@drmicha.warpmail.net>
 <cover.1316590874.git.git@drmicha.warpmail.net>
 <4E799799.8060106@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 21 14:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6M5P-0005i7-K5
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 14:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab1IUMj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 08:39:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61800 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753623Ab1IUMjX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 08:39:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A84A4719;
	Wed, 21 Sep 2011 08:39:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=72W6V8o1vsv/Vl0pg+p9ZPnaC9E=; b=OgQlFGryeze9Gobg04Ht
	Gde5EWvRCB1Yq7ev8CXvn7iXH+PDn9L1uOC8KszcDzFjVEUDbwe9RsruntrXK+q2
	hqMqnqVe/6qvIAHZBBSx45AI67xbPbbUMS9HKEiDVfw4h7f/vMCRvS6gKChofOdp
	REo/+aZXjp6UAKZafb9foUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Ad9YgY64T7B+zgoHRTZxDIyv9BP06KShtF6XCirB+VTVlX
	Kw5ueWTgn5Mix06ye0xKAaLj5YUwa/3gg6YIoO+RiHD/ApS5SyutgJK5fsfNefqa
	or5d8C17mwWcAK8XNE7FwsR7RAc4EVscyz8nC9yqaKGHtdtCe0Hv4EikySOpg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02A474718;
	Wed, 21 Sep 2011 08:39:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9277D4717; Wed, 21 Sep 2011
 08:39:22 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB8A33D0-E44E-11E0-AFB2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181841>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Uhm, I forgot about the dont-cc-jc-in-rc policy, sorry. This is not a
> late-minute regression fix and can wait.

Thanks but that is not a policy; merely my preference.  It also is a bit
unnecessarily stronger than my actual preferences, which is

 (1) I do not want to see a patch sent "To:" me as the maintainer the
     first round of a new, undiscussed patch, as if it is ready for
     inclusion, at any time, not just during rc.

 (2) I do appreciate a patch sent "Cc:" me as a member of the development
     community patches for discussion, especially to areas in which I am
     an area expert, at any time, including during rc.
