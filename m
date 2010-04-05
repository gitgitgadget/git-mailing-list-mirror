From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 0/2] gitk --color-words
Date: Mon, 5 Apr 2010 12:21:37 +0200
Message-ID: <201004051221.37965.trast@student.ethz.ch>
References: <cover.1269996525.git.trast@student.ethz.ch> <cover.1270317502.git.trast@student.ethz.ch> <20100405064018.GA4471@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Apr 05 12:21:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyjRC-0005as-AB
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 12:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab0DEKVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 06:21:42 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:26909 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab0DEKVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 06:21:41 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 5 Apr
 2010 12:21:41 +0200
Received: from thomas.localnet (129.132.149.186) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 5 Apr
 2010 12:21:39 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100405064018.GA4471@brick.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143976>

Paul Mackerras wrote:
> On Sat, Apr 03, 2010 at 08:06:18PM +0200, Thomas Rast wrote:
> 
> > I wasn't really sure about the last point -- this makes things a bit
> > complicated since Paul will have to apply 2/2, and Junio will have to
> > take care to only pull from Paul once 1/2 is in.
> 
> You mean that the patch will mean that gitk will break if the
> underlying git isn't new enough?  I have been careful to avoid that
> sort of dependency as far as possible.  Have a look at how this is
> handled for the --textconv and --submodule options in [getblobdiffs]
> and do something similar for --color-words, please.

Ok, I'll look into that.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
