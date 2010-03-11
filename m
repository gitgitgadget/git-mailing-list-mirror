From: Markus Duft <markus.duft@salomon.at>
Subject: Re: git interix support
Date: Thu, 11 Mar 2010 08:13:57 +0100
Organization: Salomon Automation GmbH
Message-ID: <4B989835.2010805@salomon.at>
References: <4B962456.20600@salomon.at> <alpine.LNX.2.00.1003101319350.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Mar 11 08:15:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npcc8-000569-0h
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 08:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880Ab0CKHPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 02:15:18 -0500
Received: from smtp.salomon.at ([193.186.16.13]:54897 "EHLO sauxb.salomon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752732Ab0CKHPR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 02:15:17 -0500
Received: from servex01.wamas.com (servex01.salomon.at [172.28.2.2])
	by sauxb.salomon.at (8.12.10/8.12.10) with ESMTP id o2B7FBaI000388;
	Thu, 11 Mar 2010 08:15:12 +0100 (MET)
Received: from [172.28.8.166] ([172.28.8.166]) by servex01.wamas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Mar 2010 08:15:11 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.8) Gecko/20100308 Lightning/1.0b2pre Thunderbird/3.0.3
In-Reply-To: <alpine.LNX.2.00.1003101319350.14365@iabervon.org>
X-Enigmail-Version: 1.0.1
X-OriginalArrivalTime: 11 Mar 2010 07:15:11.0343 (UTC) FILETIME=[96817FF0:01CAC0EA]
X-Scanned-By: MIMEDefang 2.54 on 172.28.2.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141937>

On 03/10/10 19:32, Daniel Barkalow wrote:
> On Tue, 9 Mar 2010, Markus Duft wrote:
> 
[snip]
> 
> If you've got programs that don't work at all without some library 
> function that you don't have, it's better to not build them at all (by not 
> having them in the make targets) than build binaries that refuse to run. 
> Doing it that way means you don't need to get the rest of the file to 
> compile, and makes it more clear before runtime what functionality will be 
> missing.
> 
> Also, if you make a NO_POLL and use that, someone else might make a 
> compat_poll(). Or maybe not, but a workaround certainly won't get done if 
> you just use __INTERIX.

thanks for the input (all of you). i will spend some more time, doing a
better patch... :)

markus

> 
> 	-Daniel
> *This .sig left intentionally blank*
