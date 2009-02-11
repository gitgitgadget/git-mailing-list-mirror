From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Disable filemode rebase tests in t3400-rebase.sh if no 
	filesystem mode support
Date: Wed, 11 Feb 2009 11:53:16 +0100
Message-ID: <81b0412b0902110253g2288419eha4037f22f6286ea4@mail.gmail.com>
References: <81b0412b0902110151x35fbbb4esb9efefae2e1fe90a@mail.gmail.com>
	 <4992A3DF.4010707@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 11:54:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXCjt-0006S7-95
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 11:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbZBKKxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 05:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754386AbZBKKxS
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 05:53:18 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:31299 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbZBKKxR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 05:53:17 -0500
Received: by ey-out-2122.google.com with SMTP id 25so16108eya.37
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 02:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bT2srkhku0vSXfF87j0NAg1xJXaQS8/4CCAqLKbWX04=;
        b=aTXdARV2i6rzvxOGdMYMs0CJesAqbMqwW+otgHi1sObjfJBuHWVfCvVJUYcJbj5KX4
         ru+4/mcb5EwLFp30GwviSf++pDwQ0FNcnFxi/9Fihg0bcqQ9Hgra9s+xsfbmbLR+2efC
         GL2bWpBAUIsgxZFsWQnFNhXqpgiq+ga5hCQIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R2MPciZpxEruhHIc/tI1YkuUz3JYnyTyLLRrUJiimxjCUVIq30w8pHe0Sx1P22y52g
         sREVQo8AX4hWZA0mFiShyAuNLpFn7s3DlG7d9FDgqz4vOJgv8YshHdBCHUIXlU/5I0uO
         5LBPJVBK/58b/zB4GUdAusKm2yZRRmRnbJUHY=
Received: by 10.210.43.11 with SMTP id q11mr4001523ebq.48.1234349596058; Wed, 
	11 Feb 2009 02:53:16 -0800 (PST)
In-Reply-To: <4992A3DF.4010707@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109403>

2009/2/11 Johannes Sixt <j.sixt@viscovery.net>:
> Alex Riesen schrieb:
>>
>> I'm honestly sorry for my contributions. They seem to be exclusively
>> in the "make Git work in Windows" area.  Depressing.
>>
>>  t/t3400-rebase.sh |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> Very interesting. This test works unmodified here. On the other hand, I
> have to skip the entire t4129-apply-samemode.sh.
>

hmm... These seem to work here. I have to use Cygwin. Do you use the
native port?
