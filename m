From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Git rebase failure: .dotest overwritten
Date: Tue, 15 Jul 2008 23:48:45 +0200
Message-ID: <487D1B3D.70500@lsrfire.ath.cx>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jul 15 23:49:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIsP9-0002hl-E1
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 23:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762214AbYGOVst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 17:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762188AbYGOVst
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 17:48:49 -0400
Received: from india601.server4you.de ([85.25.151.105]:56966 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762072AbYGOVss (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 17:48:48 -0400
Received: from [10.0.1.200] (p57B7DE67.dip.t-dialin.net [87.183.222.103])
	by india601.server4you.de (Postfix) with ESMTPSA id 724DA2F8070;
	Tue, 15 Jul 2008 23:48:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080715212211.GL6244@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88600>

Stephan Beyer schrieb:
> git-rebase (without -i/-m) generates a directory called ".dotest/" to
> save temporary stuff like the commits you want to rebase.

In February it was discussed to move .dotest below $GIT_DIR.  There was
even a patch (to rename it to .git-dotest).  I suspect the upcoming
version 1.6.0 is a good opportunity to finally remove this wart.

Ren=E9
