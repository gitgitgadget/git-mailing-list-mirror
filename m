From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Thu, 10 Apr 2014 14:20:01 -0500
Message-ID: <5346eee1dfb6_d98135b30c21@nysa.notmuch>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com>
 <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
 <CALkWK0nSed9vvRvTR00_vV3tHL8mSQA=8JJ_Y7=pQchoVcvhzA@mail.gmail.com>
 <xmqqha9ghhrw.fsf@gitster.dls.corp.google.com>
 <CALkWK0=Km+a7NBm9ki5MN=R28HkzUZRqnBKcpuPZDrQKdsBesg@mail.gmail.com>
 <20140107210607.GB28102@sigill.intra.peff.net>
 <CALkWK0==wNMvjHmwnGaQi+RitXgros39+70zWH29=Q238Rkp5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 21:30:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKfp-0002JX-Ay
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbaDJTaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:30:01 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:50445 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbaDJTaA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:30:00 -0400
Received: by mail-ob0-f179.google.com with SMTP id va2so4912033obc.24
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=AhRbDzVIwmNxiNj7De2aGRpDVZcuci7ZbUY6C/GLyL8=;
        b=yRWPrUmP5A2UG+JBNY+7CHxBxV4W+RXmx6rUPTiJHJ7AFa/Y4CO8Ja1C+/BMSc+8wg
         jPbGps+E9diff0R5Wv7+7G3X+dIfDGNVMsoYHo+4L8WolHjj1gSUTlKtMDowSGCTwzzg
         w1dc1+lB4FHtxOF1yr5dOiMkSwKw9si8hK+9QAEOMTpNboYbfm9PuBzTFxnpSW8b/0fF
         G1MA9FpLnTSxVw8rxvXDMd6LVB8m+ABVGGSHwLe3c2jvSTQ6K4NYVyFfeQyvxjiz0Pie
         miiESlGiY20re3qpbscvr5CvO3d1tNckviMG1BtK2lpohlcf9PYbfQc6XNdmilGXvtX2
         +g/Q==
X-Received: by 10.182.181.2 with SMTP id ds2mr164132obc.86.1397158199658;
        Thu, 10 Apr 2014 12:29:59 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qp6sm8426860obb.14.2014.04.10.12.29.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 12:29:58 -0700 (PDT)
In-Reply-To: <CALkWK0==wNMvjHmwnGaQi+RitXgros39+70zWH29=Q238Rkp5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246051>

Ramkumar Ramachandra wrote:
> My primary concern is that the proposed @{publish} should be a first-class
> citizen; if it has everything that @{u} has, then we're both good: you'd
> primarily use @{u}, while I'd primarily use @{publish}.

Something like this?

http://article.gmane.org/gmane.comp.version-control.git/246038

-- 
Felipe Contreras
