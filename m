From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: markdown 2 man, was Re: Git Community Book
Date: Fri, 01 Aug 2008 12:19:30 +0200
Message-ID: <4892E332.5060804@lyx.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com> <7vvdylv9zq.fsf@gitster.siamese.dyndns.org> <4892B714.8010401@lyx.org> <200808011146.29883.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Scott Chacon <schacon@gmail.com>, Petr Baudis <pasky@suse.cz>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 01 12:20:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOrkW-0001Tr-6n
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 12:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbYHAKTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 06:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbYHAKTi
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 06:19:38 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:59166 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945AbYHAKTi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 06:19:38 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id CA42212B6F7;
	Fri,  1 Aug 2008 12:19:36 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 3F2AC12B6E3;
	Fri,  1 Aug 2008 12:19:36 +0200 (CEST)
User-Agent: Thunderbird/3.0a2pre (Windows; 2008072800)
In-Reply-To: <200808011146.29883.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91051>

Thomas Rast wrote:
> You wrote:
>    
>> Junio C Hamano wrote:
>>      
>>> How greppable and "log -p"-able is the documentation written in LyX?
>>>        
>> LyX format is plain text, loosely based on LateX. Here's attached a
>> sample .lyx file FYI. We have one tag per line and a maximum of 80 char
>> per line so that the format is easily parsable. Advanced users often use
>> unix tools (grep, sed, etc) to modify the .lyx file manually.
>>      
>
> Is it just me or is the format very hard to read?  For example, line
> 492ff spells a list of quoted items as
>    

Right, quote is a special case in lyx format because we have to take 
care of locale differences. So, as you guessed, quotes are not really 
written with the ascii quote character. But the format is not that hard 
in general. If needed, I could modify this special case so that it's 
easier to read though.
Don't get me wrong, I don't pretend that LyX is easy to read for the 
untrained eyes, it is not. But simple modifications like Junio's example 
is definitely possible. For non simple text insertion, it is better to 
launch LyX and to type the modification within LyX. But maybe this is a 
showstopper for you, and so is maybe our treatment of quotes. In which 
case I'll stop arguying :-)

Abdel.
