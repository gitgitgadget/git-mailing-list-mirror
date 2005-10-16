From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Sun, 16 Oct 2005 13:15:45 -0400
Message-ID: <43528AC1.2060904@didntduck.org>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org> <434EABFD.5070604@zytor.com> <434EC07C.30505@pobox.com> <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org> <435264B1.2010204@de.bosch.com> <Pine.LNX.4.63.0510161122570.23242@iabervon.org> <20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 16 19:15:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERC5Q-0006oX-1K
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 19:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVJPRON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 13:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVJPRON
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 13:14:13 -0400
Received: from quark.didntduck.org ([69.55.226.66]:9928 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751334AbVJPROM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 13:14:12 -0400
Received: from [172.21.26.77] (ip-2.provia.com [208.224.1.2])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j9GHE8I02471;
	Sun, 16 Oct 2005 13:14:08 -0400
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <43527E86.8000907@didntduck.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10164>

Brian Gerst wrote:
> Nick Hengeveld wrote:
> 
>> On Sun, Oct 16, 2005 at 11:44:46AM -0400, Daniel Barkalow wrote:
>>
>>> This is the problem: it's impossible to download only a few objects 
>>> from a pack file from an HTTP server, because those don't exist on 
>>> the server as separate files.
>>
>>
>> Is it possible to determine the object locations inside the remote pack
>> file?  If so, it would be possible to use Range: headers to download
>> selected objects from a pack.
>>
> 
> Not possible because the entire pack is compressed.

I should have looked at the source more closely before stating that. 
Each object gets compressed individually, so this would be possible.

--
					Brian Gerst
