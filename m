From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] diff: add --word-diff option that generalizes --color-words
Date: Mon, 5 Apr 2010 12:20:46 +0200
Message-ID: <201004051220.47400.trast@student.ethz.ch>
References: <cover.1270388195.git.trast@student.ethz.ch> <a1e9ef6a4eb1d7930f69e9ac4b63dc3152ebc98c.1270388195.git.trast@student.ethz.ch> <7v39zay7or.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 12:21:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyjQe-00042K-R7
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 12:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445Ab0DEKUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 06:20:53 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:33462 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929Ab0DEKUv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 06:20:51 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 5 Apr
 2010 12:20:48 +0200
Received: from thomas.localnet (129.132.149.186) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 5 Apr
 2010 12:20:48 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <7v39zay7or.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143975>

Junio C Hamano wrote:
> 
> I think it is a bug that "git show --word-diff" gives the colored format
> output when I have "color.ui" configuration.
> 
> Even though I may have "color.ui = auto" in the configuration, I am
> telling the command to do a --word-diff, not --color-words, from the
> command line, and that should override color.ui settings.

I don't really see why the user would forfeit the convenience and
readability of a color-words diff when the terminal supports colors.
Granted, this is probably the first instance where the colors actually
change the output format instead of just making easier to read, but
still?

But:

> It might be just the matter of defaulting --word-diff without "=<type>"
> not to "auto" but to "plain".  I haven't looked at the code closely yet.

Yes.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
