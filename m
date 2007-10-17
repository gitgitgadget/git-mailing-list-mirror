From: Andreas Ericsson <ae@op5.se>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 00:36:32 +0200
Message-ID: <47168E70.4070305@op5.se>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>	<471476B7.5050105@users.sourceforge.net>	<8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>	<47148F72.1090602@users.sourceforge.net>	<1192548367.3821.4.camel@lt21223.campus.dmacc.edu>	<B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu>	<3awb7zw6.fsf@blue.sea.net>	<alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>	<1192565900.6430.16.camel@athena>	<alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>	<20071017015109.303760cc@localhost.localdomain>	<alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>	<3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>	<E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu> <k5pll7rb.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 00:36:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiHVQ-0005UN-3W
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 00:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbXJQWgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 18:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757483AbXJQWgh
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 18:36:37 -0400
Received: from mail.op5.se ([193.201.96.20]:38540 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756582AbXJQWgh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 18:36:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7547D1730655;
	Thu, 18 Oct 2007 00:36:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BIy3-jdQ95BE; Thu, 18 Oct 2007 00:36:34 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 593A51730646;
	Thu, 18 Oct 2007 00:36:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <k5pll7rb.fsf@blue.sea.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61434>

Jari Aalto wrote:
> * Wed 2007-10-17 Michael Witten <mfwitten@MIT.EDU>
> * Message-Id: E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu
>> On 17 Oct 2007, at 3:17:08 AM, Luke Lu wrote:
>>
>>> But I still haven't seen any compelling arguments against the "all
>>> space" case
>> Overhead!
>>
>> If you use 8 spaces instead of one tab,
>> that's using up 7x more space!
> 
> Software is the right place to worry about optimization. We should trust
> SCM to make proper and efficient deltas. If not, algorithms need
> improvemnts.
> 
> Any cross platform development or electronic exchange is guaranteed to
> be interpreted correctly when policy enforces "only spaces"
> 
> As we have already seen in numerous times in this thread, using tabs
> will - eventually - be interpreted in some editor, in some display, in
> some encironment using some tools ... incorrectly or different than the
> author intended. Simply because editors are configurable and we cannot
> know what settings they may have when they load the file in.
> 

And simply because nearly all (unix) editors still insert a hard tab
when pressing the tab key, and *mixing* tabs and spaces makes the
situation *really* unbearable, one really shouldn't use all spaces.

It's code, not graphics. If it's really horrible, any editor can be
configured to change the non-default tab-setting back to 8 if that's
the problem. Mine's set to 4. Primarily because I think 8 is too
much. Sometimes (roughly once every 2 years), that gives me problem.
It's exclusively when someone has consciously mixed tabs and spaces.
Using either or *never* gives any problem.

> There is no such problem with spaces. 
> 

I beg to differ, for reasons stated multiple times elsewhere in this
thread.

> The storage constraints are insignificant given the disk space vs. cost;

Perhaps, but it's low-hanging fruit and since all spaces have its issues
too, why not just go with tabs?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
