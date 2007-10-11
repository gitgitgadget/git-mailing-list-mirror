From: Sam Vilain <sam@vilain.net>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 10:35:31 +1300
Message-ID: <470E9723.3090103@vilain.net>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se> <86fy0hvgbh.fsf@blue.stonehenge.com> <20071011155956.GC11693@cs-wsok.swansea.ac.uk> <Pine.LNX.4.64.0710112144380.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Oliver Kullmann <O.Kullmann@swansea.ac.uk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 23:35:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig5h4-000714-Ag
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 23:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780AbXJKVfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 17:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755372AbXJKVfh
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 17:35:37 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:51358 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755141AbXJKVfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 17:35:36 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 3FFD721CFF5; Fri, 12 Oct 2007 10:35:35 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id A3B0321CFD9;
	Fri, 12 Oct 2007 10:35:31 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <Pine.LNX.4.64.0710112144380.4174@racer.site>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60641>

Johannes Schindelin wrote:
> The problem is this: for efficiency, git does not change files which have 
> not changes between the last version checked out (whatever that is) and 
> the current version.
> 
> This seems counterintuitive to people coming from SVN/CVS: they expect 
> _every_ file to be touched when checking out.

Well, that's not entirely true.  SVN for one doesn't change the keywords
on files that haven't changed.  You can't have a keyword that expands to
the current head revision, for instance.

SVN's answer to the problem of how this works with merging is largely
arbitrary; if you are merging changes in, the $Id$ becomes expanded to
the merge that affected that path, not the change that introduced this
version of the file.

Sam.
