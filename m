From: "Jim Vahl" <jv@wmdb.com>
Subject: RE: A basic question
Date: Thu, 11 Oct 2012 10:38:49 -0700
Message-ID: <002801cda7d7$4792c260$d6b84720$@com>
References: <001501cda711$8ab6f0a0$a024d1e0$@com> <1349897794.32696.15.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Skot Davis'" <skotd122@gmail.com>, <git@vger.kernel.org>
To: "'Drew Northup'" <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Oct 11 19:39:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMMiu-0002f2-Qq
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 19:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815Ab2JKRix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 13:38:53 -0400
Received: from 339272-web1.sleeplessmedia.com ([72.32.211.234]:55342 "EHLO
	339272-web1.sleeplessmedia.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964797Ab2JKRix (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 13:38:53 -0400
Received: (qmail 16651 invoked from network); 11 Oct 2012 12:38:52 -0500
Received: from softdnserror (HELO Sequoia) (12.157.119.40)
  by 192.168.100.234 with SMTP; 11 Oct 2012 12:38:52 -0500
In-Reply-To: <1349897794.32696.15.camel@drew-northup.unet.maine.edu>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: Ac2nHrO92/kFvT7+R86jvzaMfgLAxgAsQyGg
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207499>

Drew, 

Thanks for responding to my email!

Yes, I did read most of the Book, although I admit that I skimmed over some
of the more technical parts.  There is still a key part of how git is used
in a commercial environment which I don't understand.

When we release a new version of our product, it is comprised of over a
hundred files.  Some of these files have not changed for years, and some
have been revised/fixed/updated quite recently.  But what is key is that all
of these components have passed a review and testing process.  A very
important piece of information is what revision of each file made it into
the release.

I know that git takes snapshots of the repository as changes are made and
that it is possible to reconstruct the file set at any point in time.  But
unless rules or conventions are established, at any time the repository can
contain files which are in the process of being modified and thus have not
passed the testing process.  For the purpose of planning a release, we're
interested only in the "most recently tested and approved" files.

For the sake of argument, I'll assume that a committing a change implies
that the file has passed the testing process.  So my questions are:

1) Does git have a built-in way to get a list of all of the "most recently
committed" files only at a given point in time, thus automatically recording
the revisions of all of the component files of a release?   This implies
that for files which are being modified or which have been staged but not
committed, that git would go back to find the "predecessor" file which had
been committed.

 2) Does git have a way of creating and exporting a list of the "most
recently committed" files only?

3) If the answer to the above questions is "No", then what is the normal way
for a programming shop which is using git to extract/assemble the list of
approved files for building a release? 

Thank you.

Jim Vahl

-----Original Message-----
From: Drew Northup [mailto:drew.northup@maine.edu] 
Sent: Wednesday, October 10, 2012 12:37 PM
To: Jim Vahl
Cc: git@vger.kernel.org; 'Skot Davis'
Subject: Re: A basic question

On Wed, 2012-10-10 at 11:03 -0700, Jim Vahl wrote:
> All,
> 
> Our company is researching version control software, something which 
> we have not used previously.  I have a very basic question about git 
> which I have not been able to answer from reading.  As I understand 
> it, a git repository can be a mixture of files which are under
development, staged or committed.
> If we make a new build of our product we will obviously only want to 
> include the committed (tested) files.
> 
> The question is this: what is the usual procedure to retrieve a set of 
> committed  files only from the repository to place into a distribution 
> or "ready to build" folder.  The same question goes for tagging a 
> release: how does the user get the tag to reference the committed 
> files only and not the most recent files which may be under development or
undergoing testing.
> 
> Thanks,
> 
> Jim Vahl

Jim,
Have you looked at http://git-scm.com/book yet? It sounds to me like you
have some misconceptions about how Git works. (If so, did it leave you more
or less confused?)

--
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
