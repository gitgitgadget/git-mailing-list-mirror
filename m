From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCHv4] bash completion: Support "divergence from upstream" messages in __git_ps1
Date: Wed, 16 Jun 2010 21:11:09 +0200
Message-ID: <201006162111.09557.trast@student.ethz.ch>
References: <20100612000002.GA30196@neumann> <4C17F5B3.4070907@pileofstuff.org> <7v7hlyg5nh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 21:11:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOy19-0000L2-Uf
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 21:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758972Ab0FPTLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 15:11:12 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:17118 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457Ab0FPTLM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 15:11:12 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 16 Jun
 2010 21:11:09 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 16 Jun
 2010 21:11:09 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <7v7hlyg5nh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149271>

Junio C Hamano wrote:
> Andrew Sayers <andrew-git@pileofstuff.org> writes:
> > +#       You can
> > +#       override the value of GIT_PS1_SHOWUPSTREAM on a per-repository
> > +#       basis by setting the bash.showUpstream config variable.
> 
> That's totally backwards from it should be, isn't it?
> 
> Usually configuration variables are used to give you the default, and
> you use environment variables to override them.

Not in the bash completion.  The test for the environment variable is
cheap, so you use that to enable the feature and can then use configs
to tweak them at a per-repo level.  There is precedent with
GIT_PS1_SHOWDIRTYSTATE and bash.showDirtyState.

The comment above should state that this override only works if the
environment variable is also enabled, though.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
