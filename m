From: "Sam G." <ceptorial@comcast.net>
Subject: Re: Searching all git objects
Date: Wed, 25 Jun 2008 17:49:45 -0700
Message-ID: <321F18C8-351F-4E91-9F00-CFE2711B67D1@comcast.net>
References: <E99352BE-5C43-437E-A5E6-622BEEA03DFA@comcast.net> <20080625231742.GT11793@spearce.org> <905315640806251632m416a2406x301b857ec7faf09d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 02:50:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBfhJ-0003B4-0B
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 02:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbYFZAtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 20:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbYFZAtu
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 20:49:50 -0400
Received: from mail.box.net ([67.15.218.250]:53714 "EHLO mail.box.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602AbYFZAtt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 20:49:49 -0400
Received: (qmail 30516 invoked from network); 25 Jun 2008 19:48:25 -0500
Received: from c-24-130-19-112.hsd1.ca.comcast.net (HELO ?192.168.1.199?) (24.130.19.112)
  by mail.box.net with (AES128-SHA encrypted) SMTP; 25 Jun 2008 19:48:25 -0500
In-Reply-To: <905315640806251632m416a2406x301b857ec7faf09d@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86380>

On Jun 25, 2008, at 4:32 PM, Tarmigan wrote:

> On Wed, Jun 25, 2008 at 4:17 PM, Shawn O. Pearce  
> <spearce@spearce.org> wrote:
>> "Sam G." <ceptorial@comcast.net> wrote:
>>> We recently had a developer make a large commit (mostly centered
>>> around one file) which she believed she properly pushed to a remote
>>> repository last week, but looking at both her repository and the
>>> remote repository, that commit is now nowhere to be found. If  
>>> somehow
>>> the master branch she was working on in her repository has lost the
>>> reference to the commit through perhaps some errant rebasing, then
>>> perhaps an object containing the commit (or an object containing the
>>> file in that commit) still exists somewhere inside her .git/objects
>>> directory? We haven't done any git-gc recently. If so, how can I
>>> search through every single git object in her objects directory,
>>> searching for perhaps a specific part of the commit string, a line  
>>> in
>>> the code or the filename of the file which was changed? Any help  
>>> with
>>> this would be greatly appreciated. Thanks!
>>
>> Odds are it is in her HEAD reflog.  You can look for it with
>> `git log -g`.  If you know some part of the commit message you
>> may be able to filter it down with `git log -g --grep=X` or part
>> of the change with `git log -g -SX`.
>
> If it helps, I like viewing the reflog with gitk.  Like this:
> gitk $(git log -g --pretty=format:%H)
>
> Is there a shorter way to do this with gitk?  It would be awesome to
> have `gitk -g` .
>
> -Tarmigan

Unfortunately I can't seem to find it in here. So at this point it  
seems about 99% likely that it was never committed. Does this command  
search across all branches or only the one you have checked out when  
you run the git log command? And, just in case, is there any way to  
search raw objects for text, either commit text, file name or content?  
Thanks very much!

-Sam
