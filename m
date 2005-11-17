From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add .git/version
Date: Thu, 17 Nov 2005 17:33:14 +0100
Message-ID: <437CB0CA.6070306@op5.se>
References: <11322339372137-git-send-email-matlads@dsmagic.com> <200511171644.48438.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 17 17:37:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcmhL-0002KP-Np
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 17:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVKQQdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 11:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVKQQdQ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 11:33:16 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:64217 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932395AbVKQQdQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 11:33:16 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id A55706BCBE
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 17:33:14 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <200511171644.48438.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12131>

Josef Weidendorfer wrote:
> On Thursday 17 November 2005 14:25, Martin Atukunda wrote:
> 
> As .git/version is part of the repository, it should contain the version
> of the repository format used. Do you really want to link the version
> of the repository format with the version of git which created the
> repository? It think it is better to detach a repository version from
> version of git.
> 
> Why? Ideally, the git commands first should check if they can handle the
> repository format. If they can not handle the version, they should bail
> out with an error [*]
> Now suppose we want to release Git 2 without change the repository
> format at all. Thus, even if Git 1 tool *would* work with repositories
> created by Git 2, they will fail in the version check!
> 

Not that I have an opinion on these changes, but Netscape 7 still 
handles HTTP 1.1. Just because we up the major-number for git doesn't 
mean we have to do the same for the repository format version.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
