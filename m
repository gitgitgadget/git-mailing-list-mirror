From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add tests for git diff --submodule
Date: Sat, 24 Oct 2009 12:25:33 -0700
Message-ID: <7viqe461ci.fsf@alter.siamese.dyndns.org>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <4AE192AD.70603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 24 21:26:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1mFT-0002jY-LA
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 21:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbZJXTZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 15:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbZJXTZo
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 15:25:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbZJXTZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 15:25:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C30784153;
	Sat, 24 Oct 2009 15:25:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=xaLrePAVlNAEvUBmja4lc5O4pk0=; b=cHbT1gNi8d6fHbS8uKdWoLp
	xCoYCKlh/lCD1lAyY+Z5IoXo8vzLYjrMBNp49rrZyLTMu3l1idq6MDuCCDT2K8wA
	CnVsLIg0fSYAPb8Zu7+ZL3uJXWC6vLaDDiys6gbNi2aUuC5jqm0iVNQu18z4sj9r
	pjaqz3S7sQyeYCvl8yac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xZ1AmJq5oTE+FV9rV5xcBAdv6JdtLrTZ64gEDLnIcWSLkxA3r
	bHvHX4takR7dVY1VFxtvLHyg/OoqFvn57Jqh7Q2mo3dQKVQL3Hct4HByTG8gTKV8
	GuVFzGpWJkCDDOpjp8swSe7Dnl0pWTMm06Bz/lwQhj6FGFmu1Z0miC1snA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4CB5184152;
	Sat, 24 Oct 2009 15:25:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E4CBC84151; Sat, 24 Oct 2009
 15:25:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03D69738-C0D3-11DE-9387-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131174>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Apart from your changes necessary to make the test run again my changes are:
>
> - rename from "t4041-diff-submodule-summary.sh" to "t4041-diff-submodule.sh"
> - corrected all comments still speaking of "summary"
> - added tests to test the behaviour of "--submodule" and "--submodule=short"

Thanks for a nice summary.
