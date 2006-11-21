X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 20:05:30 +0100
Message-ID: <20061121190530.GG7201@pasky.or.cz>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org> <slrnem6cpn.6vh.Peter.B.Baumann@xp.machine.xx> <20061121183853.GA61605@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 19:06:19 +0000 (UTC)
Cc: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061121183853.GA61605@dspnet.fr.eu.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32024>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmawU-0008OU-AO for gcvg-git@gmane.org; Tue, 21 Nov
 2006 20:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031325AbWKUTFe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 14:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031323AbWKUTFd
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 14:05:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:58579 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1031320AbWKUTFc (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 14:05:32 -0500
Received: (qmail 5952 invoked by uid 2001); 21 Nov 2006 20:05:30 +0100
To: Olivier Galibert <galibert@pobox.com>
Sender: git-owner@vger.kernel.org

On Tue, Nov 21, 2006 at 07:38:53PM CET, Olivier Galibert wrote:
> On Tue, Nov 21, 2006 at 06:11:19PM +0100, Peter Baumann wrote:
> > And I think handling this behaviour as a config option is the right thing,
> > because most of the time if someone imports a project into git he
> > will import the whole history, especially if he is using one of the
> > cvs/svn importers. A "halfway import" as seen in the kernel repo is a
> > special case and it is unlikely seen again.
> 
> Not all projects run on a public VCS.  Hell, not all projects run on a
> VCS at all.  And in the CVS case, you don't always have enough access
> to actually download the repository, which afaik is needed for
> importing.

It isn't needed. It's probably much slower over the net but that's how I
created the glibc-cvs.git repository (at repo.or.cz); cvsps can operate
over the network.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
