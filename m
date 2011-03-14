From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 'typechange' in the git-status output
Date: Mon, 14 Mar 2011 14:22:38 -0500
Message-ID: <20110314192238.GA30378@elie>
References: <AANLkTimWR0avW6mBWGa0ArVB8oZUM7nuvc5AYf=wgU-W@mail.gmail.com>
 <AANLkTikkHWFrjmrPMP_poxrkCwE34jqaFDbU1Roouw--@mail.gmail.com>
 <1300129161.13980.4.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Mon Mar 14 20:22:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDLx-0001wJ-2J
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 20:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927Ab1CNTWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 15:22:47 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47766 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab1CNTWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 15:22:46 -0400
Received: by vxi39 with SMTP id 39so4663994vxi.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 12:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1DpKD3vh5eM+V51vSUSnk/LzpDgPquZ50nhQw2igSmg=;
        b=CpxPJU5XtOpY/CgHNI7LI0bL9Q/OG9x2wmzzvsBbocK2yYAU1/jwEfeeKSws7ATYFB
         m+IQdZCHSVabDzLptPbjjdfMuFTCuUhUKef0Bb6e73AELOFiKHsmoMdm+2jbU4apwukH
         aRT3EcRaNdZQ14hHvI3ev6wlL2bY9PJx41wdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ruesioVNwFjCYQtv+fllC7fqG7DCz7noDNBPW49IuaLz4uTEgYxecnLRMh5MXqdMXv
         n1qekT8aRPi+z5/e1HbJIkIqlZ7Gf+a/RTiL3azzoI4n6Rc5wHTyc+Xo1o9xHNN7hVwp
         Jyw+0zPMZcLYosSBb3d0xvibgIndCLxw8it10=
Received: by 10.52.91.231 with SMTP id ch7mr6669572vdb.14.1300130566077;
        Mon, 14 Mar 2011 12:22:46 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id c16sm1745629vdu.31.2011.03.14.12.22.43
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 12:22:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300129161.13980.4.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169009>

Hi,

Drew Northup wrote:

> As has been said more than a few times (and is probably somewhere in the
> docs), if you really want to duplicate a git repo you should probably be
> using git to do it.

FWIW I don't agree with this advice.  "cp -a" works perfectly well and
I think that's a valuable thing.

On the other hand, if you want to _back up_ or sneakernet a git repo,
I agree that "git bundle create /path/to/backup.bundle --all" is
better.

Perhaps the user manual could explain this somewhere.

Hope that helps,
Jonathan
