From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: problem with eGit/jGit install in Eclipse 3.4
Date: Tue, 2 Sep 2008 08:29:31 -0400
Message-ID: <20080902122931.GS6619@jabba.hq.digizenstudio.com>
References: <D1AFAEA7-79A6-4CB8-B1D5-07DB1900B116@thetimmy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 14:30:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaV1v-0004v6-Mc
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 14:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbYIBM3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 08:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYIBM3h
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 08:29:37 -0400
Received: from k2smtpout05-01.prod.mesa1.secureserver.net ([64.202.189.56]:44111
	"HELO k2smtpout05-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751336AbYIBM3h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 08:29:37 -0400
Received: (qmail 26089 invoked from network); 2 Sep 2008 12:29:35 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout05-01.prod.mesa1.secureserver.net (64.202.189.56) with ESMTP; 02 Sep 2008 12:29:35 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 6CAF0100A22
	for <git@vger.kernel.org>; Tue,  2 Sep 2008 12:29:35 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jbaD0T9pS8oB for <git@vger.kernel.org>;
	Tue,  2 Sep 2008 08:29:32 -0400 (EDT)
Received: from jabba.hq.digizenstudio.com (ip70-174-133-176.dc.dc.cox.net [70.174.133.176])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id C00A7100A1B
	for <git@vger.kernel.org>; Tue,  2 Sep 2008 08:29:32 -0400 (EDT)
Received: by jabba.hq.digizenstudio.com (Postfix, from userid 1000)
	id BECF848E9A; Tue,  2 Sep 2008 08:29:31 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <D1AFAEA7-79A6-4CB8-B1D5-07DB1900B116@thetimmy.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94669>

On Tue, Sep 02, 2008 at 12:00:14AM -0700, T Worman wrote:
> When I access Team > Share Project on any of my projects the only option 
> available is CVS. For some reason Git does not show up as an option. 
> Since I have never had any problems installing egit before I have tried 
> everything I know of to troubleshoot. Does anyone here have any ideas why 
> Git is not showing up as an option for sharing in Ganymede?

Try put those jars in $ECLIPSE_ROOT/dropins.  IIUC, they overhauled
the whole plugin provisioning system in Ganymede - not sure for better
or for worse though. :-)

Cheers.
-- 
Jing Xue
