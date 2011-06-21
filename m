From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with
 NO_NORETURN
Date: Mon, 20 Jun 2011 21:11:57 -0700
Message-ID: <7vsjr3akmq.fsf@alter.siamese.dyndns.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
 <1308445625-30667-2-git-send-email-andi@firstfloor.org>
 <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
 <7vk4cgb24p.fsf@alter.siamese.dyndns.org>
 <20110620220027.GD32765@one.firstfloor.org>
 <7vboxsb0f3.fsf@alter.siamese.dyndns.org>
 <20110620223322.GF32765@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 06:12:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYsJt-00035Q-KF
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 06:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab1FUEMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 00:12:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60385 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab1FUEMB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 00:12:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4F4C68AF;
	Tue, 21 Jun 2011 00:14:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kz+on6fw8axhcdACUgX+fWl1dbo=; b=g/YW7j
	xDRc7F80Lhvz+Q7FXKrTXC2tEMu5LaiPr9GT8jzG4MWPiKbuyqWaNvsYW7/AUA5G
	TfwdvCoTj/snXZ68UEJtoiolECYpaDpOrVAbUFCI7HHVrSJYitrOkfpTOrKKq0OP
	oz9qaU4xB/UHOwMafSYQu+KFiqQGHr+oZQWV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DMjL7rBwbz8MkqZzA+d3YseptSgr793S
	FoLx6YsxIkhdYjywYh9Wgh3dZjzphl+wb0pkfrtWNOtE1Q+jNFJYM942Q6kvCSSW
	czmcJWxeFiFLBGwLxDjz29vs+mtTMEAvh6FHOx+rIAvI56yF7aE37MVHumHiCa2w
	ht+sREdFvuo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BCC6B68AE;
	Tue, 21 Jun 2011 00:14:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0812368AD; Tue, 21 Jun 2011
 00:14:10 -0400 (EDT)
In-Reply-To: <20110620223322.GF32765@one.firstfloor.org> (Andi Kleen's
 message of "Tue, 21 Jun 2011 00:33:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA6F2294-9BBC-11E0-8599-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176120>

Andi Kleen <andi@firstfloor.org> writes:

>> I am inclined to apply only 1 and 3, which is what I already have on 'pu'.
>
> Thanks. 

Thank _you_ for working on this.

> I guess should add some documentation that explains that there
> are additional warnings (and some general pointers). I'll send that
> in another patch.

Yup, applied. Thanks.
