From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/WIP 1/2] Documentation: fix minor inconsistency
Date: Mon, 23 Mar 2009 15:56:38 +0100
Message-ID: <49C7A326.2050403@drmicha.warpmail.net>
References: <1237818533-31577-1-git-send-email-git@drmicha.warpmail.net>	<1237818533-31577-2-git-send-email-git@drmicha.warpmail.net> <vpq7i2g9u4m.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:59:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lllc9-0007z5-Rf
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716AbZCWO45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756557AbZCWO44
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:56:56 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38565 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755369AbZCWO44 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 10:56:56 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 30D502F61EE;
	Mon, 23 Mar 2009 10:56:54 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 23 Mar 2009 10:56:54 -0400
X-Sasl-enc: bvQ3qUQcxX5bzS87aWW1XuK+dyQtkHB9dfH29ojWnMWO 1237820213
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5DD8BAF2B;
	Mon, 23 Mar 2009 10:56:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090323 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <vpq7i2g9u4m.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114323>

Matthieu Moy venit, vidit, dixit 23.03.2009 15:44:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> While we don't always write out commands in full (`git command`) we
>> should do it consistently in adjacent paragraphs.
> 
>> -	If set to true or "refuse", receive-pack will deny a ref update
>> +	If set to true or "refuse", git-receive-pack will deny a ref update
> 
> Then, shouldn't this be `git receive-pack` ?

It should be git-receive-pack in the first patch (adding missing git in
the same style as used there), `git-receive-pack` in the second patch
(implementation of step 1) and `git receive-pack` in step 2 (the
un-dashifying step), which comes later, just as outlined in the cover
letter. Mixing these steps into one patch would be a reviewing
nightmare. Squashing those two patches (constituting step 1 for the
first few files) would be fine.

Michael
