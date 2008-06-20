From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 07:23:54 -0700 (PDT)
Message-ID: <m34p7ombie.fsf@localhost.localdomain>
References: <20080620082034.GA24913@elte.hu> <vpqiqw42vk6.fsf@bauges.imag.fr>
	<20080620135004.GB8135@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Jun 20 16:25:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9hYA-0002CR-DW
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 16:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756736AbYFTOYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 10:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbYFTOYE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 10:24:04 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:53092 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562AbYFTOYC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 10:24:02 -0400
Received: by an-out-0708.google.com with SMTP id d40so290347and.103
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=JY0n+OWD+L/BuggTGQJxvkwNytff/z3rFNkyfrcYbg0=;
        b=mBT9ZDF0dykMZsj2U5lKMuxfq+NxVAxsSBJDo1LP7gIalQwJHha89+hh1vc7M07zDg
         5Mn/0rsyh7tGoRXcPwZSxtcM4GHJex0FPQDLZ1JHIwMAYKxjt7KVe3V19A3hn0XWT1I5
         3EVExMZd0wYbhqNNav8oCzjARBUYPNtBF7Wv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=YcPEt9ekDqvxDBpodQHeE63HXmedS5zF/ZwNpoO/XU0ya7PIx0QeD5pLk1MWyH0NZB
         kcXZ6znsRo9Ez0talhoP/EUHpIWr9W7QrFjV5WJElIFUffXQy9akzcoy/KOwuY7WQiOp
         KFrtBakdc1GFJRcaxPvx86g8QDXC1ckN1+BTU=
Received: by 10.100.166.10 with SMTP id o10mr5603734ane.0.1213971835546;
        Fri, 20 Jun 2008 07:23:55 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.208.51])
        by mx.google.com with ESMTPS id o61sm1486839hsc.17.2008.06.20.07.23.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 07:23:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5KENB88007467;
	Fri, 20 Jun 2008 16:23:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5KEMneT007461;
	Fri, 20 Jun 2008 16:22:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080620135004.GB8135@elte.hu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85650>

Ingo Molnar <mingo@elte.hu> writes:

> * Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> 
> > (BTW, git-foo is being obsoleted in favor of "git foo")
> 
> hm, can Bash be taught to do command completion on 'git rer<tab>', like 
> it is able to do on git-rer<tab> ?

contrib/completion/git-completion.bash in git repository.  

I don't know if there are some ready packages[1] for contrib stuff, and
git-completion.bash doesn't seem to get packaged with git.

[1] RPM packages, because Debian seems to have packaged everything, or
almist everything, in a itty-bitty-tiny package(lets) :-P

You can always use zsh, which has git completion in package... ;-)
 
> 	Ingo

-- 
Jakub Narebski

"My name is Inigo Montoya. You killed my father prepare to die"
                                           (The Princess Bride)
