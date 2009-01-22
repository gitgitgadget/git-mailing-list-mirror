From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: how to git a read only directory
Date: Thu, 22 Jan 2009 12:19:41 +0200
Message-ID: <4978483D.6040105@panasas.com>
References: <20090121083354.GG6970@b2j> <4977164B.4020706@panasas.com> <20090121155256.GB6966@b2j> <4977515B.9030807@panasas.com> <20090122100008.GC6936@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Boaz Harrosh <bharrosh@panasas.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 11:21:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPwgS-00027v-I6
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 11:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbZAVKTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 05:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755089AbZAVKTs
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 05:19:48 -0500
Received: from gw-ca.panasas.com ([66.104.249.162]:24625 "EHLO
	laguna.int.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754659AbZAVKTr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 05:19:47 -0500
Received: from daytona.int.panasas.com ([172.17.28.41]) by laguna.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Jan 2009 02:19:44 -0800
Received: from bh-buildlin2.bhalevy.com ([172.17.28.136]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Jan 2009 05:19:43 -0500
User-Agent: Thunderbird/3.0a2 (X11; 2008072418)
In-Reply-To: <20090122100008.GC6936@b2j>
X-OriginalArrivalTime: 22 Jan 2009 10:19:43.0765 (UTC) FILETIME=[F1944450:01C97C7A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106741>

bill lam wrote:
> On Wed, 21 Jan 2009, Boaz Harrosh wrote:
>> [~] $ mkdir gitrepo; cd gitrepo
>> [gitrepo] $ git-init
>> [gitrepo] $ ln -s /etc
>> [gitrepo] $ git-add /etc/fstab
> 

Sorry My mistake, it should be:
[gitrepo] $ git-add etc/fstab

> (I use git ver. 1.6.1, git-xxx is already deprecated)
> I followed your example, and failed in the git add,
> 
> gitrepo$  git add /etc/fstab
> fatal: '/etc/fstab' is outside repository
> 

Sorry it's a typo, sure you must add files relative to
the base directory (one containing the .git/ dir)

Cheers
Boaz
