From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Creating tracked branches
Date: Thu, 22 Apr 2010 15:47:11 +0200
Message-ID: <m2sk6n7g68.fsf@igel.home>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com>
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
	<y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
	<vpqsk6omppf.fsf@bauges.imag.fr>
	<h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com>
	<86tyr4v12n.fsf@red.stonehenge.com>
	<u2n3abd05a91004211657v3dcdaf40j3608f3d8f59c4c1b@mail.gmail.com>
	<20100422081055.GG3563@machine.or.cz>
	<7vy6gf52d1.fsf@alter.siamese.dyndns.org>
	<20100422114924.GH3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Aghiles <aghilesk@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Apr 22 15:47:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4wkW-0000s2-15
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 15:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab0DVNrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 09:47:16 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45703 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab0DVNrP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 09:47:15 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id E66441C158EC;
	Thu, 22 Apr 2010 15:47:12 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id C131B9028E;
	Thu, 22 Apr 2010 15:47:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id Qu1pBZmMxyM1; Thu, 22 Apr 2010 15:47:11 +0200 (CEST)
Received: from igel.home (ppp-88-217-105-17.dynamic.mnet-online.de [88.217.105.17])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu, 22 Apr 2010 15:47:11 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 8107CCA297; Thu, 22 Apr 2010 15:47:11 +0200 (CEST)
X-Yow: Somewhere in suburban Honolulu, an unemployed bellhop is whipping up
 a batch of illegal psilocybin chop suey!!
In-Reply-To: <20100422114924.GH3563@machine.or.cz> (Petr Baudis's message of
	"Thu, 22 Apr 2010 13:49:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145528>

Petr Baudis <pasky@suse.cz> writes:

> P.S.: The "--track without -b implies branch creation" sentence in
> git-checkout(1) seems to be plain wrong?

$ git branch -r
  origin/HEAD -> origin/master
  origin/html
  origin/maint
  origin/man
  origin/master
  origin/next
  origin/pu
  origin/todo
$ git checkout -t origin/maint
Branch maint set up to track remote branch maint from origin.
Switched to a new branch 'maint'

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
