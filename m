From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v3 1/3] diff: add --word-diff option that generalizes --color-words
Date: Tue, 13 Apr 2010 11:27:52 +0200
Message-ID: <201004131127.52669.trast@student.ethz.ch>
References: <cover.1271077334.git.trast@student.ethz.ch> <09bfc1bfe19d47267167b264ed03a677ce20013f.1271077334.git.trast@student.ethz.ch> <7v8w8sljjr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 11:28:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1cQ0-0000uH-2j
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 11:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606Ab0DMJ2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 05:28:19 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:32211 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428Ab0DMJ2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 05:28:17 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.247.2; Tue, 13 Apr
 2010 11:28:15 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.247.2; Tue, 13 Apr
 2010 11:27:53 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <7v8w8sljjr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144801>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
[...]
> > +	{ DIFF_WORDS_COLOR,
> > +	  {"", "", NULL},
> > +	  {"", "", NULL},
> > +	  {"", "", NULL},
> > +	  "\n"
> > +	}
> > +};
> 
> Beautiful.
> 
> The style might be a bit iffy.  Shouldn't an opening "{", unless closed on
> the same line with a matching "}", stand on its own line?

Perhaps.  OTOH I just noticed I could also drop the NULL (and let the
implicit 0-padding take over) which makes every style fit on a single
line.  That should make it a bit easier to read.

> > +static int fn_out_diff_words_write_helper(FILE *fp,
> > +					  struct diff_words_style_elem st_el,
> 
> Do you need to pass this by value?

No, thanks for catching this.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
