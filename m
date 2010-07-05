From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: git repository setup
Date: Tue, 6 Jul 2010 07:50:41 +1000
Message-ID: <SNT124-W43732E3DF417A0FB7E5F3CC4B10@phx.gbl>
References: <29078904.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <adamkurjewicz@yahoo.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 05 23:57:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVter-0003JH-L0
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 23:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877Ab0GEV4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 17:56:52 -0400
Received: from snt0-omc2-s27.snt0.hotmail.com ([65.55.90.102]:60912 "EHLO
	snt0-omc2-s27.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755693Ab0GEV4v convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 17:56:51 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2010 17:56:51 EDT
Received: from SNT124-W43 ([65.55.90.72]) by snt0-omc2-s27.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 5 Jul 2010 14:50:42 -0700
X-Originating-IP: [60.241.190.75]
Importance: Normal
In-Reply-To: <29078904.post@talk.nabble.com>
X-OriginalArrivalTime: 05 Jul 2010 21:50:42.0243 (UTC) FILETIME=[1D47B930:01CB1C8C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150298>


Hi Adam,

I am certain that a more experienced giter will correct me where I err, but I believe that that would only be the case if you put x1 in a single repository.

Will anybody actually need to have the entirety of x1?

The best thing to do would be to create a separate repository for each project, then if needed, create a repository for x1 which has all the other repositories as submodules if you need a single repository containing all the others.

You can enter "git help submodule" for the man page on submodules.

Regards,
Tim

----------------------------------------
> Date: Mon, 5 Jul 2010 12:19:08 -0700
> From: adamkurjewicz@yahoo.com
> To: git@vger.kernel.org
> Subject: git repository setup
>
>
> Hi, my company is looking to move away from cvs and git was one of the
> options. The problem that we have is that our file structure looks like
> follows, each of these directories have hundreds of programs some which
> would be modified by various programming units.
>
> /x1/system/
> /x1/config_apps/
> /x1/drivers/
> /x1/web/apps/
>
> What we were hoping to have was one repository for "x1" and then have
> separate sub repositories for each of the extra areas. So that if there are
> any developers needing to change a sub repository then they could without
> affected the other sub-repositories and without having to have a copy of the
> x1 repository on their systems. From what I have read most of the
> documentation suggests that there be one repository and then it gets cloned
> to a developers repository, this would be a challenge as the storage
> requirements to do this would be rather large.
>
> Would anyone have any suggestions on what to do? or if this would be
> possible?
>
> Thanks,
> Adam
> --
> View this message in context: http://old.nabble.com/git-repository-setup-tp29078904p29078904.html
> Sent from the git mailing list archive at Nabble.com.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 		 	   		  
_________________________________________________________________
New, Used, Demo, Dealer or Private? Find it at CarPoint.com.au
http://clk.atdmt.com/NMN/go/206222968/direct/01/