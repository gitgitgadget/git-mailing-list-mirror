From: Lars Damerow <lars@pixar.com>
Subject: Re: GIT_ONE_FILESYSTEM inclusion?
Date: Wed, 24 Mar 2010 06:40:49 -0700
Message-ID: <20100324134048.GB10190@pixar.com>
References: <20100323232055.GV7038@pixar.com> <81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com> <4BA9DCDD.6060109@viscovery.net> <81b0412b1003240437n799bac07sb74db749d647817d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 14:50:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuQyb-0006Gq-4d
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 14:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab0CXNuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 09:50:23 -0400
Received: from emx.pixar.com ([199.108.77.30]:5805 "EHLO emx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755765Ab0CXNuX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 09:50:23 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Mar 2010 09:50:23 EDT
X-PixarMID: 1751869
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.152
X-IronPort-AV: E=Sophos;i="4.51,301,1267430400"; 
   d="scan'208,223";a="1751869"
Received: from helper.dynamic.pixar.com ([138.72.131.152])
  by iris.pixar.com with ESMTP; 24 Mar 2010 06:40:51 -0700
Received: from helper.dynamic.pixar.com (localhost [127.0.0.1])
	by helper.dynamic.pixar.com (8.14.3/8.14.3) with ESMTP id o2ODenat026998;
	Wed, 24 Mar 2010 06:40:49 -0700
Received: (from lars@localhost)
	by helper.dynamic.pixar.com (8.14.3/8.14.3/Submit) id o2ODen52026997;
	Wed, 24 Mar 2010 06:40:49 -0700
Content-Disposition: inline
In-Reply-To: <81b0412b1003240437n799bac07sb74db749d647817d@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143084>

>From Alex Riesen <raa.lkml@gmail.com>, Wed, Mar 24, 2010 at 12:37:39PM +0100:
> 
> Isn't it a little pointless to look for repository when you can't
> access its config?

If you're doing the trendy thing of putting repository information in
your shell prompt, then your prompt is looking for a repository every
time you change a directory.

As for making this a command-line option: that's certainly doable, but
it makes it harder to enforce the option's use across an organization.
It's far easier for me to set an environment variable centrally on a
thousand workstations than to convince a potentially large number of
users to set a new shell alias for git.

thanks,
-lars

--
lars r. damerow :: button pusher :: pixar animation studios
