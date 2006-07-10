From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: can I get only the list of merges?
Date: Tue, 11 Jul 2006 00:37:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607110035390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060710192622.70c51a81.diegocg@gmail.com> <E1FzzlS-0003JE-9C@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Diego Calleja <diegocg@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 00:37:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G04Nn-0000i1-HH
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 00:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbWGJWhg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 18:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbWGJWhg
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 18:37:36 -0400
Received: from mail.gmx.de ([213.165.64.21]:44524 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965294AbWGJWhf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 18:37:35 -0400
Received: (qmail invoked by alias); 10 Jul 2006 22:37:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 11 Jul 2006 00:37:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FzzlS-0003JE-9C@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23662>

Hi,

On Mon, 10 Jul 2006, Matthias Lederhofer wrote:

> git-rev-list --parents HEAD | \
> grep -E '^([a-z0-9]{40} ){2}[a-z0-9]{40}' | \

Since the output of git-rev-list is well-defined, you could say

	grep  '.{121}'

instead. (Instead of 121, you could take any number between 83 and 122.)

Ciao,
Dscho
