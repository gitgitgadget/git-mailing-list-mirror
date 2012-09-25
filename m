From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Quickly searching for a note
Date: Tue, 25 Sep 2012 09:24:04 +0200
Message-ID: <50615C14.7020401@drmicha.warpmail.net>
References: <505CB21E.4040607@workspacewhiz.com> <7vtxur3zxi.fsf@alter.siamese.dyndns.org> <505CCD2A.8020003@workspacewhiz.com> <505CD2FA.80200@kdbg.org> <505CD7D0.2000505@workspacewhiz.com> <20120921233723.GA29433@sigill.intra.peff.net> <7v7grn3pfo.fsf@alter.siamese.dyndns.org> <505DE30B.2000805@drmicha.warpmail.net> <7vk3vl3ixv.fsf@alter.siamese.dyndns.org> <505F2598.7080704@drmicha.warpmail.net> <20120925004223.GC19586@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 09:24:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGPVC-0003sz-BT
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 09:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab2IYHYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 03:24:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52564 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751097Ab2IYHYH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Sep 2012 03:24:07 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 09C5F205C4;
	Tue, 25 Sep 2012 03:24:07 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 25 Sep 2012 03:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=zpTWe2WRDwcLkvijnxY6W6
	Td/0w=; b=Jpax6ZnAD2ZM+DkZxY5G8vS9A81s6xBJVFJMZVRk5Y2RN5gJVWdjYN
	gORR3lZu162ZD4Z71B+FWcFZXazGQXSR3yJr/N8M+4t8s5ZmnabCFlQCfi0JUAx0
	CUv8MA2BBxJB+8TNePOefpw+WMk5EopvToGXOk/Dj+wCcpD0nBYCE=
X-Sasl-enc: s5YwZ8PClxR08Gvyqn3HJSygMB6q0h+nuJR5aVmzrklO 1348557846
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C0AB44827AE;
	Tue, 25 Sep 2012 03:24:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <20120925004223.GC19586@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206351>

Jeff King venit, vidit, dixit 25.09.2012 02:42:
> On Sun, Sep 23, 2012 at 05:07:04PM +0200, Michael J Gruber wrote:
> 
>>> If we linked with an embeddable scripting language interpreter
>>> (e.g. lua, tcl, guile, ...), it may be a more practical enhancement,
>>> though.
>>>
>>
>> Yes, the idea is "extend, don't embed" the other way round, so to say. I
>> still think extending "git log" so that it can call a script with commit
>> info already in the environment gives a more convenient approach then
>> "embedding git rev-list" into your own script. It's not more performant,
>> of course.
> 
> I think Junio is going the other way than you think. That is, you still
> run rev-list, but rather than call a sub-program, you call a snippet of
> an embeddable script. Which is the same idea as yours, but theoretically
> way faster.
> 
>> I just see many more requests of the type "grep notes" coming, i.e.
>> limitting based on other commit info, or in a different way then already
>> possible. Just image you want to find out who's responsible for those
>> commits in git.git with subject lengths > 100 ;)
> 
> Like this:
> 
>   git log --lua-filter='return subject().len > 100'
> 
> ? :)

Like this! :)

Michael
