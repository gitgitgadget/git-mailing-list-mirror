From: Junio C Hamano <gitster@pobox.com>
Subject: Re: questions / suggestions about history simplification
Date: Thu, 26 Dec 2013 01:56:39 -0800
Message-ID: <7v38lgkka0.fsf@alter.siamese.dyndns.org>
References: <20131219183645.GD23496@pacific.linksys.moosehall>
	<20131219190333.GE23496@pacific.linksys.moosehall>
	<xmqqsitoefvi.fsf@gitster.dls.corp.google.com>
	<20131219205858.GJ23496@pacific.linksys.moosehall>
	<7vr495jsf8.fsf@alter.siamese.dyndns.org>
	<20131222134156.GM23496@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Dec 26 10:56:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vw7gO-0008CG-Lr
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 10:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab3LZJ4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 04:56:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33077 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733Ab3LZJ4j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 04:56:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01D9F50F3A;
	Thu, 26 Dec 2013 04:56:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tC9/ZmGmCzLsyq9XnlhmlEI9qPI=; b=Zc73fL
	8SidV7jjfUt+PK2jDE41j8PluQfCGhL9333Kd7It6b94Dr4kNyQLATNwb+WGFcos
	YW9seQx2g6CuJ3rt0ArBTePDE6eot0loQOmJK1z53FCoUNZ869AaMozazp2giV6+
	cPb1nEaRB4S27u5gtGvc7WptDMXjGkjZxymX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KQOfhZPm7k/yzJOxnkQDxbHPxSSd2SzN
	FWf4XfZQQA/f1E+BpkzVDmjwtqplkRiqvQIddq5wwAW8ZnXzKDnsoIfQGQQC0DXv
	Hj3Km1lJbAz8Ef8yW8b9dh2rZEM9fDiGNmxfvFr6dlux3ozZ/3WSOxrOffiPYeDr
	HnPkFNdeQH0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2C1250F39;
	Thu, 26 Dec 2013 04:56:33 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B59C50F38;
	Thu, 26 Dec 2013 04:56:33 -0500 (EST)
In-Reply-To: <20131222134156.GM23496@pacific.linksys.moosehall> (Adam Spiers's
	message of "Sun, 22 Dec 2013 13:41:56 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 00361796-6E14-11E3-A7E2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239688>

Adam Spiers <git@adamspiers.org> writes:

> OTOH, including a sample repository embedded within the git repository
> is either impossible or very ugly (e.g. having a non-default value of
> GIT_DIR for the embedded repository).  But I doubt you were suggesting
> that ;-)

No.

By the way, t/t1200-tutorial.sh was meant to follow what the
tutorial manual tells the reader to try. We may want to update
and/or enhance it to cover more materials.

Thanks.
