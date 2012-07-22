From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git with large files...
Date: Sun, 22 Jul 2012 13:54:13 -0700
Message-ID: <7vvchfple2.fsf@alter.siamese.dyndns.org>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com>
 <86fw8mf3gp.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Darek Bridges <darek.bridges@me.com>, git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Sun Jul 22 22:54:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St3AT-0004eT-J8
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 22:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab2GVUyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 16:54:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585Ab2GVUyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 16:54:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF6788819;
	Sun, 22 Jul 2012 16:54:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8usn/Atwy4uE7RtHspeo8Y8XY6s=; b=XIswBt
	0SFuJ1i0cXvarMstC3FKvfE0SVHBEkM0fu1L4PvnMv53D3qd27NOw4+aFfTHUAgH
	Ci6+4yBWYaSlUEhSdXp5pD1iVZ26lNOXSCK6ymMGoH/WPy2i3RY5QpTpT0/byuIM
	yX5d+J7pVeKGhJTE82Knzp51wjouJjoyIhwMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MIWsNjGaHJBoXonvW3jQgBH24SEHWlt2
	GGi5x2EMwMpByNUeI41AtADdNzoUcYnIz1Z2q6mH2NFBGch6rOX5vOhrdwxEoqYT
	/H+Ew0rQDTL/Qu0hgzAR9GAGtKTp4YOPj7q8w5wCCu8yYOpS70ZLctUB8ZRTxV4E
	KEGxpc9sTXo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC1898818;
	Sun, 22 Jul 2012 16:54:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47EF68817; Sun, 22 Jul 2012
 16:54:15 -0400 (EDT)
In-Reply-To: <86fw8mf3gp.fsf@red.stonehenge.com> (Randal L. Schwartz's
 message of "Fri, 20 Jul 2012 15:54:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65C15118-D43F-11E1-8A68-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201863>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Darek" == Darek Bridges <darek.bridges@me.com> writes:
>
> Darek> I use git for many things, but I am trying to work out the
> Darek> workflow to use git for deployment.
>
> Don't.

Yeah, "don't think 'git checkout' is a way to 'deploy'".  Using Git
as a transport measure is probably fine.
