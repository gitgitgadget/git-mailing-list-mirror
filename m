From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Tue, 20 May 2008 22:12:11 +0200
Message-ID: <4833309B.90706@dirk.my1.cc>
References: <48301B17.30309@dirk.my1.cc> <20080519022125.GV29038@spearce.org> <4833206E.1080300@dirk.my1.cc> <20080520194403.GC29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 20 22:13:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyYCv-0006Vw-Lt
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 22:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759147AbYETUMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 16:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759421AbYETUMV
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 16:12:21 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:47575 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759024AbYETUMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 16:12:20 -0400
Received: from [84.176.80.190] (helo=[192.168.2.100])
	by smtprelay11.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JyYBw-0003NH-Uj; Tue, 20 May 2008 22:12:13 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080520194403.GC29038@spearce.org>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82495>

Shawn O. Pearce schrieb:
> Dirk Ssserott <newsletter@dirk.my1.cc> wrote:
>   
>> thanks for your patch. Actually I had problems applying it and
>> finally gave up. I'm using the msysGit package which seems quite
>> similar to the cygwin package but not in all cases, apparently.
>>     
>
> Well, msysGit is perhaps on an older version of git-gui.  But
> I had thought they were fairly current and that the section of
> code the patch touches hasn't been modified in a while.  Maybe
> there was an issue with CRLF?
>   
Well, CRLF was one of the issues, but I fixed that with 'dos2unix'. At 
least I tried.
Don't bother. I had some problems with the filenames. git-gui.sh is in my
git-repo (git clone ...), whereas git-gui and git-gui.tcl are in my /bin 
directory.
I didn't know which to patch, tried them all, and copied them around.
As said, don't bother. It's just my stupidness.
>  
>   
>> However, you were right. The trace doesn't show the commands I
>> would use on a regular basis (I couldn't stop you :-)).
>> On the other hand it possibly helps to /understand/ (or at least
>> /see/) what's going on under the hood.
>>
>> For that reason I'd greatly appreciate seeing your patch in some
>> future version of Git. It doesn't do any harm, does it? People
>> that don't like it can simply omit the '--trace' switch.
>>
>> Junio? The list?
>>     
>
> Junio defers almost all git-gui things to me, as I am the current
> maintainer of git-gui.  You are right, it doesn't really hurt to
> include it, and now that it is written, the hard part is already
> done.  I'll apply it to my main git-gui tree and ask Junio to
> include it in a future version of Git.
>   
Great! Sorry, I didn't want to offend you. Wasn't aware that *you* are 
the git-gui maintainer.
Thanks. I'm looking forward to seeing this patch. :-)

    Dirk
