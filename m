From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] split largest remaining scripts, gitk and gitweb
Date: Tue, 01 Feb 2011 14:15:48 -0800
Message-ID: <7vsjw7xuy3.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <m38vxzaa03.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 23:16:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkOW5-0006Ng-JN
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 23:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab1BAWP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 17:15:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab1BAWP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 17:15:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AAEB34C28;
	Tue,  1 Feb 2011 17:16:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h1cdWX1+yNa1rgVIynxlxplELKI=; b=yHTKJF
	yMfTBZWxcGb346X8ex9iwtN6aUC85bacI1eq2FzqSiC17L5fJd+CxPooUD3m64bO
	Epnq7RoSwwNiDJZIfjKw7swq43t3BuY89l+v+ASJf5y0YdV1qyz2akz328j0fs3X
	qV9V9AXH5iM1UZjJ8acD15JUF1wCU8JT/C/pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OIsBrMNWdhR7zApkOYkDKPin7U/+Fdin
	BLQk/WghNNDE94wP4xtupmiurG8K8CswGrQECdBXjLMxy3wW0A8uR/ThNP66F4Ay
	XJHtDBzHn7+s3fnXE/phrQkeensCJCCbNeftw4TQCMcIe2pUYQcocugAFvHAHphD
	k3AcVP7EZDc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 79FA04C21;
	Tue,  1 Feb 2011 17:16:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4003D4C08; Tue,  1 Feb 2011
 17:16:41 -0500 (EST)
In-Reply-To: <m38vxzaa03.fsf_-_@localhost.localdomain> (Jakub Narebski's
 message of "Tue\, 01 Feb 2011 10\:26\:08 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F5A4CBDE-2E50-11E0-9BCC-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165868>

Jakub Narebski <jnareb@gmail.com> writes:

> Two largest files in git repository are gitk and gitweb, see the
> ...
> What do you think?

What does this have to do anything with 1.8.0?  Isn't this all internal
implementation that can be brought in without affecting end users?
