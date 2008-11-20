From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 14:12:03 +0100
Message-ID: <49256223.1090206@op5.se>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <C33ABF98-2E52-4928-BF79-CB3B6A8460DB@feinheit.ch> <49252204.2070906@op5.se> <20081120112051.GB22787@ravenclaw.codelibre.net> <49255CBA.4030709@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Kestenholz <mk@feinheit.ch>, git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 14:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L39Lw-0008B3-Tt
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbYKTNMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbYKTNMe
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:12:34 -0500
Received: from mail.op5.se ([193.201.96.20]:49631 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbYKTNMd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:12:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6F1DA1B8005E;
	Thu, 20 Nov 2008 14:07:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KjoZX54W52ed; Thu, 20 Nov 2008 14:07:07 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 3E47424B000B;
	Thu, 20 Nov 2008 14:07:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <49255CBA.4030709@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101423>

Andreas Ericsson wrote:
> Roger Leigh wrote:
>> For this, and some other uses I have in mind for git, it would be
>> great if git could store some more components of the inode
>> metadata in the tree, such as:
>> - mtime
>> - user
>> - group
>> - full permissions
>> - and also allow storage of the full range of file types (i.e.
>>   block, character, pipe, etc.)
>>
>> This would allow git to be used as the basis for a complete
>> functional versioned filesystem (which I'd like to use for my
>> lightweight virtualisation tool, schroot, which currently
>> uses LVM snapshots for this purpose).
>>
> 
> I believe someone else has done some work along the way of
> turning git into complete-with-metadata backupsystem before.
> Google might prove beneficial.
> 

Although now that I come to think of it, storing "user" and
"group" made it near-enough totally useless for anything a
user had created as the repos hardly ever could be shared.

I'll say it again; Hooks can be written to handle this.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
