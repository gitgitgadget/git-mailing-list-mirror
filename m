X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Olivier Galibert <galibert@pobox.com>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 19:38:53 +0100
Message-ID: <20061121183853.GA61605@dspnet.fr.eu.org>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org> <slrnem6cpn.6vh.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 18:39:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <slrnem6cpn.6vh.Peter.B.Baumann@xp.machine.xx>
User-Agent: Mutt/1.4.2.2i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32015>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmaWc-0002kE-7d for gcvg-git@gmane.org; Tue, 21 Nov
 2006 19:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031287AbWKUSi4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 13:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031288AbWKUSi4
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 13:38:56 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:21521 "EHLO
 dspnet.fr.eu.org") by vger.kernel.org with ESMTP id S1031287AbWKUSiz (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 13:38:55 -0500
Received: by dspnet.fr.eu.org (Postfix, from userid 1007) id 90EA8A3611; Tue,
 21 Nov 2006 19:38:53 +0100 (CET)
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org

On Tue, Nov 21, 2006 at 06:11:19PM +0100, Peter Baumann wrote:
> And I think handling this behaviour as a config option is the right thing,
> because most of the time if someone imports a project into git he
> will import the whole history, especially if he is using one of the
> cvs/svn importers. A "halfway import" as seen in the kernel repo is a
> special case and it is unlikely seen again.

Not all projects run on a public VCS.  Hell, not all projects run on a
VCS at all.  And in the CVS case, you don't always have enough access
to actually download the repository, which afaik is needed for
importing.

  OG.
