From: Woody Wu <narkewoody@gmail.com>
Subject: Re: How to specify remote branch correctly
Date: Mon, 17 Dec 2012 07:02:46 +0000 (UTC)
Message-ID: <slrnkctgqh.mmj.narkewoody@zuhnb712.local.com>
References: <slrnkct0r3.dsp.narkewoody@zuhnb712.local.com>
 <CAH5451=7frqa-YHXubvO=dMK2CvVoWR-VFZ3XCmKouNiQz4gAg@mail.gmail.com>
 <slrnkcta0j.mlu.narkewoody@zuhnb712.local.com>
 <CAH5451kmTW+nO4V4pjSdaqhHAb=RX-tawLo=rJfuPnDRDWeSEA@mail.gmail.com>
 <1355722245-ner-6603@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 08:03:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkUjR-0003Wo-HM
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab2LQHDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:03:03 -0500
Received: from plane.gmane.org ([80.91.229.3]:32961 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab2LQHDC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:03:02 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TkUjI-0003QS-Cn
	for git@vger.kernel.org; Mon, 17 Dec 2012 08:03:12 +0100
Received: from 59.37.26.98 ([59.37.26.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 08:03:12 +0100
Received: from narkewoody by 59.37.26.98 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 08:03:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 59.37.26.98
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211640>

On 2012-12-17, Tomas Carnecky <tomas.carnecky@gmail.com> wrote:
> On Mon, 17 Dec 2012 16:13:08 +1100, Andrew Ardill
> <andrew.ardill@gmail.com> wrote:
>> On 17 December 2012 16:06, Woody Wu <narkewoody@gmail.com> wrote:
>> > 1. git checkout foo.  By this command, I think I am checking out
>> > files in my local branch named foo, and after that I also switch to
>> > the branch. Right?
>> 
>> Correct. Your working directory (files) switch over to whatever your
>> local branch 'foo' points to, and your HEAD is updated to point to
>> your local branch 'foo'. Unless something goes wrong/you have
>> conflicting files/uncommitted changes etc.
>
> 'git checkout foo' has special meaning if a local branch with that
> name doesn't exist but there is a remote branch with that name. In
> that case it's equivalent to: git checkout -t -b foo origin/foo.
> Because that's what people usually want.

I think this is what exactly happened to me in the first time I got the
'foo'.  One new thing to me is the '-t'.  I am not sure wether the '-t'
was used or not in the background.  How do I check the 'upstream'
relationships?  Is there any file under .git recoreded that kind of
information?


-- 
woody
I can't go back to yesterday - because I was a different person then.
