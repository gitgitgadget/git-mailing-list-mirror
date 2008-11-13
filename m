From: Andreas Ericsson <ae@op5.se>
Subject: Re: git integration with monodevelop
Date: Thu, 13 Nov 2008 08:20:18 +0100
Message-ID: <491BD532.9090200@op5.se>
References: <491AAE6D.8030304@op5.se> <491AF20D.4070600@kde.ru> <491AF768.3010607@op5.se> <491B02FF.2060204@kde.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Evgeniy Ivanov <powerfox@kde.ru>
X-From: git-owner@vger.kernel.org Thu Nov 13 08:22:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0WWY-0008Ta-Q3
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 08:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbYKMHUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 02:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbYKMHUk
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 02:20:40 -0500
Received: from mail.op5.se ([193.201.96.20]:53242 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbYKMHUj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 02:20:39 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DFB731B8006C;
	Thu, 13 Nov 2008 08:14:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.449
X-Spam-Level: 
X-Spam-Status: No, score=-3.449 tagged_above=-10 required=6.6
	tests=[AWL=-0.950, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K79+w4mhhc6T; Thu, 13 Nov 2008 08:14:45 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 8207B1B80005;
	Thu, 13 Nov 2008 08:14:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <491B02FF.2060204@kde.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100856>

Evgeniy Ivanov wrote:
> Andreas Ericsson wrote:
>> Evgeniy Ivanov wrote:
>>> Hi Andreas,
>>> I've developed basic git-support in KDevelop using git's cmd-line
>>> interface. I'm very interested in rewriting it with libgit2, when
>>> libgit2 becomes usable. Can you, please, drop me a line, when you have
>>> some code?
>>>
>> git clone http://www.spearce.org/projects/scm/libgit2/libgit2.git
>>
>> will probably prove beneficial. I'm adding Shawn to Cc as he's the
>> primary libgit2 author. Please follow the git.git guidelines for
>> submitting patches, and please note that there's not much there
>> right now. Adding a wishlist for what you need in terms of UI
>> integration might make it easier to focus on something when it's
>> going slow.
>>
> 
> I can only suggest something like this on top of library (something like
>  common used things):
> http://websvn.kde.org/trunk/KDE/kdevplatform/plugins/git/gitexecutor.h?revision=856589&view=markup
> 
> I Don't think library interface should be much differ from cmd-line's one.

Well, it will be. The git CLI is inconsistent in places but it would be
weird to have libgit2 inherit those inconsistencies.

> For advanced use, QGit's includes can be used (search commit objects,
> etc). QGit has much more features, than my integration. AFAIK Shawn has
> experience in egit

Yes. He wrote it.

> (and maybe even gitk). IMHO the best thing is to
> implement libgit2 in terms of QGit, egit and maybe kdevelop's git
> support.

That would defeat the purpose rather wildly. The idea with libgit2 is
to create a library that the git cli can use, so building it based on
command-line output is a no-go. libgit2 is the attempt to make it right.

> I will help with pleasure (mentored by Shawn), when have some
> time (maybe only in January-February).
> 

Excellent :)

> But this is the same things Shawn has suggested to my mentor and me at
> the beginning of SoC...
>

Oh? I didn't know libgit2 started as a SoC project.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
