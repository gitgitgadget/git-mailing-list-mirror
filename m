From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git's database structure
Date: Tue, 04 Sep 2007 18:51:34 +0200
Message-ID: <46DD8D16.9090104@op5.se>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>	 <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>	 <46DD887D.3090508@op5.se> <9e4733910709040947ia32bda4i6e30efb2d7848308@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:07:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISbcr-0000L5-UC
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXIDQvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbXIDQvh
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:51:37 -0400
Received: from mail.op5.se ([193.201.96.20]:40763 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbXIDQvh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:51:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 42E6D194439;
	Tue,  4 Sep 2007 18:51:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gRAzS3dXkQ+5; Tue,  4 Sep 2007 18:51:35 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id BDC68194436;
	Tue,  4 Sep 2007 18:51:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <9e4733910709040947ia32bda4i6e30efb2d7848308@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57616>

Jon Smirl wrote:
> On 9/4/07, Andreas Ericsson <ae@op5.se> wrote:
>> Jon Smirl wrote:
>>> Another way of looking at the problem,
>>>
>>> Let's build a full-text index for git. You put a string into the index
>>> and it returns the SHAs of all the file nodes that contain the string.
>>> How do I recover the path names of these SHAs?
>>>
>> I wouldn't know, but presumably any table can have more than one column.
>>
>> Is this a problem you face with git so often that it requires a complete
>> re-design of its very core?
> 
> That's the whole point. We need to discuss the impact of merging a
> field (path names) with an index (tree nodes) has on future things we
> may want to do with the data stored in git.
> 

Yes, but as nobody seems to know what those future things are, it feels
rather pointless speculating about adding support to git for them. git
is a tool. It's a great one at that, because it was built to solve a
particular problem, which it does an amazing job at.

Other SCM's which had the potential to become amazingly good tools too
drowned somewhere between prototype and product in a sea of intellectual
masturbation, which had little to do with solving real-world problems.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
