From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC] Support for arbitrary tags in commits
Date: Tue, 11 Jan 2011 14:53:08 +0100
Message-ID: <201101111453.08178.trast@student.ethz.ch>
References: <74b0628dffbd2bc0adabe5e8b0a10960.squirrel@webmail.hitco.org> <201101111340.50508.trast@student.ethz.ch> <edec2e42a531b00ffd6a2689095460d5.squirrel@webmail.hitco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Philipp Marek <philipp@marek.priv.at>
X-From: git-owner@vger.kernel.org Tue Jan 11 14:53:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcef0-0006pE-9C
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 14:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075Ab1AKNxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 08:53:10 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:17225 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540Ab1AKNxK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 08:53:10 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 11 Jan
 2011 14:53:06 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 11 Jan
 2011 14:53:08 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <edec2e42a531b00ffd6a2689095460d5.squirrel@webmail.hitco.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164945>

Philipp Marek wrote:
> > In particular, in what way do notes (as in git-notes(1)) fail to solve
> > your problem?
> Well, my biggest concerns are that users might trash them, and that they are
> voided by amend, rebase etc. (which I tried to address by collecting header
> lines).

They aren't lost any more (since 1.7.1) if you properly configure
notes.rewriteRef.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
