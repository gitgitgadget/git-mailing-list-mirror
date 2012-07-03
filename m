From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: [Q] Branch aliases =?UTF-8?Q?=28synonyms=29=3F?=
Date: Tue, 03 Jul 2012 14:36:57 +0200
Message-ID: <2d971099da6c66369be0afb7f8bc19d4@ulrik.uio.no>
References: <1919214.YKUdgul2iY@laclwks004>
 <93cfd6eb9045585728dfe649359a103c@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brian Foster <brian.foster@maxim-ic.com>,
	git mailing list <git@vger.kernel.org>
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Tue Jul 03 14:37:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm2Lt-0002kk-Si
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 14:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533Ab2GCMg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 08:36:59 -0400
Received: from mail-out1.uio.no ([129.240.10.57]:60400 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748Ab2GCMg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 08:36:59 -0400
Received: from mail-mx3.uio.no ([129.240.10.44])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1Sm2Li-0007IH-4h; Tue, 03 Jul 2012 14:36:58 +0200
Received: from w3prod-wm03.uio.no ([129.240.4.40] helo=webmail.uio.no)
	by mail-mx3.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1Sm2Lh-0007Jb-Qi; Tue, 03 Jul 2012 14:36:58 +0200
Received: from bombur.uio.no ([129.240.6.233])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Tue, 03 Jul 2012 14:36:57 +0200
In-Reply-To: <93cfd6eb9045585728dfe649359a103c@ulrik.uio.no>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 5 msgs/h 2 sum rcpts/h 5 sum msgs/h 2 total rcpts 2506 max rcpts/h 20 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, FSL_RCVD_USER=0.001,T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 1A111544D80BB7D17B7E8E6495ABB6C192BA52ED
X-UiO-SPAM-Test: remote_host: 129.240.4.40 spam_score: -49 maxlevel 80 minaction 1 bait 0 mail/h: 122 total 1445393 max/h 475 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200912>

 I wrote:
> Possibly in addition to them using a private symref.  In this
> case, 'git symbolic-ref B refs/heads/A' might work better.

 Whoops, bad idea - git checkout B then gives a detached HEAD.

 Hallvard
