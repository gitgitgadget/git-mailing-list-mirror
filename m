From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: .git inside a .git: is it safe?
Date: Mon, 12 Mar 2007 18:15:40 -0400
Message-ID: <20070312221540.GA16545@spearce.org>
References: <8b65902a0703121456s56008088ra14452ef7f325cf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 23:15:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQso0-0000rl-Az
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 23:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbXCLWPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 18:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932798AbXCLWPp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 18:15:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57112 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697AbXCLWPo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 18:15:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQsnl-0002bH-00; Mon, 12 Mar 2007 18:15:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 221F020FBAE; Mon, 12 Mar 2007 18:15:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <8b65902a0703121456s56008088ra14452ef7f325cf3@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42084>

Guilhem Bonnefille <guilhem.bonnefille@gmail.com> wrote:
> But, I recently discover that everything seems fine if I include the
> Git repo of mainproject inside the Git repo of my project. The layout
> lloks like this:
> myproject
> |- .git
> |- sub
>  |- tree
>    |- mainproject
>      |- .git
> 
> 
> It seems to work. But do you think such layout is "safe" ?

Yes, that's fine.  You just probably want an entry in the top level
project (myproject) that says ignore the stuff under mainproject.
That way "git add ." in myproject doesn't include files in
mainproject by accident.

-- 
Shawn.
