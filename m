From: Jan Hudec <bulb@ucw.cz>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 26 Nov 2007 07:15:09 +0100
Message-ID: <20071126061509.GA21116@efreet.light.src>
References: <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <20071123103003.GB6754@sigill.intra.peff.net> <Pine.LNX.4.64.0711231319220.27959@racer.site> <20071124113814.GA17861@sigill.intra.peff.net> <alpine.LFD.0.99999.0711241042011.9605@xanadu.home> <7vtznbqx2w.fsf@gitster.siamese.dyndns.org> <20071125215128.GC23820@fieldses.org> <alpine.LFD.0.99999.0711252029020.9605@xanadu.home> <20071126041521.GA21120@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 07:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwXFp-0007lR-U4
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 07:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbXKZGPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 01:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbXKZGPT
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 01:15:19 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:36055 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbXKZGPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 01:15:18 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 820CD572F2;
	Mon, 26 Nov 2007 07:15:16 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id fDZ0NJAR-6Gd; Mon, 26 Nov 2007 07:15:14 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 501C5572BD;
	Mon, 26 Nov 2007 07:15:13 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IwXFN-0005WJ-8p; Mon, 26 Nov 2007 07:15:09 +0100
Content-Disposition: inline
In-Reply-To: <20071126041521.GA21120@fieldses.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66047>

On Mon, Nov 26, 2007 at 04:15:21 +0000, J. Bruce Fields wrote:
> The trick of
> 
> 	tag -d old_base remote/master
> 	git fetch remote
> 	git rebase --onto remote/master old_base my_work
> 
> is something we don't document anywhere.

Do we really need the tag/branch?

git fetch remote
git rebase --onto remote/master remote/master@{1} my_work

And of course the thing is only needed if master has been rewound. Otherwise
just:

git rebase remote/master my_work

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
