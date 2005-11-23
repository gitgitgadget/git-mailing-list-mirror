From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add git-graft-ripple, a tool for permanently grafting
 history into a tree.
Date: Wed, 23 Nov 2005 08:22:51 +0100
Message-ID: <438418CB.30509@op5.se>
References: <11326926501602-git-send-email-ryan@michonline.com> <Pine.LNX.4.64.0511221652530.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 23 08:23:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eeoy4-000092-PE
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 08:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbVKWHWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 02:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbVKWHWx
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 02:22:53 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:10382 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030338AbVKWHWw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 02:22:52 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id CB43C6BCBE
	for <git@vger.kernel.org>; Wed, 23 Nov 2005 08:22:51 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0511221652530.13959@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12607>

Linus Torvalds wrote:
> 
> On Tue, 22 Nov 2005, Ryan Anderson wrote:
> 
>>Enhancements over the original example:
>>
>>	o Each newly created commit A' references A, and (A^1)' (The first try
>>	referenced A^1 and (A^1)' but not A)
>>
>>	o Support for incrementally rewriting history is present.
> 
> 
> How about the case of having commits that have pointers to other commits 
> in the comments? 
> 
> For example, on the kernel do
> 
> 	gitk 19842d67340e4a8f616552d344e97fc7452aa37a
> 
> and see how gitk highlights the SHA1's in the commit message and makes 
> hyperlinks to the commits they point to..
> 

For reference, gitweb does the same.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
