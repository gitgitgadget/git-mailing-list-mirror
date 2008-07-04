From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git sequencer prototype
Date: Fri, 4 Jul 2008 23:00:52 +0200
Message-ID: <20080704210052.GA6984@steel.home>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 04 23:02:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEsPj-0000gQ-T3
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 23:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbYGDVA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 17:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbYGDVA4
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 17:00:56 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:14980 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbYGDVAz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 17:00:55 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20hf6EO7
Received: from tigra.home (Faa5b.f.strato-dslnet.de [195.4.170.91])
	by post.webmailer.de (klopstock mo4) (RZmta 16.47)
	with ESMTP id h02c39k64HNvff ; Fri, 4 Jul 2008 23:00:52 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6F8B1277BD;
	Fri,  4 Jul 2008 23:00:52 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A1D1156D27; Fri,  4 Jul 2008 23:00:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87419>

Stephan Beyer, Tue, Jul 01, 2008 04:38:30 +0200:
> Hi,
> 
> here is the patchset for the git-sequencer prototype, documentation,
> test suite and a first git-am and git-rebase-i migration.
> Indeed, monster patches. ;)

BTW, how about renaming it in something short: git seq. There is
already a seq(1) in GNU coreutils, which does roughly the same (prints
a sequence of numbers), why not reuse the name?
