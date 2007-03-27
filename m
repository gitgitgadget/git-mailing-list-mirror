From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Added options NO_TCLTK, WITH_P4IMPORT and --with-tcltk/--without-tcltk.
Date: Tue, 27 Mar 2007 10:59:40 +0400
Message-ID: <20070327065940.GC51155@codelabs.ru>
References: <etpuen$2uo$2@sea.gmane.org> <20070326073143.GB44578@codelabs.ru> <20070326073250.GC44578@codelabs.ru> <200703261030.49382.jnareb@gmail.com> <7vmz20xuxq.fsf@assigned-by-dhcp.cox.net> <20070326100344.GV14837@codelabs.ru> <7vejnbtjdq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:59:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW5eq-0003ZW-HG
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 08:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965254AbXC0G7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 02:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbXC0G7t
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 02:59:49 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:60821 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965254AbXC0G7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 02:59:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=cNpbhDlD1W9HR7nx2pRI4ikFGxmiI1Eu9/0DDSIqyhtjr4OcDwGz04xAGLWZ4DaVPKDDqocBwhj4BTMFZWLZ8oBRU5bnYhd3+uQJATqZdy2uob+z6jKbfbWeAHHJr5PQa1xlcwj2gaM6adgFnyV0/EGLQ+mlwWd+wD29/HpqbaU=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW5ei-000DL1-Tq; Tue, 27 Mar 2007 10:59:45 +0400
Content-Disposition: inline
In-Reply-To: <7vejnbtjdq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-2.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43237>

Junio, good day.

Mon, Mar 26, 2007 at 09:12:17PM -0700, Junio C Hamano wrote:
> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
> 
> > Mon, Mar 26, 2007 at 01:36:49AM -0700, Junio C Hamano wrote:
> > ...
> >> Thanks for sanity checking.  That means that the absense of
> >> tcltk would make it impossible to munge the scripts to point at
> >> the wish binary, so makes the NO_TCLTK stuff easier to swallow.
> >
> > Sorry, did not get the point. The TCLTK is initialized to the 'wish'
> > by 'TCLTK ?= wish', so TCLTK will always be here and initialized
> > to the wish by-default.
> 
> Earlier I said I did not see a reason for not building wish
> applications on a build system that lack them.  I am stating
> that you could argue that your rewriting the path to wish is a
> good reason (I would say it is half-good, as you can still tell
> the build procedure where wish will be on the deployed system
> without having it on your build system) for not building wish
> applications in a build that lacks wish installation.

OK, so, probably, I should modify the behaviour of the --with-tcltk
and configure to look for the Tcl/Tk interpreter _only_ if
--with-tcltk[=PATH] was given and to leave the things unmodified
in the case of absence of that option. But still, --without-tcltk
will disable Tcl/Tk dependant parts. Will people be happy with such
behaviour?
-- 
Eygene
