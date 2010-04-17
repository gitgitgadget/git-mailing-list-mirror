From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 2/3] gitk: do not parse "  >" context as submodule change
Date: Sat, 17 Apr 2010 14:20:55 +0200
Message-ID: <201004171420.55737.trast@student.ethz.ch>
References: <cover.1271260308.git.trast@student.ethz.ch> <5531510bfb94997f729a894a0b5a3158177a9add.1271260308.git.trast@student.ethz.ch> <20100417063320.GA6681@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Miles Bader <miles@gnu.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Apr 17 14:21:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O371I-0002eV-2i
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 14:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab0DQMVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 08:21:00 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:17317 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab0DQMU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 08:20:59 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 17 Apr
 2010 14:20:57 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 17 Apr
 2010 14:20:56 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100417063320.GA6681@brick.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145142>

Paul Mackerras wrote:
> On Wed, Apr 14, 2010 at 05:59:07PM +0200, Thomas Rast wrote:
> 
> > Since 5c838d2 (gitk: Use the --submodule option for displaying diffs
> > when available, 2009-10-28) gitk erroneously matches "  >" and "  <"
> > at the beginning of a line in the submodule code even if we're in the
> > diff text section and the lines should be treated as context.
> > 
> > Fix by (ab)using the $diffinhdr variable also in the 'Submodule...'
> > case, and move the "  >"/"  <" specific code inside the $diffinhdr
> > test.  The existing code will set $diffinhdr to 0 when it hits a
> > "+++", so that it is always 0 when we can hit a context line.
> 
> Looks good, but there's no Signed-off-by?

Whoops, sorry:

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
