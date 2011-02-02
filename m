From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [1.8.0] git-stash invocation changes
Date: Wed, 2 Feb 2011 19:51:31 +0100
Message-ID: <201102021951.31883.trast@student.ethz.ch>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <AANLkTimu=drR+4v+B_aB+Y4jVqzaBghh1XYSZoACsBry@mail.gmail.com> <vpqtygmwbee.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 02 19:51:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkhnm-0001SN-SG
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 19:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab1BBSvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 13:51:33 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:5137 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754928Ab1BBSvd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 13:51:33 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.270.1; Wed, 2 Feb
 2011 19:51:24 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.270.1; Wed, 2 Feb
 2011 19:51:30 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <vpqtygmwbee.fsf@bauges.imag.fr>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165925>

Matthieu Moy wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > On Wed, Feb 2, 2011 at 09:23, Thomas Rast <trast@student.ethz.ch> wrote:
> >> Proposal:
> >>
> >> 1. Change 'git stash <not-a-stash-command>' to give a usage message
> >>   instead of using <not-a-stash-command> as the stash message.
> >
> > Oh please, yes, please do this.  We should have done this long, long
> > ago.  Its easy enough to train your fingers or fix your scripts to say
> > `git stash save list` rather than `git stash lsit` once stash errors
> > out and gives you a usage message once.
> 
> Err, hasn't this been fixed long ago already?

Oh, you're actually right.  I have totally missed this, and should
obviously have tested first.

Still, I think the change to 'git stash -p' is also worthwhile.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
