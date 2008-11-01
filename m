From: Andreas Ericsson <ae@op5.se>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 11:52:13 +0100
Message-ID: <490C34DD.8070201@op5.se>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <20081031213114.GA21799@artemis.corp> <alpine.LFD.2.00.0810311756160.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 11:55:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwE8K-0003Mj-HB
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 11:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbYKAKwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 06:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbYKAKwd
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 06:52:33 -0400
Received: from mail.op5.se ([193.201.96.20]:57549 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbYKAKwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 06:52:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1515B26A0E5C;
	Sat,  1 Nov 2008 11:47:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G77d1G5N-21k; Sat,  1 Nov 2008 11:47:08 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id E360E26A0E5B;
	Sat,  1 Nov 2008 11:47:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <alpine.LFD.2.00.0810311756160.13034@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99728>

Nicolas Pitre wrote:
> On Fri, 31 Oct 2008, Pierre Habouzit wrote:
> 
>> Git is currently mostly "GPLv2 or later". A BSDish license was
>> mentioned, because it's the most permissive one and that nobody cared
>> that much, though a LGPL/GPL-with-GCC-exception would probably fly.
> 
> I do care.  I think the BSD license is too permissive.  There are really 
> nifty pieces of code in Git that I would be really sorry to see go 
> proprietary.
> 

I agree with Nicolas, for what it's worth. Although I realize my small
contributions to the git code can be trivially rewritten, I think that
will definitely be trickier with Nicolas' contributions.

> 
>> OT: FWIW I prefer BSDish licenses (even the MIT actually) for libraries
>> because I believe that computing is overall better if everyone can use
>> the right tool for the task, and I don't want to prevent people from
>> using good stuff (I hope I write good stuff ;P) because of the license.
> 
> Everybody can and does link against glibc on Linux which is LGPL.  So 
> that doesn't affect "usage".
> 

For dynamic libraries, yes, as you can replace them in-flight if you need
to. For static libraries, it's a different matter. I think the gcc exception
is rather special, as parts of gcc is the dynamic linker initialization code,
which has to be shipped in object form and included in all executables
produced with gcc. Perhaps we'd be better off asking one of EFF's lawyers
what each license means, exactly.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
