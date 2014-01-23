From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Thu, 23 Jan 2014 09:22:06 -0800
Message-ID: <xmqqtxcuvcjl.fsf@gitster.dls.corp.google.com>
References: <20140117041430.GB19551@sigill.intra.peff.net>
	<20140117042153.GB23443@sigill.intra.peff.net>
	<398F146D-72F1-44CD-B205-729665FD8765@gmail.com>
	<20140121053026.GC5878@sigill.intra.peff.net>
	<5B91161D-7B06-4C80-9554-89F379C4E2A6@gmail.com>
	<20140123021407.GG17254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Yuri <yuri@rawbw.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 18:22:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Nyr-0005aS-52
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 18:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbaAWRWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 12:22:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42723 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054AbaAWRWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 12:22:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE3476455D;
	Thu, 23 Jan 2014 12:22:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ujySv+c2++blr/aeKuCEDlESEBM=; b=CYNvrI
	K0TS3ToyQsV8nmt6i0MfReAquHg8d70WA99kybU2oJgi5zYlHl50bmhC4q1M9TEK
	TToi5B4JowXFKs+fNpdNJcIV4XB7qKzauee6/P0C/smCbWm1JBo9KTKOfkoQnZKv
	CYOOSsjVwNteUeFmG3ro5xZZeSuUJgBkISNcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fCEi6jubtWcodVU9byn/X6zGdCiKrlhe
	zexuLe3RX9B5W6oZz6eBKvkxIs6Mrq3zdR/tuRjOYxLDosl6+QYbowXYWeP1n7R3
	pZ/faFv8z80tJjvimauuJbEKphRLiR0EJPjpXjZW4gUGfn4aFI6HVgcTzdPa/pIA
	SSA/aqFI2to=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 982556455C;
	Thu, 23 Jan 2014 12:22:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA58464559;
	Thu, 23 Jan 2014 12:22:09 -0500 (EST)
In-Reply-To: <20140123021407.GG17254@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 22 Jan 2014 21:14:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E3E7DDC2-8452-11E3-B6E7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240920>

Jeff King <peff@peff.net> writes:

> ..., but it feels awfully wrong to be so intimate with
> a subprogram that we do not control.

Yeah, I think we are in agreement on that point.
