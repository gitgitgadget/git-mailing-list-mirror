From: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: How to commit incomplete =?UTF-8?Q?changes=3F?=
Date: Thu, 15 Dec 2011 08:11:38 +0100
Message-ID: <7e1ccfac8c47e8877c0438086bd1d91b@ulrik.uio.no>
References: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
 <20111215104444.783303cf@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 08:11:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb5Tk-0001Zv-Jg
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 08:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672Ab1LOHLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 02:11:42 -0500
Received: from mail-out2.uio.no ([129.240.10.58]:52202 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755206Ab1LOHLk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 02:11:40 -0500
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1Rb5Tf-0002cp-7c; Thu, 15 Dec 2011 08:11:39 +0100
Received: from w3prod-wm01.uio.no ([129.240.4.214] helo=webmail.uio.no)
	by mail-mx2.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1Rb5Te-0007Ac-Qp; Thu, 15 Dec 2011 08:11:39 +0100
Received: from c3C3D47C1.dhcp.bluecom.no ([193.71.61.60])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Thu, 15 Dec 2011 08:11:38 +0100
In-Reply-To: <20111215104444.783303cf@ashu.dyn1.rarus.ru>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 2 msgs/h 1 sum rcpts/h 2 sum msgs/h 1 total rcpts 2040 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-2.023,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 5FCC8D1034FB1410B664C5C5920CC9C3111A3CB1
X-UiO-SPAM-Test: remote_host: 129.240.4.214 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 17 total 1944206 max/h 663 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187193>

 On Thu, 15 Dec 2011 10:44:44 +0400, Alexey Shumkin 
 <Alex.Crezoff@gmail.com> wrote:
>> Do people have any feelings or conventions for how and when to
>> publish a series of commits where the first one(s) break something
>> and the next ones clear it up?
>
> I'm curiuos, why to you want to commit changes that break something
> separately from fixup?

 I answered that, but maybe too briefly:

>>  I'm about to commit some small edits which go together with bigger
>>  generated changes.  It seems both more readable and more 
>> cherry-pick-
>>  friendly to me to keep these in separate commits.

 To expand on that: To review the change, review the hand-edited 
 commits,
 which is easier when these do not drown in generated changes.  Review
 the *commands* which generated the rest - I'd put those in the commit
 message - and glance at the actual changes.  Cherry-pick: Possbly you
 need to run the commands instead of cherry-picking the generated
 changes.  That's easier with a commit with only generated changes.

 I know it also can cause problems.  Would you make a single big commit
 anyway, and describe carefully in the commit message which parts are
 hand-edits?  (We don't auto-test commits yet, but I'll sure this issue
 will crop up again later when we do.)

-- 
 Hallvard
