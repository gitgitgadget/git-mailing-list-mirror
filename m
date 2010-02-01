From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack.packSizeLimit, safety checks
Date: Mon, 01 Feb 2010 09:20:15 -0800
Message-ID: <7vr5p450vk.fsf@alter.siamese.dyndns.org>
References: <loom.20100201T101056-232@post.gmane.org>
 <alpine.LFD.2.00.1002011100550.1681@xanadu.home>
 <4B6700CF.1090106@viscovery.net> <20100201162816.GA9394@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 18:20:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbzwv-0006ya-QM
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 18:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab0BARU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 12:20:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab0BARU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 12:20:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2FC496CA1;
	Mon,  1 Feb 2010 12:20:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Df96ODxcbRB+A+zcXa4MPe4gcgs=; b=MRyaD3
	QBwLpdUE+dyGSuHP0brL0eSjArg9V/lX28YUBdQFDxzmansN4tT2pzhr2xXYSElz
	6fXhd9PwQ/OKj58z53Q5QRBCmQZvlunsFBqUVNN95Ld/RF98aU9HDYJqBPk6819G
	7MlcU7ZrQGRJQI/tQBCEvu7E/m+JoHAguXHy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJmOBgrfKHOHvFGOCyiN0quklMxijBUM
	A3C9cQO0R0hiW7+JWVFvDc7kGKpqLKOZN5qpUA2H6BKLVLVF+5pMzvQrvJKEuWnI
	4/pDLo7B4T06yH06quog7fIxO29F8YvFK8qYYhX09wkBWIXa/R0zPZPIxPpmIVSR
	khHoowCfTw4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BE9F96C9E;
	Mon,  1 Feb 2010 12:20:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93FA096C9D; Mon,  1 Feb
 2010 12:20:16 -0500 (EST)
In-Reply-To: <20100201162816.GA9394@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 1 Feb 2010 08\:28\:16 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 143B565A-0F56-11DF-9B5D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138627>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Yup.  WTF was I thinking when I did megabytes as the default unit
> on the command line...

That thing is new, so it is worth fixing before 1.7.0 final.
Please make it so.

Thanks.
