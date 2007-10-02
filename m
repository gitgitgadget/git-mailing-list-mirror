From: Barry Fishman <barry_fishman@acm.org>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Tue, 02 Oct 2007 15:54:53 -0400
Message-ID: <m37im5qoky.fsf@barry_fishman.acm.org>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org>
	<7vejgeqxd1.fsf@gitster.siamese.dyndns.org>
	<87bqbisae6.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0710021045430.28395@racer.site>
	<m34ph9tye1.fsf@barry_fishman.acm.org>
	<Pine.LNX.4.64.0710021834470.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 23:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icot0-0005AT-GM
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 23:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbXJBVC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 17:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbXJBVC0
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 17:02:26 -0400
Received: from main.gmane.org ([80.91.229.2]:57774 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753964AbXJBVCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 17:02:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IcoKN-0000GH-1T
	for git@vger.kernel.org; Tue, 02 Oct 2007 20:26:47 +0000
Received: from fl-71-0-147-208.dhcp.embarqhsd.net ([71.0.147.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 20:26:47 +0000
Received: from barry_fishman by fl-71-0-147-208.dhcp.embarqhsd.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 20:26:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: fl-71-0-147-208.dhcp.embarqhsd.net
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:VJDhQM3eXys3lekW5lp+CrmylZs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59735>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 2 Oct 2007, Barry Fishman wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > Well, if the OP had used "git push <bla> master" instead of "... 
>> > master:master", it would have worked.  I am unaware of any tutorial 
>> > that suggests the latter, only of tutorials that suggest the former.
>> 
>> I did recheck the tutorials, and did not find the code I was
>> using.  So there was nothing incorrect in the documentation.
>
> Good.  Just for my curiousity: where in the documentation did you look for 
> help?  (We might want to advertise "git push <nick> <branch>" more loudly 
> there.)

I'm not sure, but I think I got the idea from:
  http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html
which does a fetch while in the bare repository rather than a push into
it:

  $ mkdir /pub/my-repo.git
  $ cd /pub/my-repo.git
  $ git --bare init --shared
  $ git --bare fetch /home/alice/myproject master:master

That series of commands works.

>> If there isn't an initial master branch, then shouldn't "git branch" be
>> able to create one.
>
> Why?  I really do not see the point in creating a branch which is named 
> different than "master", when you have nothing to begin with.

You are right, of course.  I was just following a line of thought, not
implying that creating such a branch was ever reasonable to do.

>>   This command creates an empty git repository - basically a .git directory
>>   with subdirectories for objects, refs/heads, refs/tags, and template
>>   files. An initial HEAD file references the refs/heads/master branch
>>   which is created with the first commit.
>
> How about "Your first commit will create the master branch" instead of the 
> last sentence?

Yes.  Less wobbly than how I worded it.

-- 
Barry Fishman
