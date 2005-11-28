From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into
 .git/config
Date: Mon, 28 Nov 2005 14:11:59 +0100
Message-ID: <438B021F.5030204@op5.se>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de> <7vfyph1ebq.fsf@assigned-by-dhcp.cox.net> <438AC32E.5010100@op5.se> <200511281359.04741.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 14:12:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eginf-0001FG-Gf
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 14:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVK1NME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 08:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVK1NME
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 08:12:04 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:30890 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932087AbVK1NMC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 08:12:02 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 4480C6BCBE; Mon, 28 Nov 2005 14:12:00 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511281359.04741.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12876>

Josef Weidendorfer wrote:
> 
> To allow for this, git_config() should not be hardcoded to only
> read .git/config, but perhaps a list of files in environment variable
> GIT_CONFIG_FILES.
> 

$HOME/.gitrc:$GIT_DIR/conf/*

All files could support the freestanding "include" syntax.

> For (2), git-clone should copy some files, e.g. the .git/project.conf
> or .git/info/exclude. But project config probably should be kept
> up to date among all repositories for a project, i.e. it should be
> version controlled itself, but independent from the project.
> We could use a project config head .git/refs/projectconfig for this;
> of course post-1.0 material.


It would be very nifty to have some files that can hold maintainer-like 
variables (like upstream email address for patches).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
