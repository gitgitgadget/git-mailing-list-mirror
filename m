From: Joe Fiorini <joe@faithfulgeek.org>
Subject: Re: Switching branches without committing changes
Date: Mon, 24 Mar 2008 10:46:06 -0400
Message-ID: <8AD80272-53D2-4020-9F53-F4249DEEDF4B@faithfulgeek.org>
References: <A17C3E8C-3D0E-41B4-8A43-37EC8C3F55C2@faithfulgeek.org> <20080321040647.GE8410@spearce.org> <20080321041013.GA2502@coredump.intra.peff.net> <7vod98u1pr.fsf@gitster.siamese.dyndns.org> <200803230100.m2N102oR025238@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, peff@peff.net,
	spearce@spearce.org, git@vger.kernel.org
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 15:48:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdnyo-0005FI-Qt
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 15:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759948AbYCXOsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 10:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759850AbYCXOsI
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 10:48:08 -0400
Received: from mail-out1.fuse.net ([216.68.8.175]:58978 "EHLO
	mail-out1.fuse.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759872AbYCXOsH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 10:48:07 -0400
X-CNFS-Analysis: v=1.0 c=1 a=wnOyx2Aoai8A:10 a=mDV3o1hIAAAA:8 a=grMMVz1EAAAA:8 a=fwpP7P-PAAAA:8 a=M8MsmU4GhF7HQ46tkbEA:9 a=_pBVK8e1ug7GXxwUEPMA:7 a=jvAAwVE3zCul87XVZnIak_X6bTEA:4 a=OdWmie4EkE0A:10 a=8b0TY1xhFYQA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: gwout1 smtp.user=jfiorini@zoomtown.com; auth=pass (LOGIN)
Received: from [66.93.11.195] ([66.93.11.195:60227] helo=[192.168.1.33])
	by mail-out1.fuse.net (ecelerity 2.1.1.22 r(17669)) with ESMTPA
	id E5/F8-08390-FAEB7E74 for <xma@gnu.org>; Mon, 24 Mar 2008 10:46:21 -0400
In-Reply-To: <200803230100.m2N102oR025238@localhost.localdomain>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78043>

Can you send me a link to the official wiki?  If I have access to it,  
I will see about updating it today.

-Joe

On Mar 22, 2008, at 9:00 PM, Xavier Maillard wrote:

>
>   Jeff King <peff@peff.net> writes:
>
>> On Fri, Mar 21, 2008 at 12:06:47AM -0400, Shawn O. Pearce wrote:
>>
>>> Use `git checkout -m` to switch the branch anyway.  However, if
>>> there is a merge conflict while you are trying to carry the changes
>>> to the other branch you may be faced with a merge conflict you are
>>> not prepared to resolve, or simply cannot resolve in a reasonable
>>> period of time.
>>
>> Ah, for some reason I didn't think of '-m' in the advice I gave (I  
>> guess
>> I have just never used it). It is almost certainly simpler than  
>> using a
>> 'stash' at this point (but I do think stashing _beforehand_ still has
>> advantages).
>
>   The thing is, that -m is really to mollify people who are _too_  
> accustomed
>   to CVS/SVN update behaviour.  Over there, "scm update" does not  
> give you
>   any choice other than having to merge.
>
> This post is *yet* another valuable candidate to put onto the wiki.
>
> 	Xavier
> -- 
> http://www.gnu.org
> http://www.april.org
> http://www.lolica.org
