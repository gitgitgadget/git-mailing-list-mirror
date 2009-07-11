From: henon <meinrad.recheis@gmail.com>
Subject: Re: C# Git Implementation
Date: Sat, 11 Jul 2009 14:25:56 -0700 (PDT)
Message-ID: <1247347556196-3243735.post@n2.nabble.com>
References: <001501c9515e$66e8ac70$34ba0550$@com> <alpine.DEB.2.00.0811291308120.17643@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 23:26:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPk58-0000O9-2P
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 23:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbZGKVZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 17:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbZGKVZ5
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 17:25:57 -0400
Received: from kuber.nabble.com ([216.139.236.158]:35761 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbZGKVZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 17:25:57 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1MPk4y-0007CA-6W
	for git@vger.kernel.org; Sat, 11 Jul 2009 14:25:56 -0700
In-Reply-To: <alpine.DEB.2.00.0811291308120.17643@vellum.laroia.net>
X-Nabble-From: meinrad.recheis@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123132>



Asheesh Laroia-2 wrote:
> 
> On Fri, 28 Nov 2008, JD Guzman wrote:
> 
>> I read in the archives that there was once talk of porting Git over to 
>> C# and was wondering if anything ever came of this?  I realize there 
>> were some that didn't see the use for this but as Git is becoming more 
>> and more popular a more native implementation of Git for windows users 
>> would be a good endevour IMHO.
> 
> Is it possible to compile the Java-language jgit with the Common Language 
> Runtime and access that from a C# application?
> 
> -- Asheesh.
> 

Hi,
Just in case some of you are still interested in a git implementation in C#.
I evaluated all of the existing projects and chose the one of them which was
most advanced and had the most promising strategy of getting done soon:
kevin thompsons gitty. gitty is a  port of about 6k of ~20k lines of a jgit
snapshot from 2008. The gitty code is mostly not working because it has
never been debugged after porting.
 
I figured that the easiest way to a pure c# implementation of git is to port
jgit. Automatic porting attempts have not really been successful so I
decided to do it manually. Based on Kevin's very erraneous but yet valuable
work I ported even more substantial parts of jgit and its tests to C# and
got much of the code working as the over 200 passing tests can tell. By now
we have ported about 47% of the jgit source (snapshot from june 2009) and
got reading of repos and writing of trees, blobs and commits to work
already. The project is called Git# now and has already found a few
contributors on github. More info is available at the 
http://www.eqqon.com/index.php/GitSharp Git#  website.

I know that there have been several attempts by the Mono project to create a
git implementation in C#. They seem inactive and in a very basic state to me
but correct me if I am wrong. I will try to contact the mono folks for
collaboration on the matter.

-- henon
-- 
View this message in context: http://n2.nabble.com/C--Git-Implementation-tp1589227p3243735.html
Sent from the git mailing list archive at Nabble.com.
