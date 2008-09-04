From: Andreas Ericsson <ae@op5.se>
Subject: Re: Issue with GIT server
Date: Thu, 04 Sep 2008 12:41:54 +0200
Message-ID: <48BFBB72.1010403@op5.se>
References: <9B6BEB600FC42B4A9A16868DA97FAFEE1B2ACF@bgsmsx412.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dutta, Ranjan" <ranjan.dutta@intel.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 12:43:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbCIx-0005vA-FT
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 12:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195AbYIDKl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 06:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756120AbYIDKl7
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 06:41:59 -0400
Received: from mail.op5.se ([193.201.96.20]:39841 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756008AbYIDKl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 06:41:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D1F201B80369;
	Thu,  4 Sep 2008 12:47:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.498
X-Spam-Level: 
X-Spam-Status: No, score=-2.498 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eDiflm25uXRu; Thu,  4 Sep 2008 12:47:33 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 073D71B80079;
	Thu,  4 Sep 2008 12:47:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <9B6BEB600FC42B4A9A16868DA97FAFEE1B2ACF@bgsmsx412.gar.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94922>

Dutta, Ranjan wrote:
> Hello,
> 
> I am facing the following issue with GIT server running on Ubuntu 8.04
> using an http interface (apache2)..
> 
> When I try to push code at the GIT client end
> 
> 1. git-add(s)
> 2. git-commit
> 3. sudo git push upload master
> 
> I get this error - 
> 
> error: http-push died with strange error
> error: failed to push some refs to 'http://<usernaM@<server ip
> address>/<git_dir>/'
> 
> Any pointers as to how to debug this further ?
> 

To start with, you needn't use "sudo" to run git push.

Besides that, I'm guessing it's a permission error on the server,
so that the apache user (or whatever user your webserver is running
as) can't write to the files it needs to write to.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
