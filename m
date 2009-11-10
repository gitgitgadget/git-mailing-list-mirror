From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: "git svn clone" does not honor svn.authorsfile setting
Date: Tue, 10 Nov 2009 12:18:35 -0800
Message-ID: <7vzl6u5e1w.fsf@alter.siamese.dyndns.org>
References: <20091110130913.GR19475@poetic.cynic.net>
 <fabb9a1e0911100524p2cf3f2ebp698ecb50fc53f8e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Curt Sampson <cjs@cynic.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 21:18:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7xAy-0003fx-D0
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 21:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053AbZKJUSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 15:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758048AbZKJUSl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 15:18:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758035AbZKJUSk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 15:18:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CFD47B064;
	Tue, 10 Nov 2009 15:18:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=rFVkSGQ55Fc7khsxtWhZ3MkjKUI=; b=JTVOnOoh9DJdzij8ZXIcimr
	rgeNOhjq2cfnyFMqRtlWRFJ4q4sSeDnvqJ2+UfhAvQpoJE5+/U+EgXofRQ9K/+2i
	3XfjMlVJV2PQpzeWCgxUDYWH7ArIv/gOTAGP76db3XfP4CZnbb8qrdUlzDT7RBtD
	s1YgDsIhuc4URi7/gyJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=BPuxCOiaWK/ah4zkFn7Nr4b9OoTzg7bF4mMma0xBxYvR1T5yg
	j7f0z8mpKE768onFXca4K5p3yBC70P8t9JVAj5N8kmw/BeiVYPxT2QB2hx+Zj6sQ
	yJDe3TU2yxZQyF0CbGz51LQiRCyj06GRa9h/xO0Mi2uNaaOgf+bQmuqZ4c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DED9A7B063;
	Tue, 10 Nov 2009 15:18:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 446D67B05B; Tue, 10 Nov
 2009 15:18:37 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3DD858C0-CE36-11DE-BD09-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132594>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Tue, Nov 10, 2009 at 14:09, Curt Sampson <cjs@cynic.net> wrote:
>> [Note that I've set Reply-to to both myself and this list, as I am not
>> subscribed to the list. Broken list software and MUAs sometimes don't
>> honor this. Check to whom you're replying!]
>
> Please don't. It is custom on the git list to always keep those who
> are involved in the conversation cc-ed, adding a Reply-to makes this
> difficult.

I've seen people use Mail-Followup-To to cause grumbles, but Reply-To
seems worse in a sense.  If I wanted to respond _privately_ to Curt, and
said "Reply", the message would have been broadcast to the public, and I
am using a MUA that is *not* broken and honors this setting.

Not good.
