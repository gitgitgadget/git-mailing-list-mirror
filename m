From: Kalle Pokki <kalle.pokki@iki.fi>
Subject: Re: Git rescue mission
Date: 09 Feb 2007 21:21:26 +0200
Message-ID: <87tzxvf87d.fsf@host94.eke.fi>
References: <17866.27739.701406.722074@lisa.zopyra.com>
	<Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
	<87fy9gz9vu.fsf@host94.eke.fi>
	<Pine.LNX.4.64.0702081321040.8424@woody.linux-foundation.org>
	<87bqk4z4qw.fsf@host94.eke.fi> <20070208221023.GB1091@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kalle Pokki <kalle.pokki@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 20:21:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFbJa-0008AH-LF
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 20:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992766AbXBITVn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 14:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992768AbXBITVn
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 14:21:43 -0500
Received: from [194.100.36.62] ([194.100.36.62]:51254 "EHLO host94.eke.fi"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S2992766AbXBITVm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 14:21:42 -0500
Received: from host94.eke.fi (localhost.localdomain [127.0.0.1])
	by host94.eke.fi (8.13.4/8.13.4/Debian-3) with ESMTP id l19JLSIP005503;
	Fri, 9 Feb 2007 21:21:28 +0200
Received: (from kp@localhost)
	by host94.eke.fi (8.13.4/8.13.4/Submit) id l19JLQTr005500;
	Fri, 9 Feb 2007 21:21:26 +0200
In-Reply-To: <20070208221023.GB1091@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39190>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> 	git config alias.new "gitk --all --not ORIG_HEAD"
> 
> Would give you a new git subcommand:
> 
> 	git new
> 
> which shows all of the new stuff, on all branches, but doesn't show
> your prior commit history.

Yes, but what I meant was that gitk wouldn't stop at ORIG_HEAD,
but just display it as another branch head with a nice green tag.
Normally, displaying ORIG_HEAD would probably not be interesting,
but it might make sense with

        gitk --all

It would give more context to the pull than just

        gitk ORIG_HEAD..
