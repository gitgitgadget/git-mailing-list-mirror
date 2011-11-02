From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] http-push: don't always prompt for password
Date: Wed, 02 Nov 2011 10:40:47 -0700
Message-ID: <7vfwi6jucg.fsf@alter.siamese.dyndns.org>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
 <4EAEAE13.50101@atlas-elektronik.com> <4EAFC18A.1070502@atlas-elektronik.com>
 <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
 <4EB104EA.2040001@atlas-elektronik.com>
 <7vk47ijvlv.fsf@alter.siamese.dyndns.org>
 <20111102172310.GA28525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 02 18:40:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLeo2-0000Y8-VI
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 18:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab1KBRku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 13:40:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab1KBRkt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 13:40:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DD26636C;
	Wed,  2 Nov 2011 13:40:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uFi3NU45Fn9eRV/JspwqwWsMP+I=; b=rntCHZ
	CYkHrqhd4+YR1tMXS6Ur2MEOfr3lXidKay/VE+hQpKfis5rO/gayyMNW0e9fxg9c
	bpdRAEaMugDe4QpQ/PUSaOKKczsGjz9yexbSXU8kAyoERy4q0dDCvOUnqtn3F9sA
	YpuRk0qzEJzUaEzAkQZiBGn2N1dCUghOt8VmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GdaqbrXKUJ9prS4h84HHwWnIv3U9bzCY
	/n5WCOZnusNGM/UZ7mAIzIgs3JZg8fJeI7qj9G09ff1dGUkagjMrYAR1UH/y95xX
	wjq/XWIWpPncq6xckxbKuUZ58+1viVzHqF+aKSUMLdbEDBYEOWNt5/oVJ2sgPBKb
	2QAs61RohKs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56054636B;
	Wed,  2 Nov 2011 13:40:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6AAF636A; Wed,  2 Nov 2011
 13:40:48 -0400 (EDT)
In-Reply-To: <20111102172310.GA28525@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 2 Nov 2011 13:23:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD207630-0579-11E1-92EF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184650>

Jeff King <peff@peff.net> writes:

> It seems to me that Stefan's patch actually causes that (because he
> removes the early "set password if we have a username" logic). But I'll
> take another look at what's in master.

Thanks.
