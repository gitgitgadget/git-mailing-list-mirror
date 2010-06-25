From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Fri, 25 Jun 2010 15:43:45 +0200
Message-ID: <4C24B291.1040108@drmicha.warpmail.net>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 15:44:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS9Cr-0000fu-4D
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 15:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069Ab0FYNo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 09:44:28 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45257 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752433Ab0FYNo1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 09:44:27 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6ED211076FB;
	Fri, 25 Jun 2010 09:44:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 25 Jun 2010 09:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=HD/8ZU+b8I5drFqtxgywQxb0+SI=; b=XSqTuULuaSCx7Ia9p3ReDWe1WnF3I3GS/LlWEw+PkW3zbPyVGtpF4PHLaYklZPnMJejeFs164zwRiBJk7hYB0v4u7z809y4yqArpn2s/tkd6s03RT1p37KchjUWO6T/AYzHtLLJsldik5RiYyRDiX+W8WJt+QxHEQWgeSe07hAs=
X-Sasl-enc: slusnlgQJGg5rF8ntIzq+oR7oiGYcTmEqI/IXRFpcbJm 1277473467
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DD0965AB56;
	Fri, 25 Jun 2010 09:44:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100625 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149684>

Junio C Hamano venit, vidit, dixit 24.06.2010 00:09:
> 
> * mg/rev-parse-lrbranches-locals (2010-05-14) 1 commit
>  - revlist: Introduce --lrbranches and --locals revision specifiers
>  (this branch uses mg/rev-parse-option-sifter-deprecation.)
> 
> I am reluctant to merge a patch that introduces an unpronounceable
> option.

While I could tell you how to pronounce it, I actually was about to
suggest dropping this patch! I don't like the name lrbranches, we have
two names (heads/branches) for local branch heads already, and couldn't
come up with a better name, available name meaning "all branch heads".

> 
> * mg/rev-parse-option-sifter-deprecation (2010-05-14) 3 commits
>  - t6018: make sure all tested symbolic names are different revs
>  - t6018: add tests for rev-list's --branches and --tags
>  - rev-parse: deprecate use as an option sifter
>  (this branch is used by mg/rev-parse-lrbranches-locals.)
> 
> I don't think these patches help anything.  Opinions?

They helped the patch which is going to get dropped...

Besides that: The two test patches improve the tests. t6018 gives the
impression to test something which it doesn't (because some symbolic
names point to the same rev, so it doesn't test whether rev-parse really
resolves all of them), and was lacking coverage for --branches and
--tags. So I think those two are independent improvements.

About the "deprecation/discouragement notice" for rev-parse I don't
know. rev-parse is not completely in sync with all rev-list options, and
doesn't mean to be if I understood correctly. I know that now. As long
as nobody cares, nobody cares...

Cheers,
Michael
