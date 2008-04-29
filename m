From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Wed, 30 Apr 2008 06:08:03 +0900
Message-ID: <200804292108.m3TL8moS011790@mi1.bluebottle.com>
References: <4816E40A.4020700@gnu.org> <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org> <4816E0F6.3030302@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Andreas Ericsson <ae@op5.se>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, johannes.schindelin@gmx.de, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:09:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqx52-0008PX-Ip
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802AbYD2VIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756757AbYD2VIu
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:08:50 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:35807 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802AbYD2VIt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:08:49 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m3TL8moS011790
	for <git@vger.kernel.org>; Tue, 29 Apr 2008 14:08:48 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=1TFfsBAeDR/OCgsV0t9QtTUtogLPByCVjg71+zL5+T1NGFaC2DunB65jfUQecOj+x
	mRiMVZrC1+ftDNPDWuhBpvbPAnkOmtclv+Y+Fe0ZYa0H8jyWqvwY+X9pvW3ADry
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m3TL8Qem021716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Apr 2008 14:08:34 -0700
In-reply-to: <4816E40A.4020700@gnu.org>
X-Trusted-Delivery: <02a4c4bb3e854ec4ae763ffa4fbd4132>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80733>

Quoting Paolo Bonzini <bonzini@gnu.org>:

>>> Sorry, how does the patch make you lose some of your work (as
>>> opposed to some of your time, which is possible as is the case for
>>> every backwards incompatible change)?
>>
>> Because I will lose some of the refs and then have to dig them up in the
>> reflog.
>>
>> I'm not comfortable with the reflog. I appreciate its usefulness, but I'm
>> thoroughly unhappy when I'm forced to use it.
>
> So am I, but still it would lose time (to dig refs up in the reflog),
> not work (e.g. having to rewrite code).  I think we're in agreement on
> this part.
>
>> Yes, I understand the rationale, and I do have an alternative idea, which
>> is to make it configurable.
>
> Then sorry, but I think you don't understand the rationale.  The cover
> letter has excerpts from other git hackers' e-mails that explain it
> better than I can.  But shortly speaking, the point of the patch is to
> remove the "magic" operation of "git fetch" as "git fetch
> origin". Removing is quite the opposite of "add a configuration option
> that disables it, but leave the old behavior as default".
>
>> Now that I think about it, it's probably useful to have it
>> togglable via command-line switch as well. Something along the
>> lines of "git fetch --all-remotes", perhaps.
>
> Making it accessible via a command-line switch is pointless, as we
> already have "git remote update" for that.
>
> Paolo

Sorry but then why does this patch have to even touch "git fetch"?  Isn't it enough to run "git remote update"?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email account with anti spam protection.
http://www.bluebottle.com/tag/2
