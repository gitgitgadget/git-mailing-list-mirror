From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] ls-remote: introduce symref argument
Date: Sun, 17 Jan 2016 14:15:59 -0800
Message-ID: <xmqqsi1vetsw.fsf@gitster.mtv.corp.google.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
	<20160117151622.GD15519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gummerer <t.gummerer@gmail.com>, bturner@atlassian.com,
	pedrorijo91@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 17 23:20:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKvgW-0003d6-Lr
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 23:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbcAQWQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 17:16:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755579AbcAQWQC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 17:16:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A449C3C083;
	Sun, 17 Jan 2016 17:16:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rTDyzpfBBIHDM9z/lDRQMzb40J0=; b=OfnYg2
	gPx0v+XSirGJe/isWObIlHbeq8rricpFlYff7HZR6VnyU0Eflo/mXXRPLgzUKipI
	dkZAnZHgFPY31gsFD7PlyC990DVmu1efOqW1OpduNKra9ZvrEy+btGbBYlZccPGA
	O3wlIIlMI5kIX/F8xL55oZ7h3oxmNFE0E1F64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tRc88DWvA4QNOuabuDzN078D9PwTDxks
	wAXz7L2EDv//WVomW2q0DK6wLfYuY62CxqY+fcuCO0j2zpIRVbbfDBPP7Y6OZ9Eb
	3rn3PFKH4To6Mzqg0cpb1s8yg4M2B2Ylxn+p2eusWRXOnnNF4CiGKgVBX7NsNjeP
	57aqP4MJoc8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 453D73C081;
	Sun, 17 Jan 2016 17:16:01 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 421463C080;
	Sun, 17 Jan 2016 17:16:00 -0500 (EST)
In-Reply-To: <20160117151622.GD15519@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 17 Jan 2016 10:16:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3A03D3C-BD67-11E5-9B61-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284267>

Jeff King <peff@peff.net> writes:

> Thanks for working on this. One of my favorite things about open source
> is when I realize I'm too lazy/busy to work on something, and then it
> magically appears in my inbox. :)

;-) Once you suggest guess_remote_head(), 50% of the necessary
brainwork for this topic is already done, so you should take as much
credit, too.

Thanks, both.  Lookikng forward to a reroll.
