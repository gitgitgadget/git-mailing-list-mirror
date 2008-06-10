From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 16:35:51 -0400
Message-ID: <6dbd4d000806101335y5bb7660cge5bbaf571ebce98e@mail.gmail.com>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
	 <200806102159.02875.jnareb@gmail.com>
	 <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
	 <200806102214.40805.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6AaF-0004Z4-7u
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 22:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbYFJUfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 16:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbYFJUfx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 16:35:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:32858 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbYFJUfx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 16:35:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1906473fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QwRO8FRzdj+Txzr0ZvzxbH/chXwxTKtefIPdlZmqO0w=;
        b=bbOuaxnjdz+QdMXNToQZ+BIBQF/43Z6C+Ij4/VNZwP+taM2NcQ83bUrYmglBAEdLnT
         5UJIeKLLxDtkFssXbqEo3dDE2h6hr9KpbfqSd9oMwMZ6Icml/E8G9ZNYZ4n91wE0clo2
         o+Jot21pcE5o1XeNEH4I/MhwFWcc+SrJcHSfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UiB+KZ9qGQcXtRz8RgvM1g8fb6XsVJIiyr2hK9RK+dkbL2NwVRUUBpRNOblBDXjBaa
         MgZ2AJYoH6KMv4MGMcxqHD6bShVjTbeBbcSTz0kbHmPbS7Lt78sVebbb2scUi3CLNl4m
         zYYdLI7FHBbydxVwsyCyqGSAxpS9LiiQI4oso=
Received: by 10.86.52.6 with SMTP id z6mr6235439fgz.48.1213130151456;
        Tue, 10 Jun 2008 13:35:51 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Tue, 10 Jun 2008 13:35:51 -0700 (PDT)
In-Reply-To: <200806102214.40805.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84546>

On Tue, Jun 10, 2008 at 16:14, Jakub Narebski <jnareb@gmail.com> wrote:
> Please remember that in such clone you _don't_ have grafts info (unless
> you copy it manually), so it is a good test if you correctly rewrote
> history using git-filter-branch.  So take a look at history in your
> clone using gitk or some similar tool.
>
> In the history you mentioned:
>
>    ...---a---*   b---c---d---*   e---...
>           \     /         \     /
>            \-X-/           \---/
>
> you should rewritr from 'a'=='X^' to, and including 'e' (and not only
> from 'd').

So I re-did the filter-branch as:

    git-filter-branch HEAD
28aa69aafc8ae901e588f6d341b3e6d3558c6d26^..163a93df14d246dee91c3a503e6372b8313f337d

Now cloning still works and only shows dangling commits --- no errors!

-- 
                              Denis
