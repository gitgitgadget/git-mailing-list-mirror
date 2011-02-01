From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Tue, 1 Feb 2011 23:39:31 +0100
Message-ID: <201102012339.31684.trast@student.ethz.ch>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <201101312244.10047.trast@student.ethz.ch> <4D4875B2.4070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 23:39:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkOsy-000292-Pr
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 23:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414Ab1BAWje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 17:39:34 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:56684 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221Ab1BAWje (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 17:39:34 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 1 Feb
 2011 23:39:25 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 1 Feb
 2011 23:39:32 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <4D4875B2.4070008@gmail.com>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165872>

A Large Angry SCM wrote:
> On 01/31/2011 04:44 PM, Thomas Rast wrote:
> >
> > Since the remote branches in some sense reflect the "last known state"
> > of the remote, it would make sense to also update them to whatever a
> > two-argument fetch got.
> 
> If this is proposing to break:
> 
> 	get-fetch ${REPO} ${SRC_REF}:${DST_REF}
> 
> then I am against this since that form _is_ used and *is* plumbing.

You're mixing up the two proposals.  This one is to teach

  git fetch repo foo

to update refs/remotes/repo/foo with the new value (maybe we should
also have it update in the foo:bar case, but I haven't thought that
through).

The other one is to forbid 'git pull repo foo:bar' and would not
change git-fetch at all.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
