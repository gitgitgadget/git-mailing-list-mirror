From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Use "git pull --ff-only" by default?
Date: Sat, 22 May 2010 13:37:15 +0200
Message-ID: <4BF7C1EB.8040702@drmicha.warpmail.net>
References: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>	 <4BF68F5F.9010309@drmicha.warpmail.net>	 <A612847CFE53224C91B23E3A5B48BAC74483234EDE@xmail3.se.axis.com>	 <4BF6A445.1030105@drmicha.warpmail.net> <AANLkTilfD1jhDcyuK9zAthlW4vRU-15TmBgYlc16W0Ux@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 13:37:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFn1B-0001A8-RX
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 13:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab0EVLhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 07:37:11 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53945 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754153Ab0EVLhK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 May 2010 07:37:10 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 36C52F70FE;
	Sat, 22 May 2010 07:37:08 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 22 May 2010 07:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=mxKziYm5LeAQf2fEkTmMGwCX5bQ=; b=JhJQYYABXsHpda+8kTT+fpbd6gP+1pwdQPBlitsZZ3PclXeDcFQilS/TFyxkZGIThIkGHunwhpLmJaZNOYX0YKafZ/5EpJaI4LHkpN5prgT71LFwWb89wN1Vw+XIwOLXYx9/Djv6iDA+JLnDCovNsuE+Vg3AmJ3mCRvFX5t1u2A=
X-Sasl-enc: BGTAti82RDkzZ+pmbLt0pLmhno1XYi3Ba7YdT367AQLp 1274528227
Received: from localhost.localdomain (p548583CF.dip0.t-ipconnect.de [84.133.131.207])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4C97C299F2;
	Sat, 22 May 2010 07:37:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <AANLkTilfD1jhDcyuK9zAthlW4vRU-15TmBgYlc16W0Ux@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147517>

Jay Soffian venit, vidit, dixit 21.05.2010 21:13:
> On Fri, May 21, 2010 at 11:18 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> 
>> git config alias.pull 'pull --ff-only'
> 
> That won't work. You cannot override built-in commands. Look at
> run.argv() in git.c and notice it doesn't process aliases unless
> handle_internal_command() and execv_dashed_external() fail.

I was sure it worked at some point. Maybe I'm just so used to my "ci"
(read: check-in) alias for "commit" that being able to override that one
(to "commit -s" for git.git) fooled my perception. Sorry!

Michael
