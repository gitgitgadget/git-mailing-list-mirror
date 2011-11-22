From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/3] revert: remove --reset compatibility option
Date: Tue, 22 Nov 2011 13:49:14 -0800
Message-ID: <7vzkfnde05.fsf@alter.siamese.dyndns.org>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112046.GG7399@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 22:49:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSyDT-0001jN-6u
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 22:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479Ab1KVVtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 16:49:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771Ab1KVVtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 16:49:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A3E653BB;
	Tue, 22 Nov 2011 16:49:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IzK6cMXmDsyYrOe7QMrXpriVzZc=; b=mie82C
	04og87YQ362HCrRSuDTFTNW3DiTkMusGeyc1sVx/o0BhnQRLnP3Pm1CC385HGfp2
	vODXP05ZBYdvMeCg8XdnewQegZ9vg0Wu7goHO1/rVrNIi3Cbdqf1/4rr8H2Mc1YK
	8f5ow8isCv1+pZO5xqtq5qd0mp2O47J3MHjnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wLnlBpOMe5r3ip2GlN7SQewWLXjssbzw
	3XNspKqqGpWI+1teUVlreVzpoJpPO7X4XmvLVLbfX0tvsxog1zwfZvQc63hSfb43
	wr+7G4T62ZbB3h0YwGv8Jvx/GyvwRslhmNkyUPsRHpMieGeMcK0ooPnMi3eSvV0/
	+/5xMaFz2M0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 810B653B9;
	Tue, 22 Nov 2011 16:49:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BD5453B8; Tue, 22 Nov 2011
 16:49:15 -0500 (EST)
In-Reply-To: <20111122112046.GG7399@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Tue, 22 Nov 2011 05:20:46 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2CC1956-1553-11E1-BAFB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185812>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Remove the "git cherry-pick --reset" option, which has a different
> preferred spelling nowadays ("--quit").  Luckily the old --reset name
> was not around long enough for anyone to get used to it.

If we want to reach this point eventually, given that --reset was not in
any released version, and also given that we are deep in pre-release
phase, we probably should either just apply the first one (and perhaps
this one) from the series immediately before 1.7.8 final, or delay the
final and swallow the entire series.

I am not quite convinced that quit is *that* superiour over reset
though. The description in 1/3 "has a confusing name" does not say why it
is confusing, either, to help readers agree with the conclusion.
