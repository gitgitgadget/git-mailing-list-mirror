From: Baz <brian.ewins@gmail.com>
Subject: Re: finding the commit that deleted a file
Date: Thu, 30 Apr 2009 09:25:20 +0100
Message-ID: <2faad3050904300125r6cc6bc1fs6eb0e099dadcbf77@mail.gmail.com>
References: <49F953BC.7070303@melosgmbh.de>
	 <81b0412b0904300041m2ac646cgdaffd4e2dadb9125@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christoph Duelli <duelli@melosgmbh.de>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 10:26:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzRaw-0004Zo-7d
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 10:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618AbZD3IZZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 04:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbZD3IZY
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 04:25:24 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:39910 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbZD3IZW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 04:25:22 -0400
Received: by bwz7 with SMTP id 7so1650821bwz.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 01:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DMJiT55eJqnMgMMSY6JXXP5OLr3uMXF6sfRfAquqMtI=;
        b=A1o2iRVBgmAR1TvkOqll28WIcAcx0pQ658i8Sz/B3krOd0hG84MbU31MqjziFdkXsy
         2c08V72Pt6EN1ydkaagtKAqT5iEdY4owOF1BLFcG8lNAQU88TscVCzQD7lVbobMjyJu6
         KEa7IrODpbPPujamyT92blqQQMwJAYgJXHIrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PxhvfilPKtf5TW9VD5fyMa52YMuJLLpfF55GE1LAYmXILWZdYyFWJ8NxnlC8ljs9mO
         9VNsqgPqQNRwio2olnNl3+jog1xTR1qWWaQnz2honHEq5jlcyu0XzUCM6dbGt9aTYjpS
         X9DoVAQRvSp2qYFRfhgSGYXolqaZIzBcpQkgM=
Received: by 10.223.111.134 with SMTP id s6mr582158fap.60.1241079920688; Thu, 
	30 Apr 2009 01:25:20 -0700 (PDT)
In-Reply-To: <81b0412b0904300041m2ac646cgdaffd4e2dadb9125@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117999>

2009/4/30 Alex Riesen <raa.lkml@gmail.com>:
> 2009/4/30 Christoph Duelli <duelli@melosgmbh.de>:
>> Following scenario:
>> Some file x was deleted (or renamed, but the --follow option does no=
t
>> succeed) some 100 commits ago.
>> Now, I would like to check the 'lost' contents for some reason.
>>
>> Is it possible to find out when a given file (path) was deleted?

=46or completeness, the answer to the first part of the question:

git log --diff-filter=3DD -- the/name/of/deleted/file

>> (And then, with the obtained SHA1, use gitk or some such tool to ins=
pect
>> =C2=A0this file.)
>
> "gitk -- the/name/of/deleted/file" :)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
