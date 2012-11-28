From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] Allow for MERGE_MODE to specify more then one
 mode
Date: Tue, 27 Nov 2012 23:30:45 -0800
Message-ID: <7v38zui3q2.fsf@alter.siamese.dyndns.org>
References: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
 <1354057217-65886-3-git-send-email-draenog@pld-linux.org>
 <7v7gp6jwsn.fsf@alter.siamese.dyndns.org>
 <20121128043608.GA17470@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 08:31:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdc6o-00068j-LT
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 08:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab2K1Has (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 02:30:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975Ab2K1Har (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 02:30:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DDB772EC;
	Wed, 28 Nov 2012 02:30:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4YDDopyDZ7jCD8dXQ5fhZLF/YVg=; b=U9rocw
	ZJYONuD51PgLVdGZc5X9EhgGkMwMx3tDpxhcbntQHwGOe5LNxAFmsJBXpTqY2WqQ
	3VAYc/r/IBLSuSl7e/jNaIpGX35q7NmTkXoLlTuhKtCb6WKxhUk1wJSetGPivN+Y
	enHfTociQsASafWgQXl6YI1w0kxo+wqJYvw6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mUx7PcQ8BhWad26AHDKMy44Pd9S9cofa
	OYrCpsiCjrSBpV52DMrVjZA3H14SvZBH+5yCzuSGq51I5beVj28CdN+H2Vx46Pqt
	cIBh+xR6dHtVj130qAG3umpHwNUMf2T4Nw6bwAZcSHgwlZ5s82kTask+FUc9VzM9
	ccLwALBhpS0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B25572EB;
	Wed, 28 Nov 2012 02:30:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A16C472EA; Wed, 28 Nov 2012
 02:30:46 -0500 (EST)
In-Reply-To: <20121128043608.GA17470@camk.edu.pl> (Kacper Kornet's message of
 "Wed, 28 Nov 2012 05:36:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86755FA0-392D-11E2-8B8D-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210713>

Kacper Kornet <draenog@pld-linux.org> writes:

> This way when only no-ff is specified all parsers should be happy. If
> reversed-order is specified together no-ff the "external" parser
> probably would fail. Which in my opinion is a good think at this point,
> as it can't correctly interpret MERGE_MODE anyway.

Amen to that.
