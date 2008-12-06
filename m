From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: Re: ETA for release of gjit 0.4?
Date: Sat, 06 Dec 2008 13:57:00 -0500
Message-ID: <493ACAFC.5040605@wellfleetsoftware.com>
References: <49393BFC.6010606@wellfleetsoftware.com>
 <200812061947.27905.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 19:58:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L92MD-000549-DZ
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 19:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYLFS5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 13:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbYLFS5H
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 13:57:07 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:53630 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbYLFS5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 13:57:07 -0500
Received: from [192.168.1.101] ([98.110.173.56])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KBG00GDQXYZJHV2@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 06 Dec 2008 12:57:00 -0600 (CST)
In-reply-to: <200812061947.27905.robin.rosenberg.lists@dewire.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102469>



Robin Rosenberg wrote:
> fredag 05 december 2008 15:34:36 skrev Farrukh Najmi:
>   
>> Dear colleagues,
>>
>> I am using jgit in my maven project. Since current version is a SNAPSHOT 
>> (0.4-SNAPSHOT) I cannot release my project with a SNAPSHOT dependency 
>> (maven does not allow it). WHat is the time line for releasing version 
>> 0.4 of jgit so I can plan accordingly.
>> Thanks for any info.
>>     
>
> What? Plan? :)
>   

:-)

> You could name the version something else like 0.3.1.42b27c 
>
>   

I could but maven (and good project release) practices are that a 
project's release version should be managed by the project and not 
consumers of the project.

BTW, If there is interest in maveninzing the project I can offer to 
contribute that change to the project. Just let me know if that is 
something the project wishes to do.

Maven offers many benefits to projects as described in links below. It 
takes a little getting used to for project dev team but its not bad. It 
does not impact consumers of projects negatively in any way.

Background blog:
<http://farrukhnajmi.blogspot.com/2008/02/why-maven-rocks-in-beginning-there-was.html>

More useful link:
<http://ebxmlrr.wiki.sourceforge.net/whymaven>

Thanks for a great project.

> It was a long time since we labeled anything. Shawn, how about merging
> my recent close-file-patches, reverting 3ffa47d9294086fbd1cdeb9b1564f922a23e3c6f
> and e7307f14c531d52cf231c39d844841c4adaf5e5a and then just call i 0.4 ?
>
> -- robin
>
> # from my pu branch, the latest Tentative build in the update site. Works quite well for
> me. Refactoring and 
> $ git log --pretty=oneline origin/master..pu
> 2aafc054446f9b3aecdc01687a6949e4c54be6eb Revert "Rewrite GitMoveDeleteHook to use DirCacheBuilder"
> 439277860e1e315b7f0cd339b2435cc8311956c1 Revert "Teach GitMoveDeleteHook how to move a folder recursively"
> abc44bc6efa47c4c6e3c23f85fe9de9cd8460224 Improve closing of files in error situations.
> 22e2808ac2915446ed81115b663c684341ce6bdd Close a forgotten reference to the HEAD ref.
>
>   


-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
