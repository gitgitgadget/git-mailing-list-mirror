From: Andreas Ericsson <ae@op5.se>
Subject: Re: applying and committing patches in a single git command
Date: Tue, 15 Jul 2008 12:00:14 +0200
Message-ID: <487C752E.4090707@op5.se>
References: <ce513bcc0807150150l783e9ff1kd7780dc59f4b5a3d@mail.gmail.com>	 <487C659E.60606@panasas.com> <ce513bcc0807150246g790ca009vc0a76bd6ef0aac9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Boaz Harrosh <bharrosh@panasas.com>, s-beyer@gmx.net,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 12:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIhMI-00034Y-K6
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 12:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbYGOKBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 06:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbYGOKBM
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 06:01:12 -0400
Received: from mail.op5.se ([193.201.96.20]:35823 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289AbYGOKBL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 06:01:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 11AE41B80082;
	Tue, 15 Jul 2008 12:01:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.363
X-Spam-Level: 
X-Spam-Status: No, score=-4.363 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.036, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 34KXwAEDwLGV; Tue, 15 Jul 2008 12:01:12 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.154])
	by mail.op5.se (Postfix) with ESMTP id E38D11B80050;
	Tue, 15 Jul 2008 12:01:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <ce513bcc0807150246g790ca009vc0a76bd6ef0aac9b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88547>

Erez Zilber wrote:
> On Tue, Jul 15, 2008 at 11:53 AM, Boaz Harrosh <bharrosh@panasas.com> wrote:
>> Erez Zilber wrote:
>>> Hi,
>>>
>>> Someone created a patch with git-format-patch and sent it to me. I
>>> would like to apply & commit the patch. If I use git-apply, it only
>>> patches my tree without committing it. Now, I need to copy the commit
>>> log, run git-commit and paste the commit log there. Is there a more
>>> intelligent way to do that?
>>>
>>> Thanks,
>>> Erez
>>>
>> git-am, can take all bunch of them at once
>>
>> Boaz
>>
> 
> Thanks. I have 2 more questions:
> 1. How can I tell git-am to take a patch from an e-mail from a gmail account?

You can't, but you can save your gmail message to disc and pass
the saved file to "git am" (don't use "git-am" over "git am";
we're trying to get away from that old format of typing).

> 2. If I have the actual patch on my machine (not in an e-mail
> message), I guess that I need something else (not git-am). Is there
> anything like that?
> 

git apply patchfile
patch (-p1) < patchfile

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
