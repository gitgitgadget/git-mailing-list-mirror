From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: gitignore - how to ignore only in current directory
Date: Sun, 23 May 2010 21:38:42 +0100
Message-ID: <AANLkTil3gjr8dS7T5DZJOK8m9mQFRtXIy1TsrUkUCtEX@mail.gmail.com>
References: <AANLkTilGH-Z4IpgosqYPFCl3G2XsKDfAT3pH6vi-wuN8@mail.gmail.com>
	 <808w7a4atz.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Sun May 23 22:38:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGHwg-0007GW-PI
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 22:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab0EWUiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 16:38:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48632 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab0EWUio (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 16:38:44 -0400
Received: by fxm5 with SMTP id 5so1971164fxm.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 13:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=cZavbqbw1JP5KdiKtPTi3UwD/ZCIp0ByMCklt62MgUM=;
        b=ckTWjmoXVa0QKlXHo1PRiJablgV8QVHr50NaCYfbMe3ViogGomxk+rYkKuykc/4JhN
         jfKxyFQ0HgcAwQEQ+UoIH4m1lAU/ckL+ZGnDFO1UZXeEvtt97MpG1cxlJj+RywN8wSRK
         /2RUXGht/7Pc5LgxBTn7tqmLDFPYyiIfo7Fdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=D6f4UVYt62SEc9/TnQJgM+Zzo0XN/9RIRThYa+5sYkxcQlKXIctPSLhoVbuLx5PpAp
         LKs451OKg4fZLpXikeiUwjHXc8nfD6nzzINNLRHRqjrsbFnz9m4Nio0GY+ZqoKp92eGI
         mv+9nXUyW+e/4NIzr41g4KhiI9fKynX15v9Wg=
Received: by 10.239.129.206 with SMTP id 14mr401913hbg.146.1274647123106; Sun, 
	23 May 2010 13:38:43 -0700 (PDT)
Received: by 10.239.133.69 with HTTP; Sun, 23 May 2010 13:38:42 -0700 (PDT)
In-Reply-To: <808w7a4atz.fsf@tiny.isode.net>
X-Google-Sender-Auth: 37tzjDmieewvt-nXaS6vhCIltcY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147585>

>> I want to ignore a particular file name in a particular directory.
>> However, the same filename may appear in subdirectories and in those
>> cases I do *not* want it ignored. The documentation seems to imply
>> that git will read up the directories looking for .gitignore files and
>> will ignore files that I need included.
>
> Make the pattern begin with /

Ahh thanks!! Now I know the answer I can see that the docs say that (sort of) :)
