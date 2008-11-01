From: david@lang.hm
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 18:04:50 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810311802360.5851@asgard.lang.hm>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <7viqr873x7.fsf@gitster.siamese.dyndns.org> <20081031234115.GD14786@spearce.org> <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm>
 <20081101010011.GG14786@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 02:05:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw4vf-0000EN-AM
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 02:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbYKABEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbYKABEN
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:04:13 -0400
Received: from mail.lang.hm ([64.81.33.126]:40084 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbYKABEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:04:12 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mA114AOX029674;
	Fri, 31 Oct 2008 17:04:10 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20081101010011.GG14786@spearce.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99696>

On Fri, 31 Oct 2008, Shawn O. Pearce wrote:

> david@lang.hm wrote:
>> On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
>>> Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>> I.e. use the supplied custom function to do proprietary magic, such as
>>>> reading the object lazily from elsewhere over the network.  And we will
>>>> never get that magic bit back.
>>>
>>> Maybe I just think too highly of the other guy, but I'd hope that
>>> anyone patching libgit2 like above would try to avoid it, because
>>> they'd face merge issues in the future.
>>
>> the issue that I see is that libgit2 will be (on most systems) a shared
>> library.
>>
>> what's to stop someone from taking the libgit2 code, adding the magic
>> proprietary piece, and selling a new libgit2 library binary 'just replace
>> your existing shared library with this new one and all your git related
>> programs gain this feature'
>
> True.  The only thing that prevents that is the normal GPL. The
> LGPL and GPL+"gcc exception" allow this sort of mean behavior.
> I doubt there's enough of a market for that; replacing a library
> is something of a pain and if the feature really is interesting or
> useful someone will write a clean-room re-implementation and submit
> patches to do the same thing.

how would the LGPL of GPL+gcc extention allow this? if they modify the 
code in the library and then distribute the modified library wouldn't they 
be required to distribute the changes to that library?

they could use the LGPL or GPL+exception library with their propriatary 
program, but I don't see how they could get away with modifying the 
library.

David Lang
