From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Mon, 7 Apr 2008 11:56:53 +0300
Message-ID: <20080407085653.GB5413@mithlond.arda.local>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net> <alpine.DEB.1.00.0804062135290.12583@eeepc-johanness> <20080406224724.GC5822@adamsimpkins.net> <200804070824.10764.tlikonen@iki.fi> <20080407083412.GA9764@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 10:57:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JinAa-0007z5-7K
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 10:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151AbYDGI45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 04:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755270AbYDGI44
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 04:56:56 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:63673 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755132AbYDGI44 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2008 04:56:56 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout3-sn1.fre.skanova.net (7.3.129)
        id 47A7885700379A90; Mon, 7 Apr 2008 10:56:54 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jin9p-0003so-IM; Mon, 07 Apr 2008 11:56:53 +0300
Mail-Followup-To: Adam Simpkins <adam@adamsimpkins.net>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20080407083412.GA9764@adamsimpkins.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78966>

Adam Simpkins kirjoitti (7.4.2008 klo 1.34):

> The nicest way to fix this would probably be to write new diff API
> functions that output to a strbuf instead of printing directly to
> stdout.  Then the log code could prefix each line of the buffer with
> the graph info before printing it.
> 
> However, this would be a lot of work, and I'm not sure that it's
> really worth the effort at the moment.  For now, I'm leaning towards
> changing the code to just exit with an error if --graph is used with
> any of these options.
> 
> Any opinions?  Alternative suggestions?

Ok, then I'd suggest that it's left as is. The --graph may be useful
with some stat options even when the graph area is parially broken by
some other output.
