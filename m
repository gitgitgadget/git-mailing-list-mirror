From: Johannes Schneider <mailings@cedarsoft.com>
Subject: How to resolve conflict: Moved away vs. created new file with same
 name
Date: Tue, 19 Jan 2010 12:10:32 +0100
Message-ID: <4B559328.2010206@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 12:32:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXCK6-0004ED-Lz
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 12:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab0ASLc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 06:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754123Ab0ASLc3
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 06:32:29 -0500
Received: from hosting.cedarsoft.com ([188.40.238.168]:48566 "EHLO
	cedarsoft.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756006Ab0ASLc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 06:32:28 -0500
X-Greylist: delayed 1313 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2010 06:32:28 EST
Received: from [192.168.0.36] (HSI-KBW-095-208-171-090.hsi5.kabel-badenwuerttemberg.de [95.208.171.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by cedarsoft.eu (Postfix) with ESMTP id 284D310CBE4A
	for <git@vger.kernel.org>; Tue, 19 Jan 2010 12:11:08 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091215 Lightning/1.0b2pre Shredder/3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137448>

Hi,

I had the following merge problem that I could not solve.


TopicA:

created a directory "client" containing a pom.xml and several source files.


TopicB:

created a directory "client" containing a pom.xml (different file than 
the one in TopicA).
Created several subdirectories (client1, client2).


You get the idea? I introduce several different clients and want them to 
be stored within one directory. But I did not have this idea when I have 
started TopicA.


So I am trying to mimic the change in TopicA:

cd client
mkdir client3
mv pom.xml client3
mv src client3
...commit...


Okay, so far so good. Now I try to merge TopicA and TopicB which fails. 
Of course Git doesn't understand that "client/pom.xml" in TopicA and 
TopicB are not related.
I want to end with to the file from TopicA ending in 
"client/client3/pom.xml" and the file from TopicB in "client/pom.xml".

I don't blame Git for not knowing what I want. I just wanna ask how I 
should tell Git what I want? Any hints?


Thanks,

Johannes
