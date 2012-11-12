From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] launch_editor: ignore SIGINT while the editor has
 control
Date: Mon, 12 Nov 2012 09:44:49 -0800
Message-ID: <7v4nkuk966.fsf@alter.siamese.dyndns.org>
References: <20121111163100.GB13188@sigill.intra.peff.net>
 <20121111165510.GB19850@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Fox <pgf@foxharp.boston.ma.us>,
	Kalle Olavi Niemitalo <kon@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:45:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy4H-000647-Ai
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab2KLRow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:44:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41311 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab2KLRov (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:44:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F0CF9559;
	Mon, 12 Nov 2012 12:44:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=kJaNCqYRM+viHbb2IhZ0snLT8kM=; b=qV5zLO8/AbqhDoXfEdYg
	JtcDZcAB6zhpB+pmYHsgawlt1jh0JxaH00Dyq3mehozXDQqtF0ktcT2OIxMsubv1
	OGTP9mazSS5Zda+YGz8rI6MGO1LRXXMgQ/mv7ETkwAy2nBBONIDOQxYOElARU9uw
	bnGtTaVhu4CJDVFwkCQrS6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=SSkzrYG04ZkRpA6iBNRE3sQJvU9eVyKLBNbWhwgkTjAzoA
	gfwXcleyvTWLpdrATFPssyfnMIF2dCyggSDFaaDQQsVYK6mwMtDIX+stTRFOZ40g
	8pGBOmE20j+VnsLZNbXeJ7CbSqUNKiJPcWxiJFNw2aYAbX12UKWP4HCkbI278=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CA189558;
	Mon, 12 Nov 2012 12:44:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8C9E9557; Mon, 12 Nov 2012
 12:44:50 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A89A5BCE-2CF0-11E2-AC5E-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209500>

How did this message happen?

    Subject: [PATCH 2/5] launch_editor: ignore SIGINT while the editor has control
    To: Kalle Olavi Niemitalo <kon@iki.fi>
    Cc: Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
    Date: Sun, 11 Nov 2012 11:55:11 -0500
    Message-ID: <20121111165510.GB19850@sigill.intra.peff.net>
    References: <20121111163100.GB13188@sigill.intra.peff.net>

    The user's editor likely catches SIGINT (ctrl-C).  but if
    the user spawns a command from the editor and uses ctrl-C to
    kill that command, the SIGINT will likely also kill git
    itself (depending on the editor, this can leave the terminal
    in an unusable state).

    Signed-off-by: Paul Fox <pgf@foxharp.boston.ma.us>
    Signed-off-by: Jeff King <peff@peff.net>
    ---

Judging from S-o-b, message-id and EHLO, I think this was sent by
Peff, but came without Sender: or anything.

Just being curious.
