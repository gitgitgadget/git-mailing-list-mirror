From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 6 Jun 2008 10:06:06 +0100
Message-ID: <e2b179460806060206p32a50c6bx16510214c230d517@mail.gmail.com>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
	 <e2b179460806060142y7edc92e4y7cbad6b3cfad1eac@mail.gmail.com>
	 <d45085aa0806060154p58e7e87dk636d519cbdcf2dc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git mailing list" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	mbp@sourcefrog.net
To: "Cedric Vivier" <cedricv@neonux.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 11:07:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4XuY-000829-TJ
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 11:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbYFFJGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 05:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbYFFJGJ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 05:06:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:41231 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbYFFJGI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 05:06:08 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1371689rvb.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8a/b8D1xqTEwt1k5jgAnd0DEayCMFcIDXerFjWgp2f8=;
        b=SmRuq8uOLFC46jKB3hyoGY8EUDIwW3Jkpko79aKO1bfMHEcTsDsTbhxDfUFIvxXb16
         7jc3xdZld9zDT2sq0tAjVishgk4U7HZCo0IyXF5TOy7plOMDIhAGdMyCryTKTpUxSo8E
         tCtBnoTyJ3jrcxEAzvQxQon+SAToyABGR813Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZqD7Ym/Vq2EEsMJwwlm3Ut5vJ89sEI6/rhvruRa7S0U7assInxKcJqNB2LeNmY9GyK
         esnSLj29kymwfk+SZIxT3G188Iyz+F31U8WXiwKej2s8Jdbl6MtNUe6wtmZ7Ph+pKDv5
         9UmZtirs+LzZKclaqTC56q219Iwt5QGkKI270=
Received: by 10.141.51.15 with SMTP id d15mr1570473rvk.106.1212743166106;
        Fri, 06 Jun 2008 02:06:06 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Fri, 6 Jun 2008 02:06:06 -0700 (PDT)
In-Reply-To: <d45085aa0806060154p58e7e87dk636d519cbdcf2dc7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84042>

2008/6/6 Cedric Vivier <cedricv@neonux.com>:
> On Fri, Jun 6, 2008 at 10:42 AM, Mike Ralphson <mike.ralphson@gmail.com> wrote:
>> 2008/6/5 Cedric Vivier <cedricv@neonux.com>:
>>> +  strnatcmp.c -- Perform 'natural order' comparisons of strings in C.
>>> +  Copyright (C) 2000, 2004 by Martin Pool <mbp sourcefrog net>
>>
>> IANAL, but I'm not 100% sure clauses 2a or 3 are strictly GPL
>> compatible (especially as "altered from" is unlikely to be interpreted
>> in only one way).
>>
>> Perhaps we can ask the original author (cc'd) if he is prepared to
>> license it under GPL2?
>>
>
> I've found a discussion on the Apache mailing-list where the author,
> Martin Pool seems to ack that this is ok to include his code in GPL'ed
> code or even to relicense it :
> http://lists.debian.org/debian-glibc/2003/10/msg00016.html
>
> Also maybe we could use glibc's strverscmp instead, but am not sure of
> its portability ?

Ah ok, I didn't recognise the zlib license. A quick google suggests it
is GPL compatible. Sorry for the noise.

Mike
