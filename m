From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH v2 0/5] contrib/subtree/Makefile: Standardisation pass
Date: Tue, 06 May 2014 07:54:30 +1000
Message-ID: <69f827ea-0ba2-4ca0-b711-002e1a0010b7@email.android.com>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com> <20140505050803.GA6569@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, greend@obbligato.org, apenwarr@gmail.com,
	gpmcgee@gmail.com, mmogilvi_git@miniinfo.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 06 19:03:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiAq-0007Xo-3n
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756758AbaEEVym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 17:54:42 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:61579 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756357AbaEEVym (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 17:54:42 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so1998196pde.1
        for <git@vger.kernel.org>; Mon, 05 May 2014 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=ACjf/1jaMZdNcvPwMNaV/ZaN2UH95tCqikFiklfH9Ic=;
        b=oMMxIEFcl/XMiim7zKtKQtv47AdvUC7U3vICusDuX44f2t7atUVRNZ0sAmneDUR9Wy
         uM5oslQZc84jKbJ7h8g+A2LC25Mkv7fkFSnVTuT55y6w5tVfUSIa/C89wwgqEQDYSdVY
         /3NQCx1hKG5uB+xShFQ8bEk6BYrNQKBPSk0LUdhBxyqtcmo5WC8bwShuHgQ4jeUFNEQ4
         60wnrJqmZ21RY2ioGyvGD76pY1oaKYtUmZOTuaxkUACfuusGXPokFIbByw+tKhxtx3sm
         VJM9bhUNYCww6K2RVz6mjp1eoXGCNXrx4nNjhbPCj/UEYH8R4v0B+PvTmpFqLq2uwE8o
         FD8w==
X-Received: by 10.66.177.168 with SMTP id cr8mr77028296pac.128.1399326881493;
        Mon, 05 May 2014 14:54:41 -0700 (PDT)
Received: from [10.94.103.239] ([101.119.29.90])
        by mx.google.com with ESMTPSA id te2sm81321592pac.25.2014.05.05.14.54.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 05 May 2014 14:54:40 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <20140505050803.GA6569@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248169>

On 5 May 2014 15:08:04 GMT+10:00, Jeff King <peff@peff.net> wrote:
>On Sat, May 03, 2014 at 10:49:30PM +1000, James Denholm wrote:
>
>> The main issues are that calls are made to git itself in the build
>> process, and that a subtree-exclusive variable is used for specifying
>> the exec path. Patches 1/5 through 3/5 resolve these.
>> 
>> The "cleanup" fixes (4/5 and 5/5) are based on precedents set by
>other
>> makefiles across the project.
>
>Thanks, these all look sane to me (I do not use subtree, but since it's
>just about Makefiles, it was pretty easy to review).

Thanks for the review!

Given that subtree subtree doesn't really generate a lot of discussion,
would it be advisable to wrap this up (barring further discussion) and send
it off to Junio rather than waiting for further community consensus?

Regards,
James Denholm.
