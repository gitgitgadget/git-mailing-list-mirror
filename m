From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Some issues with current qgit on exit ( aka "Crash this!" )
Date: Sat, 9 Sep 2006 10:16:22 +0200
Message-ID: <e5bfff550609090116waa5d4a1y7de1132fd82f08cf@mail.gmail.com>
References: <e5bfff550609081603s2fb1be98gdafb91681a4aeaae@mail.gmail.com>
	 <1157757903.9088.14.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 10:17:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLy1s-0003cS-4r
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 10:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWIIIQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 04:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWIIIQX
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 04:16:23 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:22278 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932348AbWIIIQW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 04:16:22 -0400
Received: by py-out-1112.google.com with SMTP id n25so1192150pyg
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 01:16:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eYY5nFvefghPwQvXa+qiXULFIBDaE1/ElDqnGa4TIFTjvLIiUny9UYNTacfcJcBUKZKlyAf9qV8Cg+82R4roixee95UjOAKeuPoz4GCetU/HUhji6BV1aPhWalmc+dyHCK6p0k9GwhPPR1KIXsoaCxSkhwOOL6C4gImtIlCSNXc=
Received: by 10.35.33.15 with SMTP id l15mr4501843pyj;
        Sat, 09 Sep 2006 01:16:22 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 9 Sep 2006 01:16:22 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1157757903.9088.14.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26736>

>
> However, qgit has produced some output you may find interesting:
>
> [proski@dv qgit]$ qgit
> ASSERT in lookupAnnotation: no annotation for src/git_startup.cpp
> ASSERT in lookupAnnotation: no annotation for src/fileview.cpp
> ASSERT in lookupAnnotation: no annotation for src/git.cpp
> ASSERT in lookupAnnotation: no annotation for src/mainbase.ui
> [proski@dv qgit]$
>

It was a little regression from recent changes. Luckily much more easy
then previous one.
Logic fixed and patch pushed.

Thanks
Marco
