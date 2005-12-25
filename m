From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possibility of a MinGW version?
Date: Sat, 24 Dec 2005 17:47:18 -0800
Message-ID: <7vr782osm1.fsf@assigned-by-dhcp.cox.net>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se>
	<7vwthus7gr.fsf@assigned-by-dhcp.cox.net> <43ADDD6F.7010502@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 02:47:36 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqKys-0006Xz-7P
	for gcvg-git@gmane.org; Sun, 25 Dec 2005 02:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVLYBrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 20:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVLYBrV
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 20:47:21 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:9602 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750782AbVLYBrV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 20:47:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051225014537.YJGG26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Dec 2005 20:45:37 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43ADDD6F.7010502@op5.se> (Andreas Ericsson's message of "Sun, 25
	Dec 2005 00:44:47 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14042>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> Andreas Ericsson <ae@op5.se> writes:
>>
>>> The fact that there are 39 bash'ish shell-scripts does little to
>>> help a native port...
>> Can you defend that "bash'ism" comment for all 39?  The one I
>> know of and would want to get rid of its bashism by rewriting is
>> git-grep, but most of them I thought was plain POSIX.
>
> Not really, no. I meant "there are 39 shell-scripts known to work with 
> bash but not necessarily known to fail with any other shell",...

I am not a Windows person (once I thought heard one particular
version of NT was POSIX compliant but I did not believe it), but
I suspect bash or not they may have trouble with POSIXism (iow
UNIX heritage), and if the port is done the right way by adding
compatibility layer they would end up reinventing Cygwin or
something close to it...
