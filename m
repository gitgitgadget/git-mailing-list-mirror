From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] add-interactive: shortcut to add hunk and quit
Date: Thu, 19 May 2011 12:16:51 +0200
Message-ID: <201105191216.51709.trast@student.ethz.ch>
References: <20110517071232.GA19396@mrq1.org> <4DD390AF.9020705@drmicha.warpmail.net> <7vr57wc9ja.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>, Pete Harlan <pgit@pcharlan.com>,
	Hermann Gausterer <git-mailinglist@mrq1.org>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 12:17:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN0Hr-0004jz-VJ
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 12:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572Ab1ESKQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 06:16:54 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:13711 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab1ESKQy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 06:16:54 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 19 May
 2011 12:16:44 +0200
Received: from thomas.inf.ethz.ch (213.55.131.180) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 19 May
 2011 12:16:52 +0200
User-Agent: KMail/1.13.7 (Linux/2.6.38.6-28-desktop; KDE/4.6.3; x86_64; ; )
In-Reply-To: <7vr57wc9ja.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.55.131.180]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173946>

Junio C Hamano wrote:
> 
> I think "single-key" was a poorly designed attempt to improve productivity
> the ("y" <RET>)*5 into "y"*5

Actually for me it more often is

  y RET n RET *think* y RET s RET n RET ...

> while sacrificing the safety net when you
> are trying to pick and decide one by one (like the accident Thomas had
> recently during "checkout -p"). If I can say "5y", think for half a second
> to make sure I typed what I meant, and <RET>, to apply 5 upcoming hunks in
> one go, I think I would be as efficient as the productivity optimization
> the single-key offers, while still protecting me from mistakes made by fat
> fingers.

There's nothing stopping us from implementing number prefixes in
single-key mode, since numbers do not have any meaning yet.

After my little accident I'm also considering an (optional?) safety
question at the end when in checkout -p mode, since it's inherently
destructive.  Of course that first requires changing the whole
operation to be atomic.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
