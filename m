From: Joe Fiorini <joe@faithfulgeek.org>
Subject: Re: Switching branches without committing changes
Date: Fri, 21 Mar 2008 00:40:46 -0400
Message-ID: <0A5FD247-A09E-4E3A-8BB5-35F9390E7FB3@faithfulgeek.org>
References: <A17C3E8C-3D0E-41B4-8A43-37EC8C3F55C2@faithfulgeek.org> <20080321040647.GE8410@spearce.org> <20080321041013.GA2502@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:41:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcZ4e-00085A-Ki
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 05:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbYCUEk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 00:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbYCUEk5
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 00:40:57 -0400
Received: from mail-out1.fuse.net ([216.68.8.175]:62621 "EHLO
	mail-out1.fuse.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbYCUEk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 00:40:56 -0400
X-CNFS-Analysis: v=1.0 c=1 a=wnOyx2Aoai8A:10 a=o9CV-XpjGkir8lJqPdwA:9 a=GNKFg6X9nWcllmSN0iW26WU_GfcA:4 a=XF7b4UCPwd8A:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: gwout1 smtp.user=jfiorini@zoomtown.com; auth=pass (LOGIN)
Received: from [66.93.11.195] ([66.93.11.195:52971] helo=[192.168.1.33])
	by mail-out1.fuse.net (ecelerity 2.1.1.22 r(17669)) with ESMTPA
	id FE/29-08390-E4C33E74 for <peff@peff.net>; Fri, 21 Mar 2008 00:40:55 -0400
In-Reply-To: <20080321041013.GA2502@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77707>

Thanks for the replies.  I definitely like the stashing approach.  Is  
there any overhead or caveat to using stash a lot?

-Joe

On Mar 21, 2008, at 12:10 AM, Jeff King wrote:

> On Fri, Mar 21, 2008 at 12:06:47AM -0400, Shawn O. Pearce wrote:
>
>> Use `git checkout -m` to switch the branch anyway.  However, if
>> there is a merge conflict while you are trying to carry the changes
>> to the other branch you may be faced with a merge conflict you are
>> not prepared to resolve, or simply cannot resolve in a reasonable
>> period of time.
>
> Ah, for some reason I didn't think of '-m' in the advice I gave (I  
> guess
> I have just never used it). It is almost certainly simpler than  
> using a
> 'stash' at this point (but I do think stashing _beforehand_ still has
> advantages).
>
> -Peff
