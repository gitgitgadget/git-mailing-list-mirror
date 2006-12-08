X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Documentation/git-commit.txt
Date: Fri, 08 Dec 2006 14:45:41 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612081443250.2630@xanadu.home>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
 <4579529F.9030401@Intel.com> <7vfybqi3r1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 8 Dec 2006 19:45:51 +0000 (UTC)
Cc: Salikh Zakirov <Salikh.Zakirov@Intel.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vfybqi3r1.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33729>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GslfF-0002cf-Ot for gcvg-git@gmane.org; Fri, 08 Dec
 2006 20:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761154AbWLHTpm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 14:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426164AbWLHTpm
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 14:45:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:23656 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1761154AbWLHTpm (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 14:45:42 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9Z00I300854170@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Fri,
 08 Dec 2006 14:45:41 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, 8 Dec 2006, Junio C Hamano wrote:

> By the way, I have been wondering if the --only variant of the
> command should also add untracked files to the index.  That is:
> 
> 	$ git commit foo.c '*.h'
> 
> currently barfs if foo.c is not tracked, and/or there is no
> tracked header files.  We could instead run git-update-index
> --add on them.

That would be a good thing indeed.

> Incidentally, this would make this sequence possible:
> 
> 	$ tar xf /var/tmp/foo.tar ;# extract tarball here.
>         $ git init-db
>         $ git commit -m 'initial import' .

... making the UI even more consistent.


