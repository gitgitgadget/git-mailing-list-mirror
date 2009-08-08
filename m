From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Sun, 09 Aug 2009 00:58:22 +0200
Message-ID: <4A7E030E.2040301@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain> <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <alpine.LFD.2.01.0908061909310.3390@localhost.localdomain> <alpine.LFD.2.01.0908071614310.3288@localhost.localdomain> <4A7CBD28.6070306@gmail.com> <4A7CBF47.9000903@gmail.com> <alpine.LFD.2.01.0908071700290.3288@localhost.localdomain> <4A7CC380.3070008@gmail.com> <alpine.LFD.2.01.0908072107170.3288@localhost.localdomain> <4A7D0E7B.3030601@gmail.com
 >
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 09 00:58:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZury-0001jy-Aj
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 00:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbZHHW60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 18:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753058AbZHHW6Z
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 18:58:25 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33389 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbZHHW6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 18:58:25 -0400
Received: by bwz19 with SMTP id 19so2023903bwz.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=9U3j+2RJDdVyPre6a3VJEoVFhMJSV42omgTcYb0LRjs=;
        b=E6BkKyhSoF3le9Dcl3mCMypAeZPkX0x9CtLgv6pZ5k69cP01Drk6pprhvKDl80+XTm
         lHOmau2WYX+PUcbagApWjUf98SmsHHRVsIXRU4bDcG3x58/f+qokZOWgffdyJ/n+Rf23
         0ZlbgmqJFS7zKETJ3AxdmOnN0WOv498rKcbNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=KG2FUew+2mfu1ZJp02YvR71gMU2Ye6NRv+5LX+oJcL4WHhMTAyGLoS0IwOHkgSk/IK
         umNjPqolYoi2QLwz1YozDWa+jOWEXSiWaW/IOA1tFLCscOB07MbpSe+vLVjqTSyZvOpf
         pwPeISjlCWclfRDQhK5U2I6I7qSNpnYBvjY4c=
Received: by 10.103.52.11 with SMTP id e11mr1161552muk.19.1249772304621;
        Sat, 08 Aug 2009 15:58:24 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-121-180.multimo.pl [89.174.121.180])
        by mx.google.com with ESMTPS id 23sm12563333mum.35.2009.08.08.15.58.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 15:58:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <4A7D0E7B.3030601@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125310>

Artur Skawina wrote:
> Linus Torvalds wrote:
>> magic? I force the stores to the 512-bit hash bucket to be done in order. 
>> That seems to help a lot.
> 
> I named it 'linusv':

> linusv         0.3697       165.1

I was not going to spend even more time on the C version, but after looking
at what gcc does to it, tried this: 

diff --git a/block-sha1/sha1vol.c b/block-sha1/sha1vol.c
--- a/block-sha1/sha1vol.c
+++ b/block-sha1/sha1vol.c
@@ -93,7 +93,7 @@ void blk_SHA1_Finalv(unsigned char hashout[20], blk_SHA_CTX *ctx)
 
 /* This "rolls" over the 512-bit array */
 #define W(x) (array[(x)&15])
-#define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
+#define setW(x, val) W(x) = (val); __asm__ volatile ("": "+m" (W(x)))
 
 /*
  * Where do we get the source from? The first 16 iterations get it from

and got a nice improvement:

rfc3174         1.436       42.49
linus          0.5843       104.5
linusph        0.5639       108.2
linusv         0.3098         197
linusvph       0.3082       198.1
linusasm       0.5849       104.3
linusp4         0.433         141
linusas        0.4077       149.7
linusas2        0.436         140
mozilla         1.099       55.54
mozillaas       1.295       47.11
openssl        0.2632       231.9
opensslb       0.2395       254.8
spelvin        0.2687       227.2
spelvina       0.2526       241.7
nettle         0.4378       139.4
nettle-ror     0.4379       139.4
nettle-p4sch   0.4231       144.2

The atom numbers didn't change much.

artur
