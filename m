From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Commiting changes onto more than one branch
Date: Thu, 26 Nov 2009 00:56:31 +0100
Message-ID: <m2pr76jh00.fsf@igel.home>
References: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
	<76c5b8580911250838x361ae081n271fcee2d1234703@mail.gmail.com>
	<6b4a562b0911250847x59116687iba1d1640ca6c3887@mail.gmail.com>
	<7vaayazb2a.fsf@alter.siamese.dyndns.org>
	<6b4a562b0911251143s63f09f7bwe4b67d6871d8a1b2@mail.gmail.com>
	<alpine.LNX.2.00.0911251752330.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Jarmy <mjarmy@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:56:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRiz-0000xg-9i
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbZKYX4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 18:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbZKYX4a
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:56:30 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:51706 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965013AbZKYX43 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:56:29 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 973C41C159D8;
	Thu, 26 Nov 2009 00:56:33 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 7EDFA904C8;
	Thu, 26 Nov 2009 00:56:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id J+0dRe3T5D4O; Thu, 26 Nov 2009 00:56:32 +0100 (CET)
Received: from igel.home (DSL01.83.171.177.175.ip-pool.NEFkom.net [83.171.177.175])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu, 26 Nov 2009 00:56:32 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id F0AACCA28C; Thu, 26 Nov 2009 00:56:31 +0100 (CET)
X-Yow: Somewhere in suburban Honolulu, an unemployed bellhop is whipping up
 a batch of illegal psilocybin chop suey!!
In-Reply-To: <alpine.LNX.2.00.0911251752330.14365@iabervon.org> (Daniel
	Barkalow's message of "Wed, 25 Nov 2009 18:41:29 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133708>

Daniel Barkalow <barkalow@iabervon.org> writes:

> (The temporary branch is only needed at all so that the developer has
> some way to refer to the fix while merging it, and the name only
> matters in that humans will see it in the merge commit message.)

If you merge by commit-ish the branch name does not even appear in the
commit message.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
