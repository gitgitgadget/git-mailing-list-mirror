From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Added options NO_TCLTK, WITH_P4IMPORT and --with-tcltk/--without-tcltk.
Date: Mon, 26 Mar 2007 14:03:44 +0400
Message-ID: <20070326100344.GV14837@codelabs.ru>
References: <etpuen$2uo$2@sea.gmane.org> <20070326073143.GB44578@codelabs.ru> <20070326073250.GC44578@codelabs.ru> <200703261030.49382.jnareb@gmail.com> <7vmz20xuxq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 12:04:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVm3q-0004Qk-Jm
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 12:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbXCZKD4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 06:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbXCZKD4
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 06:03:56 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:56387 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964844AbXCZKDy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 06:03:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=GhAze4HUvJs74zYKjEC35g9GRoZBMycLg3ipFDJ9JG2mu3BGlArB0JjncLs/ZAbIWGVrd+tfT3eG4OdjrXq08Ctth3ZktkHKyw/zB/oGPR6301+6FzBKDiaFXJu52G8/leKkfP0NAvDLq2B5xhL3bNJbgQE0wjeWZoSMfSBgwoQ=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HVm3J-000Bno-AR; Mon, 26 Mar 2007 14:03:49 +0400
Content-Disposition: inline
In-Reply-To: <7vmz20xuxq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-2.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43143>

Jakub, Junio,

Mon, Mar 26, 2007 at 01:36:49AM -0700, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Thanks a lot for the patch, but...
> >
> > Eygene Ryabinkin wrote:
> >
> >> Internal make option TCLTK was added: it governs the location of
> >> the Tcl/Tk interpreter, so user can specify its own binary location
> >> either with './configure --with-tcltk=/path/to/binary' or
> >> 'TCLTK=/path/to/binary make'.
> >
> > ...shouldn't it be TCLTK_PATH?

Yes, probably is should be TCLTK_PATH.

> Thanks for sanity checking.  That means that the absense of
> tcltk would make it impossible to munge the scripts to point at
> the wish binary, so makes the NO_TCLTK stuff easier to swallow.

Sorry, did not get the point. The TCLTK is initialized to the 'wish'
by 'TCLTK ?= wish', so TCLTK will always be here and initialized
to the wish by-default.
-- 
Eygene
