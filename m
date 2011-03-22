From: Matt Ryan <matt@devaldez.com>
Subject: Re: [RFD] Gitweb: Source configuration from file separate from the CGI script
Date: Tue, 22 Mar 2011 16:01:20 +0000 (UTC)
Message-ID: <loom.20110322T165315-910@post.gmane.org>
References: <1300285582.28805.25.camel@drew-northup.unet.maine.edu> <20110316143420.GA15371@elie> <1300286650.28805.29.camel@drew-northup.unet.maine.edu> <m3lj0e59ps.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 17:25:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q24OX-0008NN-14
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 17:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268Ab1CVQZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 12:25:15 -0400
Received: from lo.gmane.org ([80.91.229.12]:41459 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824Ab1CVQZG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 12:25:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q24OG-0008Dp-Td
	for git@vger.kernel.org; Tue, 22 Mar 2011 17:25:05 +0100
Received: from cpe-98-14-28-137.nyc.res.rr.com ([98.14.28.137])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 17:25:04 +0100
Received: from matt by cpe-98-14-28-137.nyc.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 17:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 98.14.28.137 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.151 Safari/534.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169746>

Hey, I don't mean to contribute to the confusion. 
But, after adding a gitweb_config.perl in the 
same directory as the cgi I haven't seen all the 
changes take place. I tried something simple to start like so:

$feature{'blame'}{'override'} = [1];
$feature{'forks'}{'default'} = [1];
$feature{'avatar'}{'default'} = ['gravatar'];

Gravtar is now working, but I haven't seen 
the blame or forks added. Any help would be appreciated, 
thanks!
