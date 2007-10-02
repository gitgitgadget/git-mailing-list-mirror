From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Tue, 02 Oct 2007 11:23:39 -0700
Message-ID: <7vwsu5l6j8.fsf@gitster.siamese.dyndns.org>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org>
	<7vejgeqxd1.fsf@gitster.siamese.dyndns.org>
	<87bqbisae6.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0710021045430.28395@racer.site>
	<87641psey8.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0710021841300.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Barry Fishman <barry_fishman@acm.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 02 20:23:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcmPU-0007zh-VO
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 20:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbXJBSXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 14:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbXJBSXs
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 14:23:48 -0400
Received: from rune.pobox.com ([208.210.124.79]:52567 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbXJBSXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 14:23:48 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 3115014037A;
	Tue,  2 Oct 2007 14:24:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A88613FFB5;
	Tue,  2 Oct 2007 14:24:03 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710021841300.28395@racer.site> (Johannes
	Schindelin's message of "Tue, 2 Oct 2007 18:45:40 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59707>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But then I stepped back a little: What is most likely meant when you say 
> "master:blub" and there is no tag/branch of name "blub" on the remote 
> side?  Exactly, you want a branch to be created.

It's not that "exactly" for me.

If your push were "next~27^2:frotz", it becomes even less clear.
It may be that I am pushing out the tip of a topic branch I
usually do not push out, so it would be easier for some specific
person to build on top of.  Or maybe I am marking that place as
a lightweight tag.  They are equally likely.

On the other hand, what the user wants to do with "git push
$elsewhere frob" is reasonably clear.  If frob is locally a
branch, then the branch is pushed out.  If frob is a tag, the
tag is propagated.
