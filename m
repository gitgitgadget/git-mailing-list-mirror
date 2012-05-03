From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 18:20:43 +0200
Message-ID: <f66919ac273fd1c90839e5556f126960@ulrik.uio.no>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com>
 <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
 <20120501111415.GD5769@thunk.org>
 <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
 <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com>
 <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com>
 <4FA055D0.7040102@palm.com> <86aa1rmvhb.fsf@red.stonehenge.com>
 <4FA05E9F.9090709@palm.com> <85ff02fc05e4a52ee0b1f1922f774a8d@ulrik.uio.no>
 <947c3d6ae263495985543764a57c3fbb-mfwitten@gmail.com>
 <63c4e1944dcfd03e8c9ff324080ff62f@ulrik.uio.no>
 <e7c7047452954a4b80f5fd436103cb11-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rich Pixley <rich.pixley@palm.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	<git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 18:21:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPylz-0001ia-Qw
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 18:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817Ab2ECQUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 12:20:51 -0400
Received: from mail-out2.uio.no ([129.240.10.58]:42926 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350Ab2ECQUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 12:20:50 -0400
Received: from mail-mx3.uio.no ([129.240.10.44])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SPylo-0005rl-Rz; Thu, 03 May 2012 18:20:44 +0200
Received: from w3prod-wm02.uio.no ([129.240.4.215] helo=webmail.uio.no)
	by mail-mx3.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SPylo-00024x-Dl; Thu, 03 May 2012 18:20:44 +0200
Received: from bombur.uio.no ([129.240.6.233])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Thu, 03 May 2012 18:20:43 +0200
In-Reply-To: <e7c7047452954a4b80f5fd436103cb11-mfwitten@gmail.com>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 16 msgs/h 2 sum rcpts/h 20 sum msgs/h 2 total rcpts 2381 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 95C6EE1B2DFB52C90D6C07222CE41278FF9924E1
X-UiO-SPAM-Test: remote_host: 129.240.4.215 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 43 total 2314215 max/h 641 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196919>

 On Thu, 03 May 2012 16:09:15 -0000, Michael Witten wrote:
> On Thu, 03 May 2012 14:23:59 +0200, Hallvard Furuseth wrote:
>> I mean 'git clone --bare bar.git foo.git' does not give foo.git
>> a remote named 'origin' with a branch origin/master.  Not sure
>> if there is a _simple_ way to do it well either.  init + fetch
>> above does not try to hardlink objects/packs like clone does.
>>
>>> (...)
>>>   $ git init bar.git; cd bar.git
>>>   $ echo a > a; git add a; git commit -m a; cd ..
>>>   $ git clone --bare bar.git foo.git; cd foo.git
>>
>>    $ git branch -a
>>    * master
>
> From `git help clone':
>
>   --bare
>       Make a bare GIT repository. That is, instead of creating
>       <directory> and placing the administrative files in
>       <directory>/.git, make the <directory> itself the $GIT_DIR.
>       This obviously implies the -n because there is nowhere to
>       check out the working tree. Also the branch heads at the
>       remote are copied directly to corresponding local branch
>       heads, without mapping them to refs/remotes/origin/. When
>       this option is used, neither remote-tracking branches nor the
>       related configuration variables are created.

 Yes, I know.  I just don't know why.

-- 
 Hallvard
