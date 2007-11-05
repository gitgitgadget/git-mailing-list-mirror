From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] t3502: Disambiguate between file and rev by adding --
Date: Mon, 5 Nov 2007 23:25:30 +0100
Message-ID: <20071105222530.GA4208@steel.home>
References: <20071104153126.GA61398@173.242.249.10.in-addr.arpa>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 23:25:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpAOE-0005mB-CX
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 23:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXKEWZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 17:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752659AbXKEWZg
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 17:25:36 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:24531 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXKEWZf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 17:25:35 -0500
Received: from tigra.home (Facbb.f.strato-dslnet.de [195.4.172.187])
	by post.webmailer.de (klopstock mo20) (RZmta 14.0)
	with ESMTP id z046f7jA5JoHtc ; Mon, 5 Nov 2007 23:25:32 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 18BD3277AE;
	Mon,  5 Nov 2007 23:25:32 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 2877D56D22; Mon,  5 Nov 2007 23:25:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071104153126.GA61398@173.242.249.10.in-addr.arpa>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFz5CxQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63572>

Brian Gernhardt, Sun, Nov 04, 2007 16:31:26 +0100:
> This test failed because git-diff didn't know if it was asking for the
> file "a" or the branch "a".  Adding "--" at the end of the ambiguous
> commands allows the test to finish properly.

To be precise: this is ambiguous only on case-challenged filesystems
