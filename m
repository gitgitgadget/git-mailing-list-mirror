From: Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: git log --stat FILE
Date: Sun, 08 Aug 2010 15:33:02 +0200
Message-ID: <yf9ocddut4h.fsf@chiyo.mc.pp.se>
References: <yf9wrs1fili.fsf@chiyo.mc.pp.se>
	<201008081426.21705.jnareb@gmail.com> <yf9bp9ds2mz.fsf@chiyo.mc.pp.se>
	<201008081508.53732.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 15:33:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi602-0001tw-Sa
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 15:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab0HHNdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 09:33:09 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:41260 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab0HHNdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 09:33:08 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 1409FE9BA;
	Sun,  8 Aug 2010 15:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1281274385; bh=nkpQjknPSRouFWl/zgjBuXt9HKjy/osa+jF6DatvO2Y=;
	h=To:Cc:Subject:References:From:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=C87ikGzu9RPSFHMAepYTvd1+QUCXqGqO/EFWm
	SGb2CSFy4+IFHOieaST1z1ivya4fjC7L1cixsZEHrCva6Z9m6UUAoQ8zlMtxs6pRFpb
	bFqg+qK7VaBmTivYQdIAyLxynF6ort0s6kCOho/D44pK2BCNt4Wh6yKHaf4J0oIMJWc
	=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@mc.pp.se>)
	id 1Oi5zr-0005Ch-7t; Sun, 08 Aug 2010 15:33:03 +0200
In-Reply-To: <201008081508.53732.jnareb@gmail.com> (Jakub Narebski's message of "Sun, 8 Aug 2010 15:08:53 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.22 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152909>


Jakub Narebski <jnareb@gmail.com> writes:

> To me (and probably many others), a "diff" is something that describe
> differences between two versions (compares two version).

Jakub, there is no need for you to explain or justify why this is
obvious to you.  I have no problem accepting that at face value.
I'm simply trying to explain why this was not obvious to me, in the
hope of aiding any effort in improving the documentation.  After all,
writing documentation for something you feel is obvious is very
difficult.  But if you feel that the documentation is fine as it is,
that is also your privilege.


> Note that 'GNU diff' (and other "/usr/bin/diff") supports three
> output formats:  ed based, context and unified formats.

Indeed, and all those qualify as "diffs" in my mindset.  I would
however not consider the output of "diff -q" as a true "diff", and
naturally not the output of "diff --version".


  // Marcus
