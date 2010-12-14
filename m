From: "psantosl@codicesoftware.com" <psantosl@codicesoftware.com>
Subject: Re: [ANNOUNCE] GitJungle is out!
Date: Tue, 14 Dec 2010 17:42:28 +0100
Message-ID: <4D079E74.10408@codicesoftware.com>
References: <4D05FF8D.7080306@codicesoftware.com> <4D079155.4020102@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?David_Su=E1rez?= <dsuarezv@codicesoftware.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 14 17:42:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSXxV-0003tZ-AM
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 17:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759532Ab0LNQmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 11:42:32 -0500
Received: from berith.lunarbreeze.com ([216.97.239.175]:54065 "EHLO
	berith.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759560Ab0LNQmb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 11:42:31 -0500
Received: from 102.red-83-33-14.dynamicip.rima-tde.net ([83.33.14.102] helo=[192.168.2.33])
	by berith.lunarbreeze.com with esmtpa (Exim 4.69)
	(envelope-from <psantosl@codicesoftware.com>)
	id 1PSXxN-0006Jm-7Z; Tue, 14 Dec 2010 08:42:29 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <4D079155.4020102@alum.mit.edu>
X-Enigmail-Version: 1.1.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - berith.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - codicesoftware.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163657>

Hi Michael,

The commits are walked from the heads, starting on master. Once a commit
is assigned to a branch, it stays there. So the diagram would have a
different aspect if the heads were walked in a different order.

David (in CC) is the one to ask for details, he's still struggling to
get a better render than what we have right now.

Thanks,

pablo


On 12/14/2010 16:46, Michael Haggerty wrote:
> On 12/13/2010 12:12 PM, psantosl@codicesoftware.com wrote:
>> We've just released GitJungle
>> [...] The drawing approach we use is a little bit
>> different from what other git tools are using: we draw horizontally
>> instead of vertically, we think it is a better way but, you know, it is
>> probably a matter of preference.
> 
> Given that git doesn't permanently record the branch that a commit was
> first made on, how do you decide on what row to draw a commit?  E.g., if
> I have two branches A and B that share a common ancestor
> 
>       o-o  <- A
>      /
> o-o-o
>      \
>       o-o  <- B
> 
> how do you decide whether to draw the ancestor on the row for A vs. the
> row for B?
> 
> Michael
> 
