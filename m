From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] Add --reference option to git submodule.
Date: Tue, 28 Apr 2009 19:01:54 +0200
Message-ID: <49F73682.2010404@drmicha.warpmail.net>
References: <20090428123033.GA6839@redhat.com> <49F702C0.8030206@drmicha.warpmail.net> <49F717D4.70708@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 19:03:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyqiU-0007Wl-R2
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 19:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762116AbZD1RCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 13:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932787AbZD1RCH
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 13:02:07 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:49800 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762243AbZD1RCF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 13:02:05 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 26F69328CFE;
	Tue, 28 Apr 2009 13:02:03 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 28 Apr 2009 13:02:03 -0400
X-Sasl-enc: UZeFnLf9BiMG5cGQJiICjdSCec+T1vD9BAWpqpzRyHMI 1240938122
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 30B582C3A2;
	Tue, 28 Apr 2009 13:02:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090427 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49F717D4.70708@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117799>

Johannes Sixt venit, vidit, dixit 28.04.2009 16:51:
> Michael J Gruber schrieb:
>> BTW, even dash has "test STRING" so portability doesn't require -n but I
>> think it's OK either way.
> 
> It is not if STRING is user input; it could be, e.g., '-f', and then the
> command gives a syntax error because of a missing argument.
> 
> It's safer to use test -z and test -n unless the string to test is
> completely under the control of the script.

Yep, that's true as a general rule. Here it's always preceeded by
"--reference=". But in any case I'm happy I suggested -n and it's in ;)

Michael
