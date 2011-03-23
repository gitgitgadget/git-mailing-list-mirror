From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: make "add -u/-A" update full tree without pathspec
 (step 3)
Date: Wed, 23 Mar 2011 08:54:16 -0700
Message-ID: <7vk4fpg7dj.fsf@alter.siamese.dyndns.org>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
 <7vtyexv6wl.fsf@alter.siamese.dyndns.org>
 <7vpqplv65o.fsf@alter.siamese.dyndns.org> <vpqlj09a303.fsf@bauges.imag.fr>
 <7vhbaxuyk7.fsf@alter.siamese.dyndns.org>
 <20110321111643.GE16334@sigill.intra.peff.net>
 <7vtyeuiu07.fsf@alter.siamese.dyndns.org>
 <7v7hbqifej.fsf_-_@alter.siamese.dyndns.org>
 <7v1v1yifc9.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTikBQg_pT2NX9vQc+DcB+4HA35VXBpQyRtAU_ewG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:54:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2QOK-00031t-Bl
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 16:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933050Ab1CWPyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 11:54:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab1CWPya (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 11:54:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A2853A31;
	Wed, 23 Mar 2011 11:56:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1hvbz9enzWgo3y1nm4OzlRBq43g=; b=rU3pOQ
	2snK7wDCbffhUPaZOr8upYNY2qk7agqMeizNEtCt4bBIxy1pM+WOQ/9VDngeizJY
	tYsy4ZAJNnZdrb23ac7JwCF984zDA1ydlBm9NwdVbKN7FOCSWhHIPB0K4ti+aCeI
	8bK29jQdF4Qo6rs79lYVo956yqubMIaGSfots=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B5yvA5ZFCBJq2MqDInQEfln+ymmHp5nF
	QuqpskqQl+gJwr8/rL07q3V2ddYnxhSTxoytbqg9Lcqr/w6bnzwXvenWU4Ivbmnh
	7YhJRG39JY6Y87FxcdfexPs4sC+a/c/drQwvUnRwXPjnMWCY2eX2nGmxYsvtmalu
	8GtLQiZ7M0k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 485243A2E;
	Wed, 23 Mar 2011 11:56:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 812163A1C; Wed, 23 Mar 2011
 11:55:58 -0400 (EDT)
In-Reply-To: <AANLkTikBQg_pT2NX9vQc+DcB+4HA35VXBpQyRtAU_ewG@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed, 23 Mar 2011 21:02:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F3F486C-5566-11E0-84F6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169846>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I'd expect you kill add.treewideupdate too.

Of course not.  That move would be _only_ to break and irritate users who
are content with the behaviour they have chosen to use.

What is your justification?

I wouldn't be defending such a change in the flamewar after a release of
such a version, so you'd better start preparing one for your forked git
project if you plan to release one with such a misfeature ;-).
