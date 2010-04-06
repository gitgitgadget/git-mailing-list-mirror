From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] diff: add --word-diff option that generalizes --color-words
Date: Tue, 6 Apr 2010 11:20:03 +0200
Message-ID: <201004061120.04060.trast@student.ethz.ch>
References: <cover.1270388195.git.trast@student.ethz.ch> <201004051220.47400.trast@student.ethz.ch> <7v6345pwjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 11:20:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz4xV-0004I0-R8
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 11:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268Ab0DFJUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 05:20:10 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:1844 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642Ab0DFJUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 05:20:08 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 6 Apr
 2010 11:20:06 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 6 Apr
 2010 11:20:05 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <7v6345pwjw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144121>

Junio C Hamano wrote:
> 
> There is one difference between other uses of colors and color-words, but
> I can imagine that ordinary people may not have even realized nor thought
> about it.
> 
> To people who are somewhat but not completely color-challenged (like
> myself), it still helps to paint hunk headers in a color that is different
> from the body text to make the boundary of each hunk more visible.  Even
> without the perception of exact color/hue, the contrast alone helps in
> that case.

I see now.  My apologies for not thinking of that case!

I'll make a new patch.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
