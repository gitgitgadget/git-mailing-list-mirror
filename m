From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: apply color information from git diff
Date: Fri, 22 Oct 2010 00:42:52 +0100
Message-ID: <8739rzf6yr.fsf@fox.patthoyts.tk>
References: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com>
	<87hbgh7paf.fsf@fox.patthoyts.tk>
	<AANLkTimrrxbKSYib7g0O5TXXwt5yDTdkt_bycs69mKT7@mail.gmail.com>
	<87pqv4fqqz.fsf_-_@fox.patthoyts.tk>
	<7vy69stop2.fsf@alter.siamese.dyndns.org>
	<87eibje5zs.fsf_-_@fox.patthoyts.tk>
	<FB63A238-C5FD-4A00-9EAD-E99512C9D38B@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Tor Arvid Lund <torarvid@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Oct 22 01:43:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P94nE-00066W-W3
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 01:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab0JUXnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 19:43:25 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:57197 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751950Ab0JUXnY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 19:43:24 -0400
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P94n2-00062M-H6; Fri, 22 Oct 2010 00:43:20 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P94mb-0006Bi-A5; Fri, 22 Oct 2010 00:42:53 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id DE0C721F45; Fri, 22 Oct 2010 00:42:52 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <FB63A238-C5FD-4A00-9EAD-E99512C9D38B@sb.org> (Kevin Ballard's
	message of "Thu, 21 Oct 2010 13:59:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159591>

Kevin Ballard <kevin@sb.org> writes:

>On Oct 21, 2010, at 8:22 AM, Pat Thoyts wrote:
>
>> +	while {[regexp -indices -start $start "\033\\\[(\\d+)?m" $line match code]} {
>
>Git currently doesn't emit combined escapes (e.g. \e[0;31m to reset and then turn on red text), but I can imagine it being enhanced to do this in the future. I would recommend handling it here if you can.

In fact that can be configured even now:
 % git config color.diff.whitespace "bold white bold cyan"
 % git diff --color | cat.exe --show-all
 ^[[1;37;46m+^[[m$
so thanks for the warning.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
