From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: auto commit merge using the default merge message
Date: Thu, 23 Apr 2009 11:07:12 +0200
Message-ID: <49F02FC0.1010007@drmicha.warpmail.net>
References: <81bfc67a0904230046j48ed06b7s5693406332ee52dc@mail.gmail.com> <81b0412b0904230057k1653d039vfc3962e6affda584@mail.gmail.com> <49F025E7.7090404@drmicha.warpmail.net> <7vocunwz1n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 11:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwuvR-0007ld-Kj
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbZDWJHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753814AbZDWJHW
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:07:22 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47504 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753319AbZDWJHV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 05:07:21 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id A435431F3CF;
	Thu, 23 Apr 2009 05:07:20 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 23 Apr 2009 05:07:20 -0400
X-Sasl-enc: Vv1eKCdwa7Ju13nvhTPpt/k97zciWO4YD2Pxvmpl3PM/ 1240477640
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A467A1B26;
	Thu, 23 Apr 2009 05:07:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vocunwz1n.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117312>

Junio C Hamano venit, vidit, dixit 23.04.2009 10:32:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> I think he wants the auto generated message which may be different
>> for each merge. Maybe something like
>> 
>> GIT_EDITOR=/bin/true git commit
>> 
>> will do the trick.
> 
> Use "GIT_EDITOR=:" instead.  It also is *true* just like /bin/true,
> but git knows a simple magic about this and avoids an extra
> fork+exec.

Good to know!

> A similar trick exists for GIT_PAGER=cat (not "/bin/cat"), by the
> way.
> 

So, GIT_PAGER=cat differs from GIT_PAGER=/bin/cat even when `which
cat`==/bin/cat?

Michael
