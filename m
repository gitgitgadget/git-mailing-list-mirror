From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 19:51:27 +0200
Message-ID: <87ejg0fcgw.fsf@mid.deneb.enyo.de>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
	<86fy0hvgbh.fsf@blue.stonehenge.com>
	<Pine.LNX.4.62.0710111953460.7441@perkele.intern.softwolves.pp.se>
	<20071011192103.GD2804@steel.home>
	<Pine.LNX.4.62.0710120726470.11771@perkele.intern.softwolves.pp.se>
	<m3y7e8jmbm.fsf@barry_fishman.acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 19:55:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgOfl-0006V3-7E
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 19:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758310AbXJLRvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 13:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758259AbXJLRvb
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 13:51:31 -0400
Received: from mail.enyo.de ([212.9.189.167]:4332 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757424AbXJLRva (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 13:51:30 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1IgOfZ-0005nk-0m
	for git@vger.kernel.org; Fri, 12 Oct 2007 19:51:29 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.68)
	(envelope-from <fw@deneb.enyo.de>)
	id 1IgOfX-0002z9-R4
	for git@vger.kernel.org; Fri, 12 Oct 2007 19:51:27 +0200
In-Reply-To: <m3y7e8jmbm.fsf@barry_fishman.acm.org> (Barry Fishman's message
	of "Fri, 12 Oct 2007 13:05:01 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60701>

* Barry Fishman:

> I changed my editor (Emacs) to convert RCS Ids to timestamps when I
> opened a file for reading.  This would fix old files.  When i wrote out
> files I would update the timestamp before writing them (via emacs's
> timestamp package).  I didn't have to think about it as my RCS Id
> stamped files slowly evolve into my editor stamped ones.  I'm sure I
> could do something similar in VIM, or with a script encapsulating
> another editor.

The downside is that this causes totally unncessary conflicts when
merging.  Maybe a custom merge handler could deal with that, though.
