From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: Newbie grief
Date: Wed, 02 May 2012 16:21:07 +0200
Message-ID: <85ff02fc05e4a52ee0b1f1922f774a8d@ulrik.uio.no>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com>
 <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
 <20120501111415.GD5769@thunk.org>
 <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
 <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com>
 <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com>
 <4FA055D0.7040102@palm.com> <86aa1rmvhb.fsf@red.stonehenge.com>
 <4FA05E9F.9090709@palm.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	<git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Wed May 02 16:35:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPaeU-0000s0-VH
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 16:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782Ab2EBOfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 10:35:30 -0400
Received: from mail-out1.uio.no ([129.240.10.57]:39167 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536Ab2EBOf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 10:35:29 -0400
X-Greylist: delayed 848 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 May 2012 10:35:29 EDT
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SPaQe-0002ap-EG; Wed, 02 May 2012 16:21:16 +0200
Received: from w3prod-wm03.uio.no ([129.240.4.40] helo=webmail.uio.no)
	by mail-mx1.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SPaQe-0004VN-2R; Wed, 02 May 2012 16:21:16 +0200
Received: from bombur.uio.no ([129.240.6.233])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Wed, 02 May 2012 16:21:07 +0200
In-Reply-To: <4FA05E9F.9090709@palm.com>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 6 msgs/h 1 sum rcpts/h 7 sum msgs/h 1 total rcpts 2358 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: F6DFB1C1600724F0157BA48383FF817E39A10597
X-UiO-SPAM-Test: remote_host: 129.240.4.40 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 92 total 1285102 max/h 414 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196827>

 On Tue, 01 May 2012 15:07:27 -0700, Rich Pixley wrote:
> On 5/1/12 14:39 , Randal L. Schwartz wrote:
>> "git fetch" updates the remote tracking branches, which you commonly
>> reference preceded by "origin".  So "git fetch" DOES NOT TOUCH 
>> "master".
>> It touches only "origin/master".
>
> Yes.  I understand that that is how git typically works in a non-bare
> repository.

 And in a bare repository:

     git init --bare foo.git
     cd              foo.git
     git remote add bar ../bar.git
     git fetch      bar
         --> adds bar/master etc.

 For some reason, 'git clone --bare' does not treat the cloned
 repository the same way - it just copies it under refs/heads/
 instead of refs/remotes/, without even adding it as a remote.

-- 
 Hallvard
