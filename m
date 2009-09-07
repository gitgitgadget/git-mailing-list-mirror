From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: tracking branch for a rebase
Date: Mon, 07 Sep 2009 11:06:49 +0200
Message-ID: <4AA4CD29.4040805@drmicha.warpmail.net>
References: <20090904135414.GA3728@honk.padd.com> <4AA124DD.1030208@drmicha.warpmail.net> <20090904181846.GC19093@coredump.intra.peff.net> <20090904185949.GA21583@atjola.homenet> <20090905061250.GA29863@coredump.intra.peff.net> <20090905140127.GA29037@atjola.homenet> <20090905142841.GB15631@coredump.intra.peff.net> <7vfxaz9wfi.fsf@alter.siamese.dyndns.org> <4AA4C0CE.2070300@drmicha.warpmail.net> <7vzl97xit9.fsf@alter.siamese.dyndns.org> <20090907084455.GC17997@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?QmrDtnJuIFN0ZWluYnJpbms=?= <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 07 11:07:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkaBq-00070w-84
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 11:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbZIGJG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 05:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbZIGJG7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 05:06:59 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60811 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751956AbZIGJG6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 05:06:58 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D44B265239;
	Mon,  7 Sep 2009 05:07:00 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 07 Sep 2009 05:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=40knM76ectyJmgQ1G6pkcBelZJ0=; b=c9WsNHTcT38l5NXCExd9H5F7TbT405lyHf1/UpaQyuMjRdiQGdAG8LcR4dspgBTy0//YjFVAcGeDKOJKfL4shK3pZSTI9ZPS+mW3pR1LnK4ViTDQAjRo9WSu0CTY62n/4SAQ3nunDJ4W+EYatAJ/4MRSJES2UUe6IUcjvehDN8s=
X-Sasl-enc: jlJV2Zas42eIWNu/Vp3ThIqi8k9Y1kgan7q96GI+OvrB 1252314420
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D42CE486A;
	Mon,  7 Sep 2009 05:06:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090902 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <20090907084455.GC17997@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127913>

Jeff King venit, vidit, dixit 07.09.2009 10:44:
> On Mon, Sep 07, 2009 at 01:25:38AM -0700, Junio C Hamano wrote:
> 
>>> @{^}
>> 
>> This _could_ work, although it is rather cryptic.
> 
> But an identifier composed entirely of punctuation? It might help
> git catch on with perl programmers. ;)

Right, that was the true agenda hidden only partially behind the plain
association between ^ and up ;)

Michael (having exactly zero perl fu)

P.S.: @ may not be reserved, and neither @^, but 1.7 should allow us to
reserve some symbols/combinations with a "low damage probability".
People may have a@b refnames (git-svn users for sure), but @^?
