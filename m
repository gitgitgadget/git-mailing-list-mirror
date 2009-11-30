From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset: add --quiet option
Date: Sun, 29 Nov 2009 23:17:51 -0800
Message-ID: <7vvdgsxyzk.fsf@alter.siamese.dyndns.org>
References: <1259492290-21771-1-git-send-email-felipe.contreras@gmail.com>
 <1259543939.5679.5.camel@swboyd-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 08:18:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF0WL-00075S-4j
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbZK3HR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753864AbZK3HRz
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:17:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbZK3HRy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:17:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9028CA254A;
	Mon, 30 Nov 2009 02:18:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K1e9Pl+zn8f3PXigzS6TESCTxZo=; b=WHCD7D
	toBFmYwQEmmj7cAaO/7iVZKzUyCOklx9+8/mbYzjNrV28ozPsuHJ5ewgFV0djfL0
	tHsrU8f8DygtOxLllJX32ELp4B8wiaP3lOMw7Ts37MJ2NuPjBhxmOFwG70Hlwzxu
	GaPaaR+aDzzeR08gXjOLPKrSzb1JhdKrFWrys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fCd2ut54nukzvxlDfMa1MdISg+pJA+HR
	xJw3YzeJkTcpMjtq2RhAp4AudNm9ID5MA06U7VRXGcgL9nIg1No20EK5qZEAlwfl
	aPnewmqyx5hYh5udmSb8cJxFzGh/AUge1KRhHz3W8NEigcz4XjB4OjzW473U7nwV
	vgUO341LUAo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 60078A2547;
	Mon, 30 Nov 2009 02:17:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 317E2A2545; Mon, 30 Nov 2009
 02:17:52 -0500 (EST)
In-Reply-To: <1259543939.5679.5.camel@swboyd-laptop> (Stephen Boyd's message
 of "Sun\, 29 Nov 2009 17\:18\:59 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7BFD7E10-DD80-11DE-9B7F-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134064>

Stephen Boyd <bebarino@gmail.com> writes:

> Why not just OPT__QUIET?

Good question. I was in no hurry to queue this, so Felipe has plenty time
to respond.
