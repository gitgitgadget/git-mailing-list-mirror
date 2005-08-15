From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Add --signoff and --verify option to git commit.
Date: Mon, 15 Aug 2005 23:21:16 +0200
Message-ID: <200508152321.17075.Josef.Weidendorfer@gmx.de>
References: <7vzmrmp5kw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 15 23:23:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4mPs-0005CV-Ci
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 23:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVHOVWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 17:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVHOVWh
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 17:22:37 -0400
Received: from pop.gmx.de ([213.165.64.20]:39808 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964973AbVHOVWg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 17:22:36 -0400
Received: (qmail invoked by alias); 15 Aug 2005 21:22:35 -0000
Received: from p5496B7BE.dip0.t-ipconnect.de (EHLO linux) [84.150.183.190]
  by mail.gmx.net (mp001) with SMTP; 15 Aug 2005 23:22:35 +0200
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vzmrmp5kw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Saturday 13 August 2005 11:08, Junio C Hamano wrote:
> Also add --verify to make sure the lines you introduced are
> clean, which is more useful in commit but not very much in
> format-patch as it was originally implemented, because finding
> botches at format-patch time is too late.

I think that verification of/commenting on commits at/before commit time is a 
perfect place for another hook script (or collection of verification 
scripts).

People probably want to check a new commit on identation/coding style on a 
per-project manner. The hook also should be able to give warnings/hints by 
adding text to the commit message (e.g. "please do not use 'fgetc'" / 
"doublecheck quoting in system()", ...) without rejecting the commit as a 
whole. It could even be allowed to edit the code before commit.

These verification scripts should be used per default, and git-commit should 
have an option to force bypassing verification.

If I get some time, I can come up with a patch.

Josef
