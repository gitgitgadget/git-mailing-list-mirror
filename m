From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 14:01:41 -0400
Message-ID: <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com> <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Stephen Sinclair" <radarsat1@gmail.com>, git@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 20:16:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlpUQ-0005JF-Aa
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 20:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265AbYDOSBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 14:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754896AbYDOSBr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 14:01:47 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35079 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbYDOSBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 14:01:46 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id E07AC1FFC257;
	Tue, 15 Apr 2008 18:01:43 +0000 (UTC)
In-Reply-To: <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79612>


On Apr 15, 2008, at 1:31 PM, Russ Dill wrote:

> The problem is that a branch is just a floating name for a line of
> development. Its not really a "thing" in the repository like a tag or
> a commit. You'd need to make some sort of special tag that describes
> the branch or somesuch.

No special tags needed.  A simple file that I'll call .git/info/ 
ref_names could be a set of lines that have "<ref>\t<description>",  
like the following:

refs/heads/master	Collection point for all my work
refs/heads/ref_names	Add descriptions for branches
refs/heads/segfault	Trying to fix bug #12345

Simple, no tags, new object types or anything.  All you have to do is  
add the bits to git-branch to add, edit, and remove the description  
alongside the branch itself.

Now if you want to propagate these descriptions when you push and  
pull, things get a lot more complicated.

~~ Brian
