From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 13:51:34 -0700
Message-ID: <7vvch6uw89.fsf@alter.siamese.dyndns.org>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
 <7vehnvvyta.fsf@alter.siamese.dyndns.org>
 <20120729142458.GB16223@paksenarrion.iveqy.com>
 <CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 22:51:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvaSk-0005es-KB
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 22:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549Ab2G2Uvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 16:51:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363Ab2G2Uvh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 16:51:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF8A38200;
	Sun, 29 Jul 2012 16:51:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hnm71Q3FOzRa8/kpwUXvT5DWx04=; b=TyEgGE
	VnHqDHrxVfF1YG+wEjmrzNV7ZDHeNqXtRcZWzMFicWFcozOvWv+EYbzV7sRdd5I7
	+T8uKDNYZevxtsSJxmFUd6xM3dvsfxki9aVMZBKc9czC0SSZJXhl0ODr8ueWHaNK
	o7monS2ggMCw4HsFZY+bk/LEdmLmPvKX+r9oA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x+FCP4GRHlvubiRPbOGVvu9hpPkVrki4
	tlGK8CBvrjBsyl1boAg/uYE38iedKaXlNMoUlDxDxVCdHKmsK8D6kxCbEhORjQAq
	v1Pgpv4Yps56XYMKd8AIpwRxNX117XEolnFcjyQP4pmN2ZlMnY6/j4G5hYBtadM4
	pES6CZ+wzAk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DBAF81FF;
	Sun, 29 Jul 2012 16:51:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1923681FE; Sun, 29 Jul 2012
 16:51:36 -0400 (EDT)
In-Reply-To: <CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com> (Sitaram
 Chamarty's message of "Sun, 29 Jul 2012 20:09:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FC2DA0C-D9BF-11E1-A1D3-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202495>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Uggh, no.  Client-git should only talk to server-git.  It shouldn't be
> talking first to some *other* program (in this case gitolite), and
> then to to server-git.  That doesn't sound sane to me.
>
> You should wrap this whole thing around something else that does it in
> 3 steps.  Check, create if needed, then the actual git command you
> intend to run.  All this should be local to your environment, not
> rolled into git; it's far too specific to be rolled into git itself,
> if you ask me.

Thanks for saving me from having to state an obvious sanity ;-)
