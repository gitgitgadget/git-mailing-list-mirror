From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 0/3] log --graph and rev-list --graph
Date: Tue, 6 May 2008 22:03:05 +0300
Message-ID: <20080506190305.GA19819@mithlond.arda.local>
References: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Tue May 06 21:05:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtST8-0000Bb-Ta
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 21:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764196AbYEFTDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 15:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763569AbYEFTDV
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 15:03:21 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:53784 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758735AbYEFTDJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 15:03:09 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.0.013.9)
        id 48178931005D3D86; Tue, 6 May 2008 22:03:06 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JtSRN-00068T-7j; Tue, 06 May 2008 22:03:05 +0300
Content-Disposition: inline
In-Reply-To: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81376>

Adam Simpkins wrote (2008-05-04 03:36 -0700):

> This patch series adds a new --graph option to the log and rev-list
> commands.  This is pretty much the same code that I sent out in early
> April, but updated to work with the log entry termination fixes in the
> latest master branch.

Looks great, with the exception of the defects we already know: (1)
diff(stat) options write their output to the graph area and (2) --follow
shows really weird lines (gitk has the same "feature").

Other than that it seems really solid. Don't know about the code but
from user's point of view:

Tested-by: Teemu Likonen <tlikonen@iki.fi>
