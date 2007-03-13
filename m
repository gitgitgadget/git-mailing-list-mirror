From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: svnimport problems (abysmal performance and crash) on Cygwin
Date: Tue, 13 Mar 2007 21:23:15 +0100
Message-ID: <45F70833.5080800@dawes.za.net>
References: <45F4F58D.2010701@dawes.za.net> <45F50023.9030403@dawes.za.net>	 <46a038f90703120339j674e15cqe0e0fa587736f9bc@mail.gmail.com>	 <45F59193.1070608@dawes.za.net> <45F6F724.4080704@dawes.za.net>	 <46a038f90703131250h1be0507v2feada21ea161362@mail.gmail.com>	 <45F700D8.80804@dawes.za.net> <46a038f90703131303r6a50c077n7144ddb0045062db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, normalperson@yhbt.net
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 21:23:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRDWm-0003w4-1U
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 21:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933187AbXCMUXT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 16:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933219AbXCMUXT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 16:23:19 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:47680 "EHLO
	spunkymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933187AbXCMUXS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2007 16:23:18 -0400
Received: from [0.0.0.0] (lucas.dreamhost.com [64.111.99.14])
	by spunkymail-a1.g.dreamhost.com (Postfix) with ESMTP id 8FE0CFFA7E;
	Tue, 13 Mar 2007 13:23:17 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <46a038f90703131303r6a50c077n7144ddb0045062db@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42151>

Martin Langhoff wrote:
> On 3/14/07, Rogan Dawes <lists@dawes.za.net> wrote:
>> Any suggestions for how *I* can figure it out?
> 
> Well -- all my experience with SVN has been when using it with
> svnimport ;-) and trying again and again.
> 
>  From looking at this url
> http://spring-rich-c.svn.sourceforge.net/svnroot/spring-rich-c/ I
> suspect that you might want to invoke it like
> 
> git-svnimport -T trunk -t tags -b branches
> http://spring-rich-c.svn.sourceforge.net/svnroot/spring-rich-c/
> 
> (note the shorter url).
> 
> If that works but leaves the main project in a subdirectory, but the
> trees in branches and tags without the subdirectory, you might want to
> try:
> 
> git-svnimport -T trunk/spring-richclient -t tags -b branches
> http://spring-rich-c.svn.sourceforge.net/svnroot/spring-rich-c/
> 
> It might take a couple of tries. NOTE: you should check not only the
> main dev track but also the branches and tags for sanity.
> 
> cheers
> 
> 
> m

That seems to be working now, with the second commandline that you 
suggested. I'll still verify the tags, but I think that the branches are 
less likely to be a problem, since the project hasn't actually made any, 
as far as I am aware (at least, none that I am interested in).

Thanks for your help!

Rogan
