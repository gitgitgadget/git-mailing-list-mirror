From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 2/2] git submodule: Fix adding of submodules at paths
 with ./, .. and //
Date: Tue, 03 Mar 2009 15:58:47 +0100
Message-ID: <49AD45A7.10906@drmicha.warpmail.net>
References: <7vtz6ht9ho.fsf@gitster.siamese.dyndns.org> <1236083989-20526-1-git-send-email-git@drmicha.warpmail.net> <1236083989-20526-2-git-send-email-git@drmicha.warpmail.net> <1236083989-20526-3-git-send-email-git@drmicha.warpmail.net> <alpine.DEB.1.00.0903031529040.6399@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 16:00:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeW6e-0003sR-QW
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbZCCO67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 09:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbZCCO67
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 09:58:59 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56893 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752380AbZCCO66 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 09:58:58 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id AAF0C2D33A0;
	Tue,  3 Mar 2009 09:58:56 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 03 Mar 2009 09:58:56 -0500
X-Sasl-enc: 7v+grC97lOtZslKbL3xpmfBs8kLbA/Uee0ZBl7EHIaxr 1236092336
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BD5162B059;
	Tue,  3 Mar 2009 09:58:55 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090303 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0903031529040.6399@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112079>

Johannes Schindelin venit, vidit, dixit 03.03.2009 15:29:
> Hi,
> 
> On Tue, 3 Mar 2009, Michael J Gruber wrote:
> 
>> Make 'git submodule add' normalize the submodule path in the
>> same way as 'git ls-files' does, so that 'git submodule init' looks up
>> the information in .gitmodules with the same key under which 'git
>> submodule add' stores it.
>>
>> This fixes 4 known breakages.
> 
> Maybe it is time to turn this into a builtin?

Uhm, you mean all of submodule or just the normalize part? Isn't git
submodule up for some rewriting (.gitmodule...) anyways?

I suggest applying the tests and fix before Bob the In-Builder rolls in.
And no, Bob's not my alter ego...

Michael
