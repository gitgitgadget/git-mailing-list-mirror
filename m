From: Nanako Shiraishi <nanako3@bluebottle.com>
Subject: Re: [PATCH] Cloning from a repo without "current branch"
Date: Wed, 20 Jun 2007 14:50:17 -0700
Message-ID: <200706202150.l5KLoHkE002843@mi0.bluebottle.com>
References: <200706162226.l5GMQBss004492@mi0.bluebottle.com> <7vbqff1c3w.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 23:50:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I184I-0007of-Nl
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 23:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbXFTVuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 17:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXFTVuT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 17:50:19 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:56025 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbXFTVuS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 17:50:18 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5KLoHkE002843
	for <git@vger.kernel.org>; Wed, 20 Jun 2007 14:50:17 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:to:cc:date:from:subject:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:user-agent:x-trusted-delivery;
	b=kjojEedyiKSI1LeHO5euOIvoJSAnz5ea3QbYDcBgZpvKMU8+3olZG+owCmoHOF22t
	bjfJ2uA61msHwhr8bu2MYFASKcNbSSzNOxgkPUeGfJ4jkMWCwotRGuedhsVrg8t
Received: from localhost (internal.bluebottle.com [206.188.24.43])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5KLoHSG016675;
	Wed, 20 Jun 2007 14:50:17 -0700
Received: from 86-15-251-64.serverpronto.com (86-15-251-64.serverpronto.com [64.251.15.86]) 
	by mail.bluebottle.com (IMP) with HTTP 
	for <nanako3@bluebottle.com@localhost>; Wed, 20 Jun 2007 14:50:17 -0700
In-Reply-To: <7vbqff1c3w.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Trusted-Delivery: <ca3495cfd22a9ec1b0ec6f028b0f2b06>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50574>

Quoting Junio C Hamano <gitster@pobox.com>:

> Nanako Shiraishi <nanako3@bluebottle.com> writes:
> 
> > diff --git a/git-clone.sh b/git-clone.sh
> >  	?*)
> 
> Whitespace breakage?
> 
> > @@ -384,21 +391,20 @@ then
> >  		git-config branch."$head_points_at".merge
> > "refs/heads/$head_points_at"
> > +		;;
> 
> Again...?

Sorry, I'll re-send from a different mail addr.
Is it alright to send attachments?

----------------------------------------------------------------------
Get a free email account with anti spam protection.
http://www.bluebottle.com
