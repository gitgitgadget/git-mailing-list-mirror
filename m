From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-cvsimport: Add -A <author-conv-file> option
Date: Fri, 13 Jan 2006 03:14:27 +0100
Message-ID: <43C70D03.4040609@op5.se>
References: <20060112233859.3438F5BED0@nox.op5.se> <7vvewohoy0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 13 03:14:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExESg-0007O1-9N
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 03:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbWAMCO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 21:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWAMCO3
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 21:14:29 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:4525 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932641AbWAMCO2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 21:14:28 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id C1DA96BCFE
	for <git@vger.kernel.org>; Fri, 13 Jan 2006 03:14:27 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vvewohoy0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14599>

Junio C Hamano wrote:
> ISTR there was a thread that suggested using CVSROOT/users file
> for this purpose.
> 
> 	http://thread.gmane.org/gmane.comp.version-control.git/8167
> 

ISTR?

That patch doesn't work when importing from sourceforge (among others), 
because no-one uses their devname@users.sourceforge.net address (and 
often just filter them out because they attract so much spam). It also 
does nothing for when the username isn't the leading part of the 
email-addres, or for GIT_AUTHOR_NAME, which is the most disturbing since 
it ruffles the shortlog output. We use that shortlog to get a gisted 
changelog for the sales and marketing people. I can recommend this. 
They're absolutely thrilled to see things like "Only use vararg macros 
#ifdef __GNUC__" and "declare **envp const throughout mplex api". ;)

Anyways, I can keep this separate if you don't want to accept it. I'll 
most likely implement some config-reading to it too though so I don't 
have to type the repository name and such each time I run it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
