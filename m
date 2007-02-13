From: Andreas Ericsson <ae@op5.se>
Subject: Re: Efficiency of initial clone from server
Date: Tue, 13 Feb 2007 16:03:08 +0100
Message-ID: <45D1D32C.1070900@op5.se>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>	 <20070211225326.GC31488@spearce.org>	 <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>	 <Pine.LNX.4.64.0702112022430.1757@xanadu.home>	 <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>	 <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>	 <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net> <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 16:03:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGzBc-0003sV-FC
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 16:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbXBMPDN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 10:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbXBMPDN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 10:03:13 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53069 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbXBMPDM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 10:03:12 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 929246BCC3; Tue, 13 Feb 2007 16:03:10 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.4
Received: from [192.168.1.20] (unknown [192.168.1.20])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id DA6E76BCC2; Tue, 13 Feb 2007 16:03:08 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39530>

Jon Smirl wrote:
> On 2/11/07, Junio C Hamano <junkio@cox.net> wrote:
>> "Jon Smirl" <jonsmirl@gmail.com> writes:
>>
>> > jonsmirl@jonsmirl:/extra$ git clone
>> > git://git.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git
>> > Initialized empty Git repository in /extra/wireless-dev/.git/
>> > fatal: The remote end hung up unexpectedly
>>
>> Are you sure the above is ".../linux/kernel/gt/linville/..."?
> 
> You're right it should be git instead of gt, somewhere in my copying
> strings around I lost the 'i' and wasn't paying attention.  That's not
> a very good error message: "fatal: The remote end hung up
> unexpectedly" for a missing repository.
> 

It's necessary for security reasons that the git daemon doesn't tell you
*why* it failed though, otherwise attackers could use the git daemon to
browse the existance of files and directories on the remote end.

It could be nice to add "Are you sure $path_to_repo hosts a repository?"
to the message though, which would toss any spelling errors in the users'
face.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
