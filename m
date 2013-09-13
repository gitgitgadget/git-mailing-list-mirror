From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2013, #03; Wed, 11)
Date: Thu, 12 Sep 2013 22:56:50 -0700
Message-ID: <xmqqvc25l0r4.fsf@gitster.dls.corp.google.com>
References: <xmqqzjrjq6ig.fsf@gitster.dls.corp.google.com>
	<52315D02.9060206@viscovery.net>
	<xmqqa9jiqd0a.fsf@gitster.dls.corp.google.com>
	<5232A30F.6050808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 13 08:00:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKMQe-0003Yh-CR
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 08:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261Ab3IMGAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 02:00:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab3IMGAV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 02:00:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2C2D3DD28;
	Fri, 13 Sep 2013 06:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=zk5Y4ry3PfD0Q2tsOXvKsN30sQo=; b=jW+eKUOsBtfWAJ9xSnxL
	1QagXkdeQX5vzXbb6cgSWZ/sU9VFKtBDvvSxj1yIR+WyGqevGmiarVr0K4aA1Plg
	vr+vpC/l3vMfV8fnkRP7dVNNwgTeTCiiSV3jqjvfE8yjhe9+7dFzctZJMCdr224e
	UdX4uzIny/plElO4/1a8dtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=F6dW4QaDNiVSGyCss+F/HcVl12dzqQtlKAhBJ1mkkn4tXd
	3Z/Ro8cJ/rr7xeYWS2tkR9jal0Y1+fFoMQAeUwdBuhDAxA9LJC6D4Uu/kxapxATU
	bDzarXv03QGYhpI5qtDAj8coKFgoDaXPtTOJKIldfvhHJKaG6VFJq4GwgXkB0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D76FB3DD26;
	Fri, 13 Sep 2013 06:00:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E8FF3DD24;
	Fri, 13 Sep 2013 06:00:20 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C57D5F46-1C39-11E3-899B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234732>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 9/12/2013 17:24, schrieb Junio C Hamano:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> Am 9/12/2013 1:32, schrieb Junio C Hamano:
>>>> * jc/ref-excludes (2013-09-03) 2 commits
>> 
>> Thanks for a dose of sanity. I didn't look at rev-parse. I vaguely
>> recall somebody offered follow-ups (was it you?) and at that point
>> I placed this on the back-burner.
>
> Yes, I offered to pick up the topic as time permits. Don't hold your
> breath, though :-)

Thanks ;-)
