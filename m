From: Andreas Ericsson <ae@op5.se>
Subject: Re: You don't exist, Go away! although user.name has been set
Date: Tue, 16 Sep 2008 09:38:31 +0200
Message-ID: <48CF6277.4060807@op5.se>
References: <20080916010529.GB22597@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 09:39:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfVA4-0004lg-AT
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 09:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbYIPHik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 03:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbYIPHik
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 03:38:40 -0400
Received: from mail.op5.se ([193.201.96.20]:60370 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbYIPHij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 03:38:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6A8EF1B80079;
	Tue, 16 Sep 2008 09:28:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oWhlK55ff6M1; Tue, 16 Sep 2008 09:28:19 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.171])
	by mail.op5.se (Postfix) with ESMTP id 67F6F1B80048;
	Tue, 16 Sep 2008 09:28:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080916010529.GB22597@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95984>

Marc Weber wrote:
> Today I was glad. I 've been able to compile git on a maanged server.
> git clone did work as well however running
> git fetch <remote location> caused the line
>       die("You don't exist. Go away!");
> 
> to be executed. (the first one)
> 
> Before examining that I asked at #git and got the tip to set
> user.name and user.email which I did. Then I verified that git
> git var GIT_AUTHOR_IDENT and 
> git var GIT_COMMITTER_IDENT
> both printed some values.
> 
> I still got the failure above.
> I've fixed it for my case by setting
> git_default_name and git_default_email just before the check within the
> ident.c file (line 76)..
> 
> However I want to ask wether I've hit a known problem and wether you
> would appreciate me debggung this issue any further?
> 

I can assure you that people are capable of fetching, pulling and
committing with git. I do it all day long at least.

Can you post your ~/.gitconfig (and/or .git/config) file, please?
In conjunction, I also need to know the exact username you're using
on your system.


> Maybe I should add that I've been running that git from the build
> directory if that matters. The version is 1.6.0 from the official
> mirror site.
> 

If you'd been running 0.99 I'd have been worried. 1.6.0 is pretty
solid.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
