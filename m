From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
	configurable
Date: Mon, 5 May 2008 00:27:08 +0300
Message-ID: <20080504212708.GA5660@mithlond.arda.local>
References: <1209815828-6548-2-git-send-email-pkufranky@gmail.com> <1209815828-6548-3-git-send-email-pkufranky@gmail.com> <1209815828-6548-4-git-send-email-pkufranky@gmail.com> <1209815828-6548-5-git-send-email-pkufranky@gmail.com> <7vy76rtfns.fsf@gitster.siamese.dyndns.org> <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com> <alpine.DEB.1.00.0805041040560.30431@racer> <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com> <7v63ttq0y8.fsf@gitster.siamese.dyndns.org> <m3ve1t6bli.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 23:28:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JslkZ-0002Pd-GX
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 23:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbYEDV1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 17:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbYEDV1P
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 17:27:15 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:32904 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753939AbYEDV1P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 17:27:15 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.0.013.9)
        id 48178931004126D4; Mon, 5 May 2008 00:27:10 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jsljg-00030P-1X; Mon, 05 May 2008 00:27:08 +0300
Content-Disposition: inline
In-Reply-To: <m3ve1t6bli.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81201>

Jakub Narebski wrote (2008-05-04 13:47 -0700):

> Would it be possible instead of in-line word diff, use word coloring
> to enhance traditional diff format?  Something like
> 
>      -/Hello/ world.
>      +/Hi,/ world.
> 
> (We could use bold, or reverse for marking changed fragment, or use
> color only for changed fragment).

That would be helpful too, no doubt. I'm advocating the word diff
because it's extremely useful with human languages. Lines don't have
(usually) any special meaning there so in this context words are the
most useful units.
