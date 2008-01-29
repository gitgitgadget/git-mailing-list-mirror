From: =?UTF-8?B?TmFneSBCYWzDoXpz?= <js@iksz.hu>
Subject: Re: [PATCH] Added sub get_owner_file which checks if there's a file
 with project owner name
Date: Tue, 29 Jan 2008 21:53:46 +0100
Message-ID: <479F925A.5020401@iksz.hu>
References: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br> <m3lk6898kg.fsf@localhost.localdomain> <20080129142550.GA25312@c3sl.ufpr.br> <200801291628.21026.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 22:01:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJxa3-0006BV-LU
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 22:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbYA2VAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 16:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYA2VAr
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 16:00:47 -0500
Received: from smtp.aranyoroszlan.hu ([195.56.77.57]:64400 "EHLO
	smtp.aranyoroszlan.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYA2VAq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 16:00:46 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2008 16:00:46 EST
Received: (qmail 66372 invoked by uid 263); 29 Jan 2008 21:00:23 -0000
Received: from 213.178.104.146 (js@iksz.hu@213.178.104.146) by tcb.aranyoroszlan.hu (envelope-from <js@iksz.hu>, uid 256) with qmail-scanner-2.01st 
 (clamdscan: 0.88/1510. spamassassin: 3.1.0. perlscan: 2.01st.  
 Clear:RC:0(213.178.104.146):SA:0(-1.6/5.0):. 
 Processed in 2.299856 secs); 29 Jan 2008 21:00:23 -0000
X-Spam-Status: No, hits=-1.6 required=5.0
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on tcb.aranyoroszlan.hu
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
	RDNS_NONE autolearn=no version=3.2.4
X-Envelope-From: js@iksz.hu
Received: from unknown (HELO ?192.168.1.100?) (js@iksz.hu@213.178.104.146)
  by smtp.aranyoroszlan.hu with SMTP; 29 Jan 2008 21:00:20 -0000
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <200801291628.21026.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71994>

Hi,

Jakub Narebski wrote:
> But I think if IO matters it is better to generate projects list; you
> can even use gitweb for that, or you can simply add a line with URL
> escaped project name (project path) relative to $projectroot, separated
> by space from the URL escaped (URI-encoded) project owner.  See also
> "Gitweb repositories" section in gitweb/INSTALL.  Adding projects is
> rare event.
>   
Are you talking about I/O of an all-in CGI script?  We can tune the 
performance of this script, but changing the GIT_DIR structure just 
because of a simple script is a bit overkill to me.

What if this script creates the $projects_list file, for example when 
the $projectroot's mtime changes?  We can even hold mtime info for every 
project's config file.

Regards:
-- 
Balazs Nagy
