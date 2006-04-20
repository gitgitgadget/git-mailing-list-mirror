From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Branch metainformation
Date: Thu, 20 Apr 2006 11:37:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604201131240.9099@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e27dqv$u6f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 11:37:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWVbT-0000Tw-VC
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 11:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWDTJhd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 05:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWDTJhc
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 05:37:32 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:34777 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750788AbWDTJhc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 05:37:32 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 229461B0F;
	Thu, 20 Apr 2006 11:37:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 166D21C5D;
	Thu, 20 Apr 2006 11:37:29 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id ED6EA1C06;
	Thu, 20 Apr 2006 11:37:28 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e27dqv$u6f$1@sea.gmane.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18960>

Hi,

On Thu, 20 Apr 2006, Jakub Narebski wrote:

> It seems that ever so often there is question posted on this list on which
> the answer is to add '+' in 'pu' branch 'Pull:' line. I think that it is
> not a good policy to have puller to remember which branches can be
> fast-forwarded, and which needs to be merged. It should be an information
> set and stored by person managing the branch (pullee), as some kind of
> metainformation for the branch (like description and optional signature is
> for tags).
> 
> Perhaps then there would be a place for short, one-line description of the
> branch...

I have an alternative in my private repository: When git-pull/git-fetch 
are called with "-S <nick>", then the current URL is set as URL for that 
shorthand, and the rest is *added* as Pull line.

However, this all depends on my (rejected) patch to move the remotes 
information into the config file.

I have not backported the "-S" feature to the non-config remotes, 
since I 1) do not need it myself, and 2) am wary that it is not that easy 
to ensure data integrity by shell-scripting.

Ciao,
Dscho
