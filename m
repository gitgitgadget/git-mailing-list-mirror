From: Andreas Ericsson <ae@op5.se>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 19:23:46 +0200
Message-ID: <4714F3A2.3080103@op5.se>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>	 <471476B7.5050105@users.sourceforge.net>	 <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>	 <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Adam Piatyszek <ediap@users.sourceforge.net>,
	Lars Hjemli <lh@elementstorage.no>,
	Michael Witten <mfwitten@mit.edu>, git@vger.kernel.org
To: "Jeffrey C. Ollie" <jeff@ocjtech.us>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:24:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihq9U-0004fc-FS
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934564AbXJPRXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934556AbXJPRXv
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:23:51 -0400
Received: from mail.op5.se ([193.201.96.20]:57682 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934537AbXJPRXu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:23:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 050821730722;
	Tue, 16 Oct 2007 19:23:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oA4-Rq9oulSK; Tue, 16 Oct 2007 19:23:09 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id F20D117306FD;
	Tue, 16 Oct 2007 19:23:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61228>

Jeffrey C. Ollie wrote:
> On Tue, 2007-10-16 at 12:16 +0200, Adam Piatyszek wrote:
>> And if one change the tab size, it will result in a messy alignment in
>> line 5.
> 
> Which is why one should never should change the tab size from anything
> but 8.
> 

I have mine set to 4. With an 11.2" screen and 1024x768 resolution, it's
not as if I've got much choice if I want to be able to see anything on
the screen. Some whitespace-damaged places look ugly, but it's usually
not too bad.

>> I guess there is no ideal solution for this in Emacs.
> 
> Instead of using "(setq indent-tabs-mode t)" use "(setq indent-tabs-mode
> nil)".  This will force emacs to always use spaces to indent.
> 

... but don't do this when hacking on Linux or git. Thanks

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
