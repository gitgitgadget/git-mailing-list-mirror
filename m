From: Eric Raible <raible@nextest.com>
Subject: Re: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 7 Feb 2011 17:25:31 -0800
Message-ID: <4D509B8B.6090607@nextest.com>
References: <4D4DEDC4.4080708@hartwork.org> <20110206051333.GA3458@sigill.intra.peff.net> <4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr> <7vwrlcv1ea.fsf@alter.siamese.dyndns.org> <20110207055314.GA5511@sigill.intra.peff.net> <7vhbcguytf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 02:30:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmcPm-0000I7-HZ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 02:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab1BHBal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 20:30:41 -0500
Received: from exchange.domain1.nextest.com ([12.96.234.114]:45240 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754671Ab1BHBak (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 20:30:40 -0500
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Feb 2011 20:30:40 EST
Received: from [131.101.20.211] (131.101.20.211) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Mon, 7 Feb 2011 17:26:33 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7vhbcguytf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166327>

On 11:59 AM, Junio C Hamano wrote:

> I actually do not mind too much myself if all commands that can take
> pathspecs consistently defaulted to "full-tree" pathspec given no
> pathspec.  But if we were to go that route, everybody should join their
> voice to defend that decision when outside people say "in 1.8.0 'git grep'
> run from a subdirectory shows matches from all the irrelevant parts of the
> tree; with all the cruft its output is unreadable". I won't be the sole
> champion of such a behaviour when I do not fully believe in it.

IFUC this shouldn't affect any (correctly written) scripts,
and so the only downside is that (when run in a subdir) commands
that are currently spelled:

	git xxx

would with this change need to be spelled:

	git xxx .

One advantage of this approach is that one's fingers would
learn the "only this dir" two char sequence very quickly.

So FWIW, I will do my best to help defend such a decision.
