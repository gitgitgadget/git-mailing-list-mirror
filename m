From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: yet another workflow question...
Date: Thu, 11 Oct 2007 16:44:34 +0200
Message-ID: <E16F512D-21F4-4E01-888C-967603F63AD8@zib.de>
References: <e2a1d0aa0710110711m77ca967bmd1d5ffd5d3099aab@mail.gmail.com> <86lka9spjq.fsf@lola.quinscape.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 16:43:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfzFw-0000aF-2j
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 16:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbXJKOnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 10:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbXJKOnJ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 10:43:09 -0400
Received: from mailer.zib.de ([130.73.108.11]:62837 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118AbXJKOnH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 10:43:07 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9BEh3RU019983;
	Thu, 11 Oct 2007 16:43:03 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9BEh3jW000626
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 11 Oct 2007 16:43:03 +0200 (MEST)
In-Reply-To: <86lka9spjq.fsf@lola.quinscape.zz>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60603>


On Oct 11, 2007, at 4:18 PM, David Kastrup wrote:

> "Patrick Doyle" <wpdster@gmail.com> writes:
>
>> Sorry for cluttering up the list with yet another very basic workflow
>> question, but I'm still struggling with finding an answer to the
>> burning question, "What can git do for me?"  (So far, I have come to
>> the conclusion that, for my simple, single developer, branchless,
>> linear projects, there's not much that git can do for me that any
>> other SCM could do for me.  It appears to have been designed to solve
>> problems for which I have absolutely no appreciation whatsoever. :-))
>>
>> Anyway, on to basic newbie quesion #107...
>>
>> I've been working on my project and I realize that I have 3-4 files
>> modified with two orthogonal sets of changes.  (I didn't realize this
>> until I said to myself -- "Self, I should really check in these files
>> before I go too much further down this path".)  So I start "git
>> diff"-ing the files and I find that most files have differences
>> related to only one change or the other, but one file has differences
>> related to both changes.
>>
>> What do others do in this situation?
>> a) Not allow themselves to get into this situation in the first place
>> by careful planning?
>>
>> b) Copy the file to "file.bothchanges", edit out one set of changes,
>> commit that with one log message, edit back in the other set of
>> changes, edit in the other set of changes, commit that with another
>> log message?
>>
>> c) Use some sort of automation to do option (b) for them?
>>
>> d) Something else?
>
> git-add -i

git-gui, right click on change.

 From the user manual:

"""
You can also use git-gui(1) to create commits, view changes in the  
index and the working tree files, and individually select diff hunks  
for inclusion in the index (by right-clicking on the diff hunk and  
choosing "Stage Hunk For Commit").
"""

	Steffen
