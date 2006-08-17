From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] introduce inline is_same_sha1
Date: Thu, 17 Aug 2006 13:59:02 +0200
Message-ID: <81b0412b0608170459if099fcane9d9e91a3fdac9e6@mail.gmail.com>
References: <Pine.LNX.4.63.0608161721020.11465@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 13:59:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDgWk-0006zG-MJ
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 13:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWHQL7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 07:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWHQL7F
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 07:59:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:36986 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750939AbWHQL7E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 07:59:04 -0400
Received: by nf-out-0910.google.com with SMTP id o25so952459nfa
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 04:59:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iup062d16ujAn+PFj5JIev7Fc2jRXM5eZEnt+AtBc74LRydeldi+doAFeQfnn97gjPMV8KE8I/NZcsZaequ/DCyGWlkJdPZj/CLrtWe05ASlV2/PEh+RBzWMWiaCttyKQUXQEEoCu7GU1njYB8eb2NvzT7M/EfC4ZDpOlJYo7eE=
Received: by 10.49.93.13 with SMTP id v13mr2129046nfl;
        Thu, 17 Aug 2006 04:59:02 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Thu, 17 Aug 2006 04:59:02 -0700 (PDT)
To: "David Rientjes" <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608161721020.11465@chino.corp.google.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25583>

On 8/17/06, David Rientjes <rientjes@google.com> wrote:
> Introduces global inline:
>         is_same_sha1(const unsigned char *sha1,
>                      const unsigned char *sha2);

It is longer and negates all (like in "lots") previous callsites of memcmp.
Are sure you didn't do a trivial typo somewhere?

Why not just sha1cmp? And if you're aiming at hash-type independence,
why not hashcmp?
