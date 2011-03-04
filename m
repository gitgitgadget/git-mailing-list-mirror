From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 22:20:19 +0000
Message-ID: <4D7165A3.5080308@colin.guthr.ie>
References: <4D70EBC3.3010400@colin.guthr.ie> <7vr5am7p30.fsf@alter.siamese.dyndns.org> <7vei6m7muw.fsf@alter.siamese.dyndns.org> <7v39n27llq.fsf@alter.siamese.dyndns.org> <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com> <7vy64u65ta.fsf@alter.siamese.dyndns.org> <loom.20110304T210337-216@post.gmane.org> <7vtyfi606a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alexander Miseler <alexander@miseler.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 23:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvdMK-0007Gn-Ks
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 23:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660Ab1CDWUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 17:20:23 -0500
Received: from brent.tribalogic.net ([78.86.109.144]:59088 "EHLO
	summit.brent.tribalogic.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932640Ab1CDWUW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 17:20:22 -0500
Received: from localhost (summit.brent.tribalogic.net [127.0.0.1])
	by summit.brent.tribalogic.net (Postfix) with ESMTP id 48943D870B;
	Fri,  4 Mar 2011 22:20:20 +0000 (GMT)
X-Virus-Scanned: amavisd-new at brent.tribalogic.net
Received: from summit.brent.tribalogic.net ([127.0.0.1])
	by localhost (summit.brent.tribalogic.net [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id giX5pRZeh97d; Fri,  4 Mar 2011 22:20:19 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Mageia/3.1.8-1.mga1 (1) Thunderbird/3.1.8
In-Reply-To: <7vtyfi606a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168470>

'Twas brillig, and Junio C Hamano at 04/03/11 21:33 did gyre and gimble:
> In short, Linus and I both know what you are talking about, and we may
> revisit that issue later, but the thing is that it would not be very
> pleasant, and not something that can be done in one sitting during a
> single discussion thread on the list.

As a simple option to avoid that, how about just printing out (by
default) the line offsets if hunks don't apply 100% cleanly? This would
at least alert you to the fact that some fixups were needed.

Just a thought...


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
