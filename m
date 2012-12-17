From: Woody Wu <narkewoody@gmail.com>
Subject: Re: How to specify remote branch correctly
Date: Mon, 17 Dec 2012 06:48:57 +0000 (UTC)
Message-ID: <slrnkctg0k.mmj.narkewoody@zuhnb712.local.com>
References: <slrnkct0r3.dsp.narkewoody@zuhnb712.local.com>
 <CAH5451=7frqa-YHXubvO=dMK2CvVoWR-VFZ3XCmKouNiQz4gAg@mail.gmail.com>
 <slrnkcta0j.mlu.narkewoody@zuhnb712.local.com>
 <CAH5451kmTW+nO4V4pjSdaqhHAb=RX-tawLo=rJfuPnDRDWeSEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 07:49:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkUW7-0004ob-Ie
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 07:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187Ab2LQGtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 01:49:18 -0500
Received: from plane.gmane.org ([80.91.229.3]:52791 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018Ab2LQGtS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 01:49:18 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TkUW1-0004iR-KL
	for git@vger.kernel.org; Mon, 17 Dec 2012 07:49:29 +0100
Received: from 59.37.26.98 ([59.37.26.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 07:49:29 +0100
Received: from narkewoody by 59.37.26.98 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 07:49:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 59.37.26.98
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211639>

On 2012-12-17, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> On 17 December 2012 16:06, Woody Wu <narkewoody@gmail.com> wrote:
>> 1. git checkout foo.
>> By this command, I think I am checking out files in my local branch
>> named foo, and after that I also switch to the branch. Right?
>
> Correct. Your working directory (files) switch over to whatever your
> local branch 'foo' points to, and your HEAD is updated to point to
> your local branch 'foo'. Unless something goes wrong/you have
> conflicting files/uncommitted changes etc.
>
>> 2. git checkout origin/foo
>> By this command, I am checking out files in remote branch origin/foo,
>> but don't create a local branch, so I am not in any branch now. This is
>> the reason why git tell me that I am in a 'detached HEAD'. Is this
>> understanding right?
>
> Correct! Your working directory is updated, however it doesn't make
> sense for you to make changes to a remote branch, so HEAD is updated
> to be detached.
>
>>>
>>> There are lots of patterns that can emerge from this functionality,
>>> but the main thing to remember is that to create changes on top of a
>>> remote branch, we first need to create a local copy of it. A 'detached
>>> HEAD' here means that we are looking at the remote repository's branch
>>> but don't have a local copy of it, so any changes we make might be
>>> 'lost' (that is, not have an easy to find branch name).
>>>
>>
>> I think here is a little confuse to me.  You mean that a 'detached HEAD'
>> means I don't have a local copy, but I remember that if I run something
>> like:
>>     $ git checkout a-tag-name
>> then I ususally went into 'detached HEAD' but my local files really get
>> switched to those files in the tag 'a-tag-name'.  So what does you mean
>> by 'don't have a local copy'?
>
> I should have been more clear. Here I mean that you don't have a local
> copy of the branch reference. Your working directory is updated to be
> in sync with the remote branch, but you haven't yet copied that remote
> reference to a local branch that you can update with your changes.
>
> Hope that clears it up.
>

Andre, by this in further exaplaination, I think I fully understood.
Thanks a lot!

-- 
woody
I can't go back to yesterday - because I was a different person then.
