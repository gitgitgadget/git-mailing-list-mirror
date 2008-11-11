From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: Re: Newbie questions regarding jgit
Date: Tue, 11 Nov 2008 16:12:58 -0500
Message-ID: <4919F55A.3050008@wellfleetsoftware.com>
References: <4919EECB.7070408@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 22:14:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L00Z6-00046i-8Y
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 22:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbYKKVNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 16:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYKKVND
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 16:13:03 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:64330 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbYKKVNB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 16:13:01 -0500
Received: from [192.168.1.101] ([71.184.206.167])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KA600HI8TLKTS84@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 11 Nov 2008 15:12:57 -0600 (CST)
In-reply-to: <4919EECB.7070408@wellfleetsoftware.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100680>


I should clarify that I am not using eclipse nor am I using any GUI. My 
objective is to have Java API access to git from within a servlet using 
jgit. At present, all I have to go on is javadoc and its not clear where 
to begin if I simply wish to create, read and update files in a git repo 
from within the servlet java code.

TIA for your help.

Farrukh Najmi wrote:
>
> Hi all,
>
> I am git newbie and looking to use jgit in a servlet endpoint.
>
> Where can I find a public maven repo for gjit? It seems there is one 
> somewhere because of the following file in src tree:
>
> jgit-maven/jgit/pom.xml
>
> For now I have built the jar using /make_jgit.sh and installed the pom 
> manually using m
>
> mvn install:install-file -DpomFile=jgit-maven/jgit/pom.xml 
> -Dfile=jgit.jar
>
> I have added the following dependency to my maven project's pom.xml:
>
>   <dependency>
>     <groupId>org.spearce</groupId>
>     <artifactId>jgit</artifactId>
>     <version>0.4-SNAPSHOT</version>
>   </dependency>
>
> Now I am wondering where to begin to learn how to do the equivalent of 
> the following commands via the gjit Java API:
>
>    * git add /file/
>    * git rm /file/
>    * git mv /file
>    * Whatever is the git way to get a specific version of a file
>
>
> I am hoping that there aremore docs, samples, tutorials etc. somewhere 
> that I am missing. Thanks for any help you can provide. Some pointers 
> or code fragments would be terrific.
>


-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
