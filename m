From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch.c: use the parsed branch name
Date: Fri, 19 Aug 2011 11:03:05 -0700
Message-ID: <7vwre92s9y.fsf@alter.siamese.dyndns.org>
References: <8258e2fc0a61642053e285c4f498e7cf1d2dc7df.1313754086.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 20:03:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuTPV-0002RH-Fu
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 20:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723Ab1HSSDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 14:03:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab1HSSDH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 14:03:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 217E34E6E;
	Fri, 19 Aug 2011 14:03:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eXG0AtNANiLqS1jxWL1ZxoQpfb0=; b=DnSP0W+D8cwm8USMAuMa
	MrqYebWt2wND8rua4K66TLrgmh7JCMlgzcwIG7d5OxcPlaGKcqoxsiKKmVFBNPQM
	Uf2eUc/WYNoOHfUSiv6DAN6j2pVtPZsWAiCVEJs+SmB9ec6sbaJc+OLIFT6XHRIA
	uuwuxN4N+NrXXg4hXiZagbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=AEKEAy2ztkjfa4gsuGjx6Hj+PeMRv1rYBDPynbxsqfjlnn
	1KTxsRhwv0mql1PwEGhmuLO4ojK6O1XXsnmW0uoQXLcfRTVL8E/G6OA9bcDaJv8L
	yU0JJA1IIQEueoJPG/ntjCUsQzllcriRiUbCBmzJ6gCQFs2pydpF+LDkRpBLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18D3B4E6D;
	Fri, 19 Aug 2011 14:03:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A22704E6C; Fri, 19 Aug 2011
 14:03:06 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D8D888C-CA8D-11E0-B9B1-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179713>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When setting up tracking info, branch.c uses the given branch specifier
> ("name"). Use the parsed name ("ref.buf") instead so that
>
> git branch --set-upstream @{-1} foo
>
> sets up tracking info for the previous branch rather than for a branch
> named "@{-1}".
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Thanks.
