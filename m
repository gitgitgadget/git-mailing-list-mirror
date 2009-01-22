From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [StGit PATCH] Added basic bash completion script for StGit.
Date: Thu, 22 Jan 2009 11:09:03 -0500
Message-ID: <49789A1F.8010203@tedpavlic.com>
References: <1232405879-6188-1-git-send-email-ted@tedpavlic.com> <497509A2.5020101@tedpavlic.com> <49750E4B.3000203@tedpavlic.com> <20090122160350.GA15074@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "catalin.marinas" <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 17:10:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ28X-0000mM-K2
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbZAVQJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 11:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbZAVQJI
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:09:08 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:37322 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752449AbZAVQJH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2009 11:09:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 57EC180D803C;
	Thu, 22 Jan 2009 11:03:08 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uPUgEkF+aga5; Thu, 22 Jan 2009 11:03:08 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 3E45980D8036;
	Thu, 22 Jan 2009 11:03:08 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <20090122160350.GA15074@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106756>

>> I didn't see it because it is generated in the build process. :(
>
> Yeah, sorry about that. I made it that way so it would be kept
> up-to-date automatically (which works quite well, by the way).

The only downside is that it's a little harder to keep track of when the 
completion script changes (e.g., when you have made your own local 
changes). However, the method you use provides very *fast* completion 
(as opposed to git and hg completion, which generate their keywords on 
the fly and thus run relatively slowly).


HOWEVER, please see the threads (which modify the Python that generates 
the script):

	[StGit PATCH 1/2] Modify bash completion to support help, version, and 
copyright.

	[StGit PATCH 2/2] Make bash completion fail to bashdefault before 
default completion.

The former thread could be implemented by making help, version, and 
copyright modules like the rest of the commands, but I think this method 
is fine (and it makes stg help <tab> show fewer entries).

	Thanks --
	Ted


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
