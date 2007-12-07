From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: After-the-fact submodule detection or creation
Date: Fri, 7 Dec 2007 08:37:28 +0100
Message-ID: <20071207073728.GA2847@steel.home>
References: <87ir3bp5sf.fsf@graviton.dyn.troilus.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 08:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0XmT-0004IC-Rz
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 08:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbXLGHhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 02:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbXLGHhc
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 02:37:32 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:35654 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbXLGHhb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 02:37:31 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCT5T8Q==
Received: from tigra.home (Fca29.f.strato-dslnet.de [195.4.202.41])
	by post.webmailer.de (mrclete mo19) (RZmta 14.5)
	with ESMTP id C0399cjB73hXAx ; Fri, 7 Dec 2007 08:37:29 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 08FBE277AE;
	Fri,  7 Dec 2007 08:37:29 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 6C48256D22; Fri,  7 Dec 2007 08:37:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87ir3bp5sf.fsf@graviton.dyn.troilus.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67394>

Michael Poole, Fri, Dec 07, 2007 04:01:04 +0100:
> It seems like using the current submodule code would mean that this
> kind of import would need two passes over the foreign repository,
> rather than one if the branch could be created after the parent tree
> is initially imported.  I can live with that -- it is a rather unusual
> case -- but maybe there is a better way.)

Import the core module in a branch all by itself, and merge it in
every support branch?


    Supp1: o-o-o-----o-o-o-o-o-o-o
		    /
    Core:  o-o-o-o-o
		    \
    Supp2: o-o-------o-o-o-o
