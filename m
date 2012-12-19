From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Wed, 19 Dec 2012 08:13:21 +0100
Message-ID: <50D16911.10000@viscovery.net>
References: <7v38zb3ux0.fsf@alter.siamese.dyndns.org> <877goht6eu.fsf@pctrast.inf.ethz.ch> <20121217114058.449cbc3c@chalon.bertin.fr> <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com> <m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org> <20121218120058.0c558ba5@chalon.bertin.fr> <50D05BAF.4000200@viscovery.net> <871uentthz.fsf@pctrast.inf.ethz.ch> <20121218144157.00ccd915@chalon.bertin.fr> <20121218162402.GA20122@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <dirson@bertin.fr>, Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 08:13:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlDqd-0006BC-UR
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 08:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713Ab2LSHNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 02:13:30 -0500
Received: from so.liwest.at ([212.33.55.24]:13476 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427Ab2LSHN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 02:13:28 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TlDqE-0002fi-4Q; Wed, 19 Dec 2012 08:13:22 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BAE3E1660F;
	Wed, 19 Dec 2012 08:13:21 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121218162402.GA20122@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211811>

Am 12/18/2012 17:24, schrieb Jeff King:
> I am not really interested in pushing this forward myself, but I worked
> up this toy that somebody might find interesting (you can "git replace
> HEAD~20" to get dumped in an editor). It should probably handle trees,
> and it would probably make sense to do per-object-type sanity checks
> (e.g., call verify_tag on tags).

I know it's just a throw-away patch, but I would discourage to go this
route without also adding all the sanity checks. Otherwise, it will have
just created a porcelain command that can generate a commit object with
any content you want!

-- Hannes
