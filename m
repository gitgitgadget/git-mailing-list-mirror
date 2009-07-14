From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t4202-log.sh: Test git log --no-walk sort order
Date: Tue, 14 Jul 2009 14:38:18 +0200
Message-ID: <4A5C7C3A.9080506@drmicha.warpmail.net>
References: <alpine.DEB.1.00.0907141243410.3155@pacific.mpi-cbg.de> <1247573287-9526-1-git-send-email-git@drmicha.warpmail.net> <4A5C785C.6060706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 14 14:38:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQhHP-000453-T2
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 14:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbZGNMih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 08:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbZGNMig
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 08:38:36 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41344 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752468AbZGNMig (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 08:38:36 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id D1C193B0C22;
	Tue, 14 Jul 2009 08:38:35 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 14 Jul 2009 08:38:35 -0400
X-Sasl-enc: QvpHS8D2vt6EPRuHVirAmEDoIQxbBLEGBOwyuS8+Ux8O 1247575115
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CC240D224;
	Tue, 14 Jul 2009 08:38:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090712 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <4A5C785C.6060706@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123242>

Johannes Sixt venit, vidit, dixit 14.07.2009 14:21:
> Michael J Gruber schrieb:
>> +test_expect_success 'git log --no-walk <commits> sorts by commit time' '
> ...
>> +test_expect_success 'git show <commits> does not sort by commit time' '
> 
> Thanks, but sorry that I'm nit-picking here:

This not being my first patch, I don't expect any patch to go through
without nit-picking here - which, in most cases, is really a good thing ;)

> You say what git show does
> not do, but shouldn't you say what git show should do?
> 
> 	'git show shows commits in command line order'

Well, I assumed "does not sort" == "leaves as is". But, even if it is,
still "does not sort by commit time" != "leaves as is". v2 upcoming...

Michael
