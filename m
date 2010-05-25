From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC][PATCH] Print the usage string on stdout instead of stderr.
Date: Tue, 25 May 2010 08:46:34 +0200
Message-ID: <4BFB724A.3020800@drmicha.warpmail.net>
References: <878w7ieu4p.fsf@thor.thematica.it>	<4BF12C96.9030802@drmicha.warpmail.net> <87vdamu2es.fsf@thor.thematica.it>	<4BF14508.8040307@drmicha.warpmail.net> <87d3wutt34.fsf@thor.thematica.it>	<4BF2614E.50003@drmicha.warpmail.net> <87pr0lja5n.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 25 08:47:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGnux-0005av-EE
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 08:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186Ab0EYGrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 02:47:06 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54437 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932069Ab0EYGrF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 02:47:05 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F05D0F7DF3;
	Tue, 25 May 2010 02:46:47 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 25 May 2010 02:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=MqLHWrfrsy/7wiqD21HYEu8puM0=; b=Ww63sgryhdJFgSbJ/RhUzI4mNcP6lQms2/CbCBF7JZfubs4XNx35USaqa0N+QYk93uG5vXX+a9myc458WRmOa+bgybyQzI/osGxbzm1RjN71M5DuSq55laxmuLMBSViNiZkzA2EoDFIvq3wADK+qvR4ko9yuz3gLjTt7/piftS4=
X-Sasl-enc: c14y18b33bESfhqUB8B3ai5jeH3flJ8i5QxJU4mooKQL 1274770007
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 760665928D;
	Tue, 25 May 2010 02:46:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <87pr0lja5n.fsf@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147669>

Giuseppe Scrivano venit, vidit, dixit 24.05.2010 22:51:
> Hello Michael,
> 
> 
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> I haven't checked whether this covers all code paths but other than that
>> it looks OK to me, and the tests pass.
> 
> is the patch ready for inclusion?

You're the author, you should know ;)

Note that I can't include your patch. That's up to Junio, and he's been
lagging back for good reasons (as you could read on the list) and is in
the process of keeping up.

I gave you my partial ack'ed-by (see above) and a homework problem to
answer: Have you checked whether this covers all code paths (all
help/usage callers)? If yes then it's a good idea to resend v2 of your
patch as a reply to this thread but with subject "[PATCH v2]..." as it
is hard to find otherwise, and cc to Junio.

Cheers,
Michael
