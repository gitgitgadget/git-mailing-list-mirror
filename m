From: Tommy Thorn <tommy-git@thorn.ws>
Subject: Re: [PATCH 2/3] git-p4: support exclude paths
Date: Sun, 03 Feb 2008 10:55:28 -0800
Message-ID: <47A60E20.7060909@thorn.ws>
References: <9439626e72a267ff29cb6eaa1c733ec4641341d9.1202029604.git.tommy-git@thorn.ws> <dd96ea0b47e8ec67ef14e4e954aa9ec7bec3c295.1202029604.git.tommy-git@thorn.ws> <200802031941.17010.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Sun Feb 03 19:56:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLk0a-0001LK-Vd
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 19:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbYBCSz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 13:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbYBCSz2
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 13:55:28 -0500
Received: from server204.webhostingpad.com ([69.65.0.218]:47414 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750859AbYBCSz1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Feb 2008 13:55:27 -0500
Received: from 208.65.183.75.static.etheric.net ([208.65.183.75] helo=silver.numba-tu.com)
	by server204.webhostingpad.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1JLjzx-0006GJ-3Q; Sun, 03 Feb 2008 12:55:25 -0600
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <200802031941.17010.simon@lst.de>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72392>

Simon Hausmann wrote:
> On Sunday 03 February 2008 10:21:05 Tommy Thorn wrote:
>   
>> Teach git-p4 about the -/ option which adds depot paths to the exclude
>> list, used when cloning. The option is chosen such that the natural
>> Perforce syntax works, eg:
>>
>>   git p4 clone //branch/path/... -//branch/path/{large,old}/...
>>
>> Trailing ... on exclude paths are optional.
>>
>> This is a generalization of a change by Dmitry Kakurin (thanks).
>>
>> Signed-off-by: Tommy Thorn <tommy-git@thorn.ws>
>>     
>
> Acked-By: Simon Hausmann <simon@lst.de>
>
> I like it, Perforce'ish syntax. (Not that I like p4 though ;)
>   
Thank you.

I would appear that I have some mail server problems, so apologies if 
you get multiple copies.

Also, this is the first Python hacking I've tried, so it's likely that 
my changes needs improvement.

With these two patches, I can now use git-p4. However in a perfect 
world, git-p4 would:

- include support everything that a (ugly) Perforce client can do, 
including naming individual files
  and remapping things around (a sick feature that never should be used 
IMO), and

- not consume memory proportional to the imported files.

The former would require pervasive changes and likely break some 
assumptions currently made.

The latter is easy enough.


Regards
Tommy
