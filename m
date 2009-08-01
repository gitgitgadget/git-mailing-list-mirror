From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Sat, 1 Aug 2009 18:34:03 +0400
Message-ID: <20090801143403.GC10264@dpotapov.dyndns.org>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca> <4A714F5C.70000@eaglescrag.net> <81b0412b0908010043y51680392r69a0090aba520b13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J.H." <warthog19@eaglescrag.net>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 16:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXFgR-0001WX-Qe
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 16:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbZHAOfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 10:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbZHAOfY
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 10:35:24 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:52913 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbZHAOfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 10:35:09 -0400
Received: by ewy10 with SMTP id 10so2095025ewy.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KO4eVCYR4yMQWlhNscrtDg2PdhZ+7E9Hz3U3JNwgBvE=;
        b=UyArh13VWpeFNjQF3WDrzAb5wt2nDg8Soveg9xQ2dtXkQXimA4iebxZCSAakLSawS2
         CFxRCRQQzzny4K3LLcJxYyKmzHMgwh1CHlwtRAiDDVcsMSGIvI+RP9xerRFCWkcbvkqQ
         eCemu+xPQ1mEAlfkY6rIRi7/+xi1gG9JzGdcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UzaoSyV4Hr+SMzBKJnsG7Bz6fomLf5j/tF1l8GE2OCmfC/gaCI0iUUAOkp6JI6M8U8
         r1mHNhVufFAo6v9bB37Xn4hmcytqg/EwnlrElw6VfWfGngvnpnxOK3yWeHAegqju9rhl
         h6njKAu5N0qbpoHOJNTTDwD474GnSzYbqaY7w=
Received: by 10.210.141.9 with SMTP id o9mr2447929ebd.10.1249137308992;
        Sat, 01 Aug 2009 07:35:08 -0700 (PDT)
Received: from localhost (ppp91-76-18-53.pppoe.mtu-net.ru [91.76.18.53])
        by mx.google.com with ESMTPS id 5sm5550665eyf.8.2009.08.01.07.35.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 07:35:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0908010043y51680392r69a0090aba520b13@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124625>

On Sat, Aug 01, 2009 at 09:43:39AM +0200, Alex Riesen wrote:
> 
> And the whole project seems to be very young (listen on ohloh since 2007).
> And it is not in current stable distributions. Exotic thing.

The project seems to be it is developed together with Igor Pavlov, who
is the author of 7-Zip (and now 7-Zip also supports LZMA2 and XZ
format). Accordingly to Igor Pavlov:

   LZMA2 provides the following advantages over LZMA:
   1) Better compression ratio for data than can't be compressed.
   It can store such blocks of data in uncompressed form.
   Also it decompresses such data faster.
   2) Better multithreading support. If you compress big file, LZMA2 can split
   that file to chunks and compress these chunks in multiple threads.

Clearly XZ is not very popular yet, but I would not call it as exotic.
At least, I expect it to be supported by future distributives.


Dmitry
