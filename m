From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: Edit log message after commit
Date: Thu, 29 Sep 2005 00:58:01 -0400
Message-ID: <433B7459.3040307@didntduck.org>
References: <dhfjcu$36f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 06:58:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKqUo-0006jx-3Y
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 06:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVI2E6D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 00:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVI2E6D
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 00:58:03 -0400
Received: from quark.didntduck.org ([69.55.226.66]:2469 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751193AbVI2E6C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 00:58:02 -0400
Received: from [192.168.1.2] (66-227-170-68.dhcp.aldl.mi.charter.com [66.227.170.68])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j8T4vxI07676;
	Thu, 29 Sep 2005 00:57:59 -0400
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
To: Kevin Leung <hysoka@gmail.com>
In-Reply-To: <dhfjcu$36f$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9461>

Kevin Leung wrote:
> Hi,
> 
> Is there any method to edit the log message after committed? I couldn't 
> find any information in Documentation and in git mailing list.

The commit must be at the head, or else you can't change it without 
breaking the chain of following commits.  If you are using Cogito, use 
cg-admin-uncommit and then re-commit it.  Otherwise, create a new commit 
object for the same tree and parent(s) as the old commit, with the new 
message.  The new commit object is your new head.

--
				Brian Gerst
