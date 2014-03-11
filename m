From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --parseopt: option argument name hints
Date: Tue, 11 Mar 2014 12:10:13 -0700
Message-ID: <xmqq7g80r1pm.fsf@gitster.dls.corp.google.com>
References: <1393842740-4628-1-git-send-email-ilya.bobyr@gmail.com>
	<xmqqwqg9kbuk.fsf@gitster.dls.corp.google.com>
	<531D51EC.6050503@gmail.com>
	<xmqqk3c1rfqj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 20:10:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNS4G-000751-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 20:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbaCKTKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 15:10:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbaCKTKR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 15:10:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94C2F74594;
	Tue, 11 Mar 2014 15:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DtiHpPpIf9wzoTXUfVA+WG54jAg=; b=Ba3N0J
	rnFF3yMAKJDiZs1aLWJn+ypi8YJNtyH8PJefecVuzDfRFMYhf1OhgGWKC6sE57jH
	MLjDSCNT/Y4pmQNalrb47v6mAZE8Lu/uJytXAMzqsPCnq5F6TPfeSJLyTv4B0lvz
	S5Y+twdMHi17volOvNa+1pMHHspx0QrmBu06Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r6vT3gFokTF0SiofwVvjRtSUzTMLDK/l
	FDPoE0qQx6/r5WAtAGNAlpQufW/5ZKHJnaPc0DBWBUaaQzJ3j1Q5KNFx0egpXRmi
	RNXO8HKsDVQATfAv2ONJ0VZplOQeLGlCc+CUbCOxYVGi4Bg5BfhW8A7j/GqBN3DP
	eptjDnrykf8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BD6274593;
	Tue, 11 Mar 2014 15:10:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B06F674590;
	Tue, 11 Mar 2014 15:10:15 -0400 (EDT)
In-Reply-To: <xmqqk3c1rfqj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 10 Mar 2014 12:55:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C74B5540-A950-11E3-A6BE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243880>

Junio C Hamano <gitster@pobox.com> writes:

>> Documentation on the whole argument parsing is quite short, so, I
>> though, adding an example just to show how usage is generated would
>> look like I am trying to make this feature look important than it is
>> :)
>
> You already are by saying the "Angle brackets are automatic", aren't
> you?

That is, among the things --parseopt mode does, the above stresses
what happens _only_ when it emits help text for items that use this
feature.
