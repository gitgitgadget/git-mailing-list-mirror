From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC] git-sequencer.txt
Date: Tue, 10 Jun 2008 10:59:55 +0200
Message-ID: <20080610085955.GB5642@leksak.fem-net>
References: <20080607220101.GM31040@leksak.fem-net> <m3d4mqwnxh.fsf@localhost.localdomain> <20080610012159.GI8079@leksak.fem-net> <200806100646.36528.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 11:00:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5zio-0003FK-Dl
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 11:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbYFJI76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 04:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbYFJI76
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 04:59:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:51676 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751461AbYFJI76 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 04:59:58 -0400
Received: (qmail invoked by alias); 10 Jun 2008 08:59:56 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp001) with SMTP; 10 Jun 2008 10:59:56 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+UVRJe2wSUvYm/gY/o4e6c6MbJ5APqQCXFrszKk+
	zIqIYmpBI5WS/Q
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K5zhr-0001vj-Bt; Tue, 10 Jun 2008 10:59:55 +0200
Content-Disposition: inline
In-Reply-To: <200806100646.36528.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84487>

Hi,

> Maybe the sequencer can look at the filename it is passed.
> If it is something like "$GIT_DIR/*/git-rebase--interactive-todo" that can 
> mean it is called by "git rebase --interactive".

It's another variant, but then with every new sequencer-user you have to
add another entry to the "sequencer caller database".

That means: if a user writes a script that uses sequencer he has to make
changes to sequencer itself. Baaad for extensibility.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
