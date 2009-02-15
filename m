From: david@lang.hm
Subject: Re: [RFC - draft] List of proposed future changes that are backward
 incompatible
Date: Sun, 15 Feb 2009 15:53:50 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 23:50:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpoe-0002xP-8P
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 23:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbZBOWs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 17:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbZBOWs4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 17:48:56 -0500
Received: from mail.lang.hm ([64.81.33.126]:42683 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755433AbZBOWsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 17:48:55 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n1FMmqS7019153;
	Sun, 15 Feb 2009 14:48:52 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110077>

On Sun, 15 Feb 2009, Junio C Hamano wrote:

> Thanks.
>
> * git-push to update the checked out branch will be refused by default
>
>  Make "git push" into a repository to update the branch that is checked
>  out fail by default.
>
>  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

If I understand this one, it will cause grief for quite a few people.

I have a public repository that I push to and then have a trigger that 
checks out the current version, compiles it, publishes the compiled 
version, sends an announcement, etc

if I am understanding the purpose of this change, you would prohibit the 
update from taking place.

the message in the thread that you link to discusses how you want to be 
careful about the change, but I have to hunt around through the rest of 
the thread to figure out what the change really means (and I'm not sure I 
really figured it out)

> * git-send-email won't make deep threads by default
>
>  Many people said that by default when sending more than 2 patches the
>  threading git-send-email makes by default is hard to read, and they
>  prefer the default be one cover letter and each patch as a direct
>  follow-up to the cover letter.
>
>  http://article.gmane.org/gmane.comp.version-control.git/109790

I have mixed feelings about this one, if some messages get delayed in 
transit the deep threads still keeps them in order, while the 2-layer 
option doesn't.

that being said, I don't think it's that significant to change the 
default.

one thing that would help new users is if there was a way to create a git 
config file that explicitly listed all the defaults. either as a sample 
config, or to expand the existing config file with all the defaults 
listed, but commented out.

I find that having such a config file helps me find config options I never 
thought to look for.

David Lang
