From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: Fix biridectionality -> bidirectionality
 typos
Date: Tue, 08 Jan 2013 10:10:15 -0800
Message-ID: <7vtxqreebc.fsf@alter.siamese.dyndns.org>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
 <1351995218-19889-8-git-send-email-felipe.contreras@gmail.com>
 <20121128202320.GA22522@odin.tremily.us>
 <20130108154737.GA4662@odin.tremily.us>
 <7vboczfunc.fsf@alter.siamese.dyndns.org>
 <20130108175001.GG4662@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 08 19:10:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsddK-0007OE-8H
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 19:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903Ab3AHSKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 13:10:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756834Ab3AHSKS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 13:10:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F3DBB785;
	Tue,  8 Jan 2013 13:10:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+JCtZTc05qPnmKg1jJ/RBbaLZpk=; b=srQDtN
	gBvEZB7BNmP1/5vQlR+wgS6Y9gQ+jCH7xSCCvDGNbp4QdHcdGK1cBEL4iPB8vLSv
	lsLvNWAijDVCwYUXln85U/9I5hOAmikh9jvPqpGYNW1fXDhff5EEr6VX9pvSxljX
	/0DtShW1SXwdF1mlTJfTfmqHi87TcGMF8Bgak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VAuJ3CHgOZzN08eYLv3ttbjMWTCYQXUd
	Vud7bBHz8NoAiosyIqtU5OGN7ucJJsfhS8x4dXXTxWCvqk/0VYujqM1Fuq/cN07k
	mxaAAEG7P2dYlpa9JMyThyoAiBeDmVveUGYBKbXlH7pgzYl85Uz35qtHUJd/IAAv
	FebPlOsviJM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31966B783;
	Tue,  8 Jan 2013 13:10:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94A85B77F; Tue,  8 Jan 2013
 13:10:16 -0500 (EST)
In-Reply-To: <20130108175001.GG4662@odin.tremily.us> (W. Trevor King's
 message of "Tue, 08 Jan 2013 12:50:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7AE07C4-59BE-11E2-8B7B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212987>

"W. Trevor King" <wking@tremily.us> writes:

> On Tue, Jan 08, 2013 at 09:32:07AM -0800, Junio C Hamano wrote:
>> Thanks; didn't Documentation/SubmittingPatches ask you not to do PGP
>> multipart but send patches in plain text?
>
> Gah.  I need to tell myself to reread that every time I send a patch
> :p.

No need to worry; thanks for a patch---applied to 'maint'.
