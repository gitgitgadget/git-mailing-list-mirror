From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: Re: ETA for release of gjit 0.4?
Date: Mon, 08 Dec 2008 11:35:39 -0500
Message-ID: <493D4CDB.2010100@wellfleetsoftware.com>
References: <49393BFC.6010606@wellfleetsoftware.com>
 <200812061947.27905.robin.rosenberg.lists@dewire.com>
 <493ACAFC.5040605@wellfleetsoftware.com> <20081208162123.GD31551@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 08 17:38:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9j7Z-00013n-Ep
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 17:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbYLHQg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 11:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbYLHQg0
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 11:36:26 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:43489 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbYLHQgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 11:36:25 -0500
Received: from [192.168.1.101] ([98.110.173.56]) by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KBK00II9GRE2GE0@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 08 Dec 2008 10:35:39 -0600 (CST)
In-reply-to: <20081208162123.GD31551@spearce.org>
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102553>

Shawn O. Pearce wrote:
> Farrukh Najmi <farrukh@wellfleetsoftware.com> wrote:
>   
>> I could but maven (and good project release) practices are that a  
>> project's release version should be managed by the project and not  
>> consumers of the project.
>>
>> BTW, If there is interest in maveninzing the project I can offer to  
>> contribute that change to the project. Just let me know if that is  
>> something the project wishes to do.
>>     
>
> Have you seen the jgit-maven subdirectory?  It has a jgit/pom.xml
> contributed by Imran M Yousuf for exactly this reason.  I think we
> also have a Maven distribution site:
>
>   http://code.google.com/p/egit/wiki/ConfiguringMaven
>   

That work is commendable but it a workaround to adding maven packaging 
to a build and release process that is essentially not maven. This 
provides an important value that maven users such as myself get access 
to jgit via a maven repo. However, it does not help improve how the 
project manages its build and release processes.

> The issue is getting one of the developers to tag and upload a build.
> Myself, I don't actually use Maven, so I don't build with it.
>   

A completely maven based project would make above really simple and easy 
to manage using the maven-release-plugin and various other maven 
facilities. Changing version labels throughout code base, committing 
modified code, tagging, packaging, uploading etc. would all become 
automatic with a completely maven based code base. Maven seems like it 
is too complex and not worth the trouble in first glance (I felt that 
way at one point). However, a more careful examination reveals that it 
brings a lot of automated discipline, convenience and simplicity to 
numerous project tasks. Perhaps Imran and others could chime in on this 
issue to help make the case for mavenizing the project more completely.

Again, I have made my case for maven previously in the following links:

Background blog:
<http://farrukhnajmi.blogspot.com/2008/02/why-maven-rocks-in-beginning-there-was.html> 


More useful link:
<http://ebxmlrr.wiki.sourceforge.net/whymaven>

Thanks for your consideration of the suggestion.

-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
