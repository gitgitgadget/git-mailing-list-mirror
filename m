From: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
Subject: Re: Rebasing local patches
Date: Fri, 13 Mar 2009 08:39:39 +0100
Message-ID: <49BA0DBB.7000700@morey-chaisemartin.com>
References: <49B237E2.3080606@morey-chaisemartin.com> <alpine.DEB.1.00.0903071229220.10279@pacific.mpi-cbg.de>
Reply-To: devel@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 13 08:47:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li27U-0002gM-Fi
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 08:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbZCMHqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 03:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbZCMHqY
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 03:46:24 -0400
Received: from 27.mail-out.ovh.net ([91.121.30.210]:37356 "HELO
	27.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750791AbZCMHqX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 03:46:23 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Mar 2009 03:46:23 EDT
Received: (qmail 6994 invoked by uid 503); 13 Mar 2009 07:46:48 -0000
Received: from gw2.ovh.net (HELO mail426.ha.ovh.net) (213.251.189.202)
  by 27.mail-out.ovh.net with SMTP; 13 Mar 2009 07:46:48 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 13 Mar 2009 07:39:41 -0000
Received: from ensilinx1.imag.fr (HELO ?184.247.3.0?) (devel@morey-chaisemartin.com@195.221.227.189)
  by ns0.ovh.net with SMTP; 13 Mar 2009 07:39:40 -0000
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903071229220.10279@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.95.7
X-Ovh-Tracer-Id: 989666018401505001
X-Ovh-Remote: 195.221.227.189 (ensilinx1.imag.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.500002/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113151>

>> I noticed that when the branch was rebased on the centralized and repo 
>> and origin/our_patches is up-to-date in mine.
>>
>> If I checkout another branch and then ckecout our_branches, I got a 
>> message telling my our_patches and the one from the server have diverged 
>> (or you are two commits behind...).
>>
>> How can you get this info directly without leaving/rejoining your 
>> branch?
> 
> It is also part of "git status"' output.

Is there some option to just get the status of HEAD against tracked branch and not the index status? 
I guess I could do an alias but an option would be nicer ;)

Nicolas
