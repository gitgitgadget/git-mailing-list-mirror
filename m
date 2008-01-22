From: Annard Brouwer <ab_lists@mac.com>
Subject: Re: Using email between 2 developers to keep git repositories in sync
Date: Tue, 22 Jan 2008 23:52:40 +0100
Message-ID: <2D91636D-197A-41C8-8BB3-D5002135BF99@mac.com>
References: <7A02F7D1-9EB0-43AB-96F9-DDD71D4EF5FE@mac.com> <alpine.LNX.1.00.0801221713120.13593@iabervon.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 23:53:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHRzZ-0007IS-B5
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 23:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbYAVWws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 17:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbYAVWwr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 17:52:47 -0500
Received: from smtpoutm.mac.com ([17.148.16.79]:60270 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393AbYAVWwr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 17:52:47 -0500
Received: from mac.com (asmtp005-s [10.150.69.68])
	by smtpoutm.mac.com (Xserve/smtpout016/MantshX 4.0) with ESMTP id m0MMqje9013068;
	Tue, 22 Jan 2008 14:52:45 -0800 (PST)
Received: from [192.168.42.85] ([80.71.54.130])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp005/MantshX 4.0) with ESMTP id m0MMqeh7003178
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 22 Jan 2008 14:52:43 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0801221713120.13593@iabervon.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71476>

Thank you all for your suggestions! The problem is that each of us  
having a local server accessible to the other is not possible.  
Therefore I will follow the path of sending patches by email and on  
releases we can synchronise using bundles. I think that's the best fit  
for our model of developing code semi-independently.

Cheers!
Annard

On 22 Jan 2008, at 23:22, Daniel Barkalow wrote:

> I think bundles or email or both is likely to be the correct  
> solution, but
> you should know that you don't need a shared server if you each have a
> server the other can read from. Each of you sets up a public  
> repository
> with the same basic history, and you each have local clones of your  
> public
> repository, and you pull from the other into your local clone and
> (assuming you want to accept the other's changes) you do the merge and
> push to your own public server.
