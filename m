From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Thu, 16 Aug 2012 10:42:33 +0200
Message-ID: <87k3wzxm6e.fsf@thomas.inf.ethz.ch>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
	<877gt16ewe.fsf@thomas.inf.ethz.ch>
	<7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
	<87sjbpa5m8.fsf@thomas.inf.ethz.ch>
	<7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	"Martin von Zweigbergk" <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 10:42:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1vfG-00034Q-Ez
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 10:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566Ab2HPImk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 04:42:40 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:37899 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756512Ab2HPImh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 04:42:37 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 Aug
 2012 10:42:32 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 Aug
 2012 10:42:33 +0200
In-Reply-To: <7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 15 Aug 2012 13:02:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>   Thomas Rast <trast@student.ethz.ch> writes:
>
>   > But then the new description is wrong.  It claims that children are
>   > always before parents, which is not true in the face of clock skew.
>
>   Thanks for sanity-check.  Here is an updated one.
[...]
> ---topo-order::
> +--date-order::
> +	Show no parents before all of its children are shown, but
> +	otherwise show commits in the commit timestamp order.
>  
> -	This option makes them appear in topological order (i.e.
> -	descendant commits are shown before their parents).
> +--topo-order::
> +	Show no parents before all of its children are shown, and
> +	avoid showing commits on multiple lines of history
> +	intermixed.

Ack, thanks.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
