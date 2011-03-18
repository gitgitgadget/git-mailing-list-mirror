From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFD 0/2] revision.c: --merges, --no-merges and --merges-only
Date: Fri, 18 Mar 2011 09:41:56 +0100
Message-ID: <4D831AD4.5020709@drmicha.warpmail.net>
References: <cover.1300359256.git.git@drmicha.warpmail.net> <20110317195905.GG20508@sigill.intra.peff.net> <4D831043.1060709@drmicha.warpmail.net> <7vbp18yh1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 09:45:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0VJQ-0005Mz-78
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 09:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416Ab1CRIpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 04:45:30 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40236 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756379Ab1CRIpZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 04:45:25 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2504920307;
	Fri, 18 Mar 2011 04:45:25 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 18 Mar 2011 04:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=FiHymfY+7YB5jdWvFseId3xOlO0=; b=NKmUzedpDIzNJSebWr8buVhPOkbgsHl1Tn8RoiXmHsVik27PmlZCUg/GkwBJTueZtFhaqxYQFKx2ID9sDsM7adu8pj+M+QVPwYAIeBhFFQ9ew7HxMCadNdXQTrGo6G5t6l2teemtUXYkp00qv/XcLXtdWPISFpIMRjdP585Zz8g=
X-Sasl-enc: a/8nNuyaA55IJt5cXJ5fWuHQjbM6eM8SwYnYNXe5+bIB 1300437924
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EE8F4445598;
	Fri, 18 Mar 2011 04:45:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vbp18yh1f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169302>

Junio C Hamano venit, vidit, dixit 18.03.2011 09:22:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> From the ui perspective I'm somehow not a big fan of tri-state options
>> but can't give hard reasons why; maybe because they force you to use
>> option arguments.
> 
> But in this particular case, you cannot really hack it with two options
> that appear independent on surface but in reality are not. Logically, it
> is an enum <everything, non-merges, merges-only> and you can choose only
> one of them, and it is even worse from the UI perspective to use
> combination of two not-quite-independent options.
> 
> Also I have a hidden agenda to add "because we could" --show=octopus to
> the enum later perhaps only to my private edition ;-)

Now you're selling me that (tri++)-state!

git config alias.calamari 'git log --merges=octopus'

Surprisingly few call sites deal with the corresponding rev.foo so that
even those could be enumified... Stay tuned :)

Michael
