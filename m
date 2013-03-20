From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] do not use GIT_TRACE_PACKET=3 in tests
Date: Wed, 20 Mar 2013 16:29:40 -0400
Message-ID: <CAPig+cQhG-oE5n-RjxhHqGoPzTZbLGagU+9gxzrJhaOcUAtffQ@mail.gmail.com>
References: <20130320172640.GC10752@sigill.intra.peff.net>
	<20130320174347.GA28548@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 21:30:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIPeE-0000dm-BM
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 21:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab3CTU3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 16:29:43 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:49101 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab3CTU3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 16:29:42 -0400
Received: by mail-la0-f50.google.com with SMTP id ec20so3800065lab.9
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=dc3RhYa8Qhqq/36to6PpLID67l2a9QFKsvygzFn9Ll4=;
        b=qHRwhBxTj7TA+IDp2MvIhuyA5oL4IwxPleK72LArJhlW9uLBLrsveK3A74sA/jWj1g
         DC1IjWw6f8EAyYMSCZMT0hl8XorpXeNQMxs4oL/LMjuupqDXUUavofWLRvFF9nirnRch
         hElfT1HGrHRoJ5NRJ43F0Vcv2hqskchIOQ8KRIUCobOrJ2ipJxPoeexW379BtJFqSeay
         VUQ/m1kxfu3qF1rWBb6/R2iBGs5/4oRAPufcdAlfpPCvfqGOWCwl3WtqhrJIDg45zg9o
         rT+CTFabSjFppakAw9SGzHxL9TTCOGe20VF4MB9p10AKVJT457b/QaEaoFQ8IRmyDB+C
         26Dg==
X-Received: by 10.152.123.34 with SMTP id lx2mr6218158lab.52.1363811380669;
 Wed, 20 Mar 2013 13:29:40 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Wed, 20 Mar 2013 13:29:40 -0700 (PDT)
In-Reply-To: <20130320174347.GA28548@sigill.intra.peff.net>
X-Google-Sender-Auth: 5S_nvH6d7t5BRTs650Rb9tN9mwc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218676>

On Wed, Mar 20, 2013 at 1:43 PM, Jeff King <peff@peff.net> wrote:
> Some test scripts use the GIT_TRACE mechanism to dump
> debugging information to descriptor 3 (and point it to a
> file using the shell). On Windows, however, bash is unable
> to set up descriptor 3. We do not write our trace to the
> file, and worse, we may interfere with other operations
> happening on descriptor 3, causing tests to fail or other
> even behave inconsistently.

s/other even/even/
