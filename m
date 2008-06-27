From: Jon Loeliger <jdl@freescale.com>
Subject: Re: can you push from a bare repository??
Date: Fri, 27 Jun 2008 13:18:41 -0500
Message-ID: <48652F01.4080309@freescale.com>
References: <6844644e0806271058r738e300fxf10f50b4ad29a93c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Doug Reiland <dreiland@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:20:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCIY5-0006Qb-2M
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 20:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757203AbYF0SS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 14:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbYF0SS4
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 14:18:56 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:64945 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbYF0SSz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 14:18:55 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m5RIIpg9011898;
	Fri, 27 Jun 2008 11:18:52 -0700 (MST)
Received: from [10.214.73.148] (mvp-10-214-73-148.am.freescale.net [10.214.73.148])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5RIIo0g024851;
	Fri, 27 Jun 2008 13:18:51 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <6844644e0806271058r738e300fxf10f50b4ad29a93c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86618>

Doug Reiland wrote:
> I have a main repository called main
> I create a bare clone from main call bare_clone
> I create clone from bare_clone called work_repository_1
> 
> I do my work in work_repository_1, commit, and push changes to bare_clone
> 
> How to a push the changes in bare_clone into main??
> 

Go to your main repo and configure up a new remote
using "git remote add' pointing to the bare repo.
Then fetch from that remote!

jdl
