From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix formatting in git-config(1)
Date: Tue, 03 Jul 2012 12:23:23 -0700
Message-ID: <7vpq8cvec4.fsf@alter.siamese.dyndns.org>
References: <m27guy5fqv.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 21:23:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm8hA-0006LZ-FN
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 21:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933394Ab2GCTX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 15:23:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41816 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932792Ab2GCTX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 15:23:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE57A864B;
	Tue,  3 Jul 2012 15:23:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s+veY535zzaRRvGdlsfGgU8AwdU=; b=iA8HgE
	NlvL0QGijKbimzTMoXUDmVEJERNjlAgNV7yb/xgs0Yz4ZMSJ41oz+bRBQVLMXHN1
	WPVd9WCr39gm6FpGK4OQ68+siWNjUb2+Cgc7ZXHlwlQefcYKM1JC8frdHf32xdki
	9B3SIfTqkdmSjkshdvSpr3rmtfXsmiMBPNqHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XmKBF70siAmOZBUojwJcrYwsnlMdcRWz
	vO4jkEKHT7T2+SiyVACKpAraD1uwyYyLtXEhCSw1WTuPtqrszrxVjmdl40TZb5if
	E9c2uZFrMVapPJi6kbKOsT18CcIuaVQr435JIJIAUp7wtU1HM283Ol/3JU1dKELp
	LJmHbDRHczY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDC7B864A;
	Tue,  3 Jul 2012 15:23:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59DEA8649; Tue,  3 Jul 2012
 15:23:25 -0400 (EDT)
In-Reply-To: <m27guy5fqv.fsf@igel.home> (Andreas Schwab's message of "Sat, 23
 Jun 2012 15:18:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F7FE37A-C544-11E1-8630-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200934>

Andreas Schwab <schwab@linux-m68k.org> writes:

> This fixes two formatting bugs in the git-config documentation:
>
> - in the column.ui entry don't indent the last paragraph so that it isn't
>   formatted as a literal paragraph
> - in the push.default entry separate the last paragraph from the
>   nested list.
>
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Thanks.
