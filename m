From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Thu, 3 Jul 2008 23:12:30 +0200
Message-ID: <20080703211230.GD6677@leksak.fem-net>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <m3d4lvf70w.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 23:13:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEW7S-0007vf-9r
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 23:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbYGCVMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 17:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753663AbYGCVMf
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 17:12:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:48929 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753681AbYGCVMf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 17:12:35 -0400
Received: (qmail invoked by alias); 03 Jul 2008 21:12:33 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp064) with SMTP; 03 Jul 2008 23:12:33 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18NBldoVKwNNvTnNOO/Z/sgTu0pLSiwcfhvfViKmI
	Y5sYpF7EPqhOE7
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KEW6Q-0006mw-RL; Thu, 03 Jul 2008 23:12:30 +0200
Content-Disposition: inline
In-Reply-To: <m3d4lvf70w.fsf@localhost.localdomain>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87320>

Hi,

first, thanks for the --root idea ;-)

> BTW. what is best way of checking if given revision is parent-less?

I think count the number of parents is quite sane.

In sequencer I have:
	count_parents() {
		git cat-file commit "$1" | sed -n -e '1,/^$/p' | grep -c '^parent'
	}

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
