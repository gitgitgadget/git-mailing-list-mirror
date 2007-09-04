From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git's database structure
Date: Tue, 04 Sep 2007 18:31:57 +0200
Message-ID: <46DD887D.3090508@op5.se>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com> <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:32:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISbJs-0003SA-G3
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbXIDQcA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbXIDQcA
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:32:00 -0400
Received: from mail.op5.se ([193.201.96.20]:40228 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbXIDQcA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:32:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E9FDE194424;
	Tue,  4 Sep 2007 18:31:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FPhJsxJlhxzw; Tue,  4 Sep 2007 18:31:58 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 8CB90194412;
	Tue,  4 Sep 2007 18:31:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57612>

Jon Smirl wrote:
> Another way of looking at the problem,
> 
> Let's build a full-text index for git. You put a string into the index
> and it returns the SHAs of all the file nodes that contain the string.
> How do I recover the path names of these SHAs?
> 

I wouldn't know, but presumably any table can have more than one column.

Is this a problem you face with git so often that it requires a complete
re-design of its very core?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
