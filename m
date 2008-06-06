From: "Cedric Vivier" <cedricv@neonux.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 6 Jun 2008 10:54:51 +0200
Message-ID: <d45085aa0806060154p58e7e87dk636d519cbdcf2dc7@mail.gmail.com>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
	 <e2b179460806060142y7edc92e4y7cbad6b3cfad1eac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git mailing list" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	mbp@sourcefrog.net
To: "Mike Ralphson" <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 10:56:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Xjf-000464-4B
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 10:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbYFFIyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 04:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbYFFIyx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 04:54:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:32841 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbYFFIyw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 04:54:52 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1366794rvb.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 01:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=oN0H/wZp3HWXED4mokGLQHx3jc/KobalKy8HdIZbyYM=;
        b=GXw73eTeD1DCp6tMny0nFL5oSkb7gQCczNg/ljKqd1NQIbaEQiVTfQnr1Kl/IH6Ivx
         vONF36dwV8mHDLr+d+28uRfC9io3gDdVYbyvCmik5QsL1pXrpQeZwpwwcKHMVDo5yLXd
         mqn5FVXlekMl1eSzoTdwP6qcZ6N4bqJUlRvHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=Nd95etcIxv3/GcGS6F45yp070YJ0/JKZw35AKeAHZDleqmXY7i77HTBN2YQkDXGj62
         qedXNH5wuhuvjYicwY5knKRF5fcQvCZQGPr8r0K1JGEePr2mucIPrjikotHx/t49/8QK
         Rkz31FxnHJRaWxIirscufZIVCNszyvHjC/VUA=
Received: by 10.115.23.19 with SMTP id a19mr2633039waj.200.1212742491620;
        Fri, 06 Jun 2008 01:54:51 -0700 (PDT)
Received: by 10.115.33.3 with HTTP; Fri, 6 Jun 2008 01:54:51 -0700 (PDT)
In-Reply-To: <e2b179460806060142y7edc92e4y7cbad6b3cfad1eac@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 4e1664156fa766a2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84041>

On Fri, Jun 6, 2008 at 10:42 AM, Mike Ralphson <mike.ralphson@gmail.com> wrote:
> 2008/6/5 Cedric Vivier <cedricv@neonux.com>:
>> +  strnatcmp.c -- Perform 'natural order' comparisons of strings in C.
>> +  Copyright (C) 2000, 2004 by Martin Pool <mbp sourcefrog net>
>
> IANAL, but I'm not 100% sure clauses 2a or 3 are strictly GPL
> compatible (especially as "altered from" is unlikely to be interpreted
> in only one way).
>
> Perhaps we can ask the original author (cc'd) if he is prepared to
> license it under GPL2?
>

I've found a discussion on the Apache mailing-list where the author,
Martin Pool seems to ack that this is ok to include his code in GPL'ed
code or even to relicense it :
http://lists.debian.org/debian-glibc/2003/10/msg00016.html

Also maybe we could use glibc's strverscmp instead, but am not sure of
its portability ?
