From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Sun, 23 Aug 2009 15:30:33 -0700
Message-ID: <7v7hwurwmu.fsf@alter.siamese.dyndns.org>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
 <1250999357-10827-3-git-send-email-git@tbfowler.name>
 <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
 <20090823171819.6117@nanako3.lavabit.com>
 <7v1vn2yklo.fsf@alter.siamese.dyndns.org>
 <20090824060708.6117@nanako3.lavabit.com>
 <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Thell Fowler <git@tbfowler.name>
X-From: git-owner@vger.kernel.org Mon Aug 24 00:31:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfLaW-0000P6-To
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 00:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbZHWWas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 18:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbZHWWas
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 18:30:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbZHWWar (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 18:30:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 104B734DEA;
	Sun, 23 Aug 2009 18:30:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vXlNMVInkfADMWEW2lMMka9Mf8U=; b=spPpoY
	Y9nX4bompAhJmiDbhNOJ6PpwlMb7HuVw/ZDK4olDbrUVi4n5vF5cSu3kgu7x+VDe
	dBY+UBQCP2BlHe+ehRmpfMnyxo2OTzfiN41v9hmJO2dmzaJ/hXS8F1Pa6p/klyp5
	iWcGD07zWkx+9OIF2+DP2c/To1qd3UlEfLrNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k9sNHCLFp8RSgAzs8Yxtq8Xk4S/6ttmD
	DJdHV21mloeoHPAWZX41sEDmZOZBuKwbiEvoPW0BTmOyPBadaFxT84h35RCa1MIh
	9T4I3W4tqkRsVsv4iLwrdARRViMgtIia+DVUyxAUOWKykVeAPIDg9X1XpEL9H3SS
	UUfdo+NCMPk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF8C734DE9;
	Sun, 23 Aug 2009 18:30:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2CB3434DE8; Sun, 23 Aug 2009
 18:30:35 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS> (Thell
 Fowler's message of "Sun\, 23 Aug 2009 17\:13\:38 -0500 \(CDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97D93168-9034-11DE-8633-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126890>

Thell Fowler <git@tbfowler.name> writes:

>> > Subject: [PATCH] Teach mailinfo to ignore everything before -- >8 -- mark
> ...
> BTW - I'm happily using this and think it should be in git!

The one I sent out had two bugs.  Please discard and replace it with a
newer one I'll be pushing out on 'pu' later today.
