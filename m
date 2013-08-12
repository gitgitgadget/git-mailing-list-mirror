From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Mon, 12 Aug 2013 19:04:30 +0200
Message-ID: <877gfqkfhd.fsf@igel.home>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
	<7veh9z1gym.fsf@alter.siamese.dyndns.org>
	<CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
	<CA+CP9O7--HXQdZXH9MJEh0VqdwpYqb052KYrvZqYhbfajpPG0A@mail.gmail.com>
	<CACsJy8A-aSjNdSkiBUBSH43G_FBMnShfpkcwQqM9-6d41rfCUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Jeske <davidj@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 19:04:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8vXy-0004wy-2d
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 19:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756947Ab3HLREl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 13:04:41 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:44561 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725Ab3HLREl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 13:04:41 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cDNhJ02tBz3hhkV;
	Mon, 12 Aug 2013 19:04:32 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cDNhH6z5VzbbjN;
	Mon, 12 Aug 2013 19:04:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id HqueK7-GFCP7; Mon, 12 Aug 2013 19:04:30 +0200 (CEST)
X-Auth-Info: h+S5ULoL1kd1wRVTg3D70rniUC0gUJk6MaPIx16Oimg=
Received: from igel.home (ppp-88-217-119-29.dynamic.mnet-online.de [88.217.119.29])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 12 Aug 2013 19:04:30 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 4B4F52C017A; Mon, 12 Aug 2013 19:04:30 +0200 (CEST)
X-Yow: Is it 1974?  What's for SUPPER?  Can I spend my COLLEGE FUND in
 one wild afternoon??
In-Reply-To: <CACsJy8A-aSjNdSkiBUBSH43G_FBMnShfpkcwQqM9-6d41rfCUA@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 12 Aug 2013 20:23:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232197>

Duy Nguyen <pclouds@gmail.com> writes:

> That would annoy me as I often work on top of detached HEAD on purpose
> and only create a branch when I want to save something. If the warning
> is to be moved, it should warn at the next checkout.

$ git checkout master
Warning: you are leaving 1 commit behind, not connected to
any of your branches:

  0e3618e a

Switched to branch 'master'

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
