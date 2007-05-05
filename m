From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: Git branch bug
Date: Sat, 5 May 2007 19:44:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705051942550.14963@bianca.dialin.t-online.de>
References: <Pine.LNX.4.64.0705051823300.13988@bianca.dialin.t-online.de>
 <Pine.LNX.4.64.0705051841200.4015@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 05 19:44:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkOJM-0006qM-2h
	for gcvg-git@gmane.org; Sat, 05 May 2007 19:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934135AbXEERop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 13:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934136AbXEERop
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 13:44:45 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57226 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934135AbXEERoo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2007 13:44:44 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id D1AA621EAA3;
	Sat,  5 May 2007 13:45:07 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sat, 05 May 2007 13:44:44 -0400
X-Sasl-enc: woxHgEwBQt7hT/j5StWkbOApjyF27inT99qLT2XqoNxS 1178387084
Received: from [192.168.2.101] (p549a01cd.dip0.t-ipconnect.de [84.154.1.205])
	by mail.messagingengine.com (Postfix) with ESMTP id 0509A17C8E;
	Sat,  5 May 2007 13:44:43 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0705051841200.4015@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46273>

> On Sat, 5 May 2007, Guido Ostkamp wrote:
>
>> $ mkdir test
>> $ cd test
>> $ git init
>> Initialized empty Git repository in .git/
>> $ git branch experimental
>> fatal: Not a valid object name: 'master'.
>>
>> So, it seems it is not possible to create a named branch on an empty
>> repository.
>
> Actually, it is not possible to branch from a non-existing branch. So,
> this is somewhat expected from my POV.

>From a git beginners point of view, I would expect that the 'master' 
branch is automatically created when performing the 'git init'. Why is 
this not the case?

Regards

Guido
