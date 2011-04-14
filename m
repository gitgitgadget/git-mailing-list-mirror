From: Chris Perkins <cperkins@medialab.com>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 22:58:44 -0300
Message-ID: <4DA654D4.5040104@medialab.com>
References: <BANLkTikfCDm-5Yde=2Cm-ROc1dcMwopvOg@mail.gmail.com> <4238CC86-13A5-4DB8-B8B2-BC3AA2F2DA5E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Searles <daniel.paul.searles@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Drew Northup <drew.northup@maine.edu>, oleganza@gmail.com,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Searles <dsearles@medialab.com>
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 04:21:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QACB3-0008Jp-OS
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 04:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758249Ab1DNCUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 22:20:55 -0400
Received: from smtp02.frii.com ([216.17.135.168]:50827 "EHLO smtp02.frii.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398Ab1DNCUz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 22:20:55 -0400
X-Greylist: delayed 1326 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Apr 2011 22:20:55 EDT
Received: from s-expression.local (unknown [190.195.43.191])
	by smtp02.frii.com (FRII) with ESMTP id 3B3E2D8BE4;
	Wed, 13 Apr 2011 19:58:45 -0600 (MDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4238CC86-13A5-4DB8-B8B2-BC3AA2F2DA5E@gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171501>

Let's look at this at a slighty different way. Let's say someone writes
a GUI wrapper for Git, bundles it with Git, and then offers for sale a
new proprietary SVC system. They list off all the wonderful features
that it has.  On the back page of their website is a small 'Licenses'
disclosure and the source code to Git comes with the download buried in
a subdirectory.  None of the users realize the software is using Git.

Is that a violation of the GPL? I would say that it absolutely is. A
proprietary software is being built atop the hard labor of the GPL
authored software. Hundreds contributed to the Open Source effort, one
profits by burying their work in his with the minimal effort.

So, I guess the question is, how is that scenario different than Gitbox?
I guess Gitbox doesn't present itself as something else, but code-wise
it is no different. Without the Git binary there is no Gitbox.


(Randal L Schwartz writes):
>And it's also about readline.a, which *has* to be linked into a binary
>to make it work.  None of the git code is being *linked* in.

The GPL doesn't mention .a files versus .o versus .so.   _Linked_ is not
the issue.  The issue is one work being _based_ on another, and the word
_based_ is the one that appears in the GPL, including the section you
quoted.

Section 2 b) of GPL 2 plainly states that any work based on a GPL
licensed product must be distributed free of charge and be GPL:

  2 b) You must cause any work that you distribute or publish,
  that in whole or in part contains or is derived from the Program
  or any part thereof, to be licensed as a whole at no charge to
  all third parties under the terms of this License.

And the closing explanation of the GPL 2 says the same in even more
frank and plain language. These are the last three lines. 'your program'
refers to the program being placed under GPL (ie Git), they are written
to someone considering releasing software under the GPL:

  This General Public License does not permit incorporating your
  program into proprietary programs. If your program is a subroutine
  library, you may consider it more useful to permit linking
  proprietary applications with the library. If this is what you want
  to do, use the GNU Lesser General Public License instead of this
  License.



(Joshua Juran writes):
> My shell scripts that call git are also useless without Git.  Am I not
> allowed to distribute my scripts under non-GPL terms?  

I don't know the answer to this. Maybe they must be distributed as GPL.


(Joshua Juran writes):
> CVS is a GNU project.  Did FSF go after proprietary cvs wrappers?

I don't know, but I doubt they did.  And it is a good point that failure
to defend a copyright can often be argued in court as tacit disavowal of
that copyright.




Chris
