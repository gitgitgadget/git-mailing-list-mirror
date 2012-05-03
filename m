From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 18:08:46 +0200
Message-ID: <67e635d73b952088917d197cbbd06684@ulrik.uio.no>
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
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	Rich Pixley <rich.pixley@palm.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	<git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu May 03 18:09:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPyaa-0000wj-OW
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 18:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab2ECQJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 12:09:03 -0400
Received: from mail-out1.uio.no ([129.240.10.57]:43919 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191Ab2ECQJC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 12:09:02 -0400
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SPyaL-00089L-Vl; Thu, 03 May 2012 18:08:53 +0200
Received: from w3prod-wm01.uio.no ([129.240.4.214] helo=webmail.uio.no)
	by mail-mx1.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SPyaL-0000Uo-JQ; Thu, 03 May 2012 18:08:53 +0200
Received: from bombur.uio.no ([129.240.6.233])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Thu, 03 May 2012 18:08:46 +0200
In-Reply-To: <5ADB8D763B2B4CDA889052A1AA45F089@PhilipOakley>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 9 msgs/h 1 sum rcpts/h 13 sum msgs/h 1 total rcpts 2374 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 3CBE32DF34FEC35E9064DA062F518E20EF01D68D
X-UiO-SPAM-Test: remote_host: 129.240.4.214 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 20 total 2311642 max/h 663 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196917>

 Philip Oakley wrote:
> A bit of browsing found
> http://stevelosh.com/blog/2009/08/a-guide-to-branching-in-mercurial/
> which helped with some of the confusion about the different meanings
> of "branch". It looks like an Hg branch is a Git clone.  Git can be
> hard work until one 'gets' how and why the new DVCS approach works.
> Plus learing the UI.

 Aha, now this thread finally makes some sense.  So when Rich
 wants a "branch" with several tips, he actually wants several
 Git clones (repositories) with the same Git branch checked out -
 and some of them with local commits to it.

 And these commits can be shared as remote branches between the
 clones, which in Hg-speak means that in one particular clone,
 Git will "bookmark" the other clones' tips.

-- 
 Hallvard
