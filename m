From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 01:04:24 +0200
Message-ID: <da7535728c9a0ad2a27e83078492efa0@ulrik.uio.no>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com>
 <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
 <20120501111415.GD5769@thunk.org>
 <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
 <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com>
 <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com>
 <7v62cf8v2d.fsf@alter.siamese.dyndns.org> <4FA054BA.80601@palm.com>
 <86ipgfmw05.fsf@red.stonehenge.com> <4FA05C66.2060608@palm.com>
 <CAMOZ1BuiznhrzEOHe0N+uu=mLEw5wWTQyDpnwG8PuF1f_aNaXw@mail.gmail.com>
 <5ADB8D763B2B4CDA889052A1AA45F089@PhilipOakley>
 <67e635d73b952088917d197cbbd06684@ulrik.uio.no> <4FA2CC88.9000207@palm.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Michael Witten <mfwitten@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	<git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Fri May 04 01:04:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ54o-0000xC-9j
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 01:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758923Ab2ECXEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 19:04:42 -0400
Received: from mail-out1.uio.no ([129.240.10.57]:38104 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757181Ab2ECXEl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 19:04:41 -0400
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SQ54d-0003Pk-A3; Fri, 04 May 2012 01:04:35 +0200
Received: from w3prod-wm03.uio.no ([129.240.4.40] helo=webmail.uio.no)
	by mail-mx2.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SQ54c-0002NB-R2; Fri, 04 May 2012 01:04:35 +0200
Received: from c313D47C1.dhcp.bluecom.no ([193.71.61.49])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Fri, 04 May 2012 01:04:24 +0200
In-Reply-To: <4FA2CC88.9000207@palm.com>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 9 msgs/h 1 sum rcpts/h 13 sum msgs/h 1 total rcpts 2391 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 3A02DDC747446AC186FCE34F0B7F5913F8FF05DA
X-UiO-SPAM-Test: remote_host: 129.240.4.40 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 1290006 max/h 414 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196975>

 On Thu, 03 May 2012 11:20:56 -0700, Rich Pixley <rich.pixley@palm.com> 
 wrote:
> On 5/3/12 09:08 , Hallvard Breien Furuseth wrote:
>>   Aha, now this thread finally makes some sense.  So when Rich
>>   wants a "branch" with several tips, he actually wants several
>>   Git clones (repositories) with the same Git branch checked out -
>>   and some of them with local commits to it.
> Yes.
>>   And these commits can be shared as remote branches between the
>>   clones, which in Hg-speak means that in one particular clone,
>>   Git will "bookmark" the other clones' tips.
> Well, no.  In hg, these are all managed.  So there's no scaling
> issue.  They can all push/pull together, since they are really all
> just one shared branch.  Adding a new repository to the mix is
> trivial.  And either pushes or pulls can be used, or any combo.
>
> With git, I must manually make space for each and every repository,
> manually track which set of changes are where, manually track which
> need to be merged, and manually track which repositories are looking
> at which git branches so that they don't collide, or only collide in
> the current repository and only when I'm prepared to merge them.
> (...)

 If you say so.  I don't know Hg and I'm not about to try to guess
 if you're stuck in another misconception about Git or not, nor
 to re-read this entire thread substituting "clone" for "branch".

 Anyway, I notice you're now giving practical Hg examples to go
 with your Hg vocabulary instead talking Git in Hg vocabulary, so
 hopefully this'll get cleared up.

 Anyway, if you have not done so already: If you show this too with
 a practical Hg example instead of talking Git in a Hg vocabulary,
 maybe someone can help.

-- 
 Hallvard
