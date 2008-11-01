From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 18:00:11 -0700
Message-ID: <20081101010011.GG14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <7viqr873x7.fsf@gitster.siamese.dyndns.org> <20081031234115.GD14786@spearce.org> <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Nov 01 02:03:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw4tt-0008LS-Nv
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 02:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbYKABAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYKABAO
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:00:14 -0400
Received: from george.spearce.org ([209.20.77.23]:35640 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbYKABAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:00:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E420D3835F; Sat,  1 Nov 2008 01:00:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99695>

david@lang.hm wrote:
> On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
>> Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> I.e. use the supplied custom function to do proprietary magic, such as
>>> reading the object lazily from elsewhere over the network.  And we will
>>> never get that magic bit back.
>>
>> Maybe I just think too highly of the other guy, but I'd hope that
>> anyone patching libgit2 like above would try to avoid it, because
>> they'd face merge issues in the future.
>
> the issue that I see is that libgit2 will be (on most systems) a shared  
> library.
>
> what's to stop someone from taking the libgit2 code, adding the magic  
> proprietary piece, and selling a new libgit2 library binary 'just replace 
> your existing shared library with this new one and all your git related  
> programs gain this feature'

True.  The only thing that prevents that is the normal GPL. The
LGPL and GPL+"gcc exception" allow this sort of mean behavior.
I doubt there's enough of a market for that; replacing a library
is something of a pain and if the feature really is interesting or
useful someone will write a clean-room re-implementation and submit
patches to do the same thing.

> they would only face merge issues if they need to keep up to date with  
> you, and git makes it pretty easy to maintain a fork if you only have to  
> do one-way merging (rere)

In other words, we're too good for our own good.  ;-)

-- 
Shawn.
