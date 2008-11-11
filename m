From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: Newbie questions regarding jgit
Date: Tue, 11 Nov 2008 15:44:59 -0500
Message-ID: <4919EECB.7070408@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 21:46:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L007w-0007nl-Vi
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 21:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbYKKUpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 15:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbYKKUpA
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 15:45:00 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:42330 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbYKKUo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 15:44:59 -0500
Received: from [192.168.1.101] ([71.184.206.167])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KA600HNJSAXAKS1@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 11 Nov 2008 14:44:58 -0600 (CST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100672>


Hi all,

I am git newbie and looking to use jgit in a servlet endpoint.

Where can I find a public maven repo for gjit? It seems there is one 
somewhere because of the following file in src tree:

jgit-maven/jgit/pom.xml

For now I have built the jar using /make_jgit.sh and installed the pom 
manually using m

mvn install:install-file -DpomFile=jgit-maven/jgit/pom.xml -Dfile=jgit.jar

I have added the following dependency to my maven project's pom.xml:

   <dependency>
     <groupId>org.spearce</groupId>
     <artifactId>jgit</artifactId>
     <version>0.4-SNAPSHOT</version>
   </dependency>

Now I am wondering where to begin to learn how to do the equivalent of 
the following commands via the gjit Java API:

    * git add /file/
    * git rm /file/
    * git mv /file
    * Whatever is the git way to get a specific version of a file


I am hoping that there aremore docs, samples, tutorials etc. somewhere 
that I am missing. Thanks for any help you can provide. Some pointers or 
code fragments would be terrific.

-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
