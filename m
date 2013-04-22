From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Tue, 23 Apr 2013 02:38:28 +0530
Message-ID: <CALkWK0=EcXP-tUOhcn8vmqPtzetX19QOgRb14Op1ZM9ZtxEz3Q@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> <CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
 <CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
 <CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com>
 <87zjwqpebl.fsf@hexa.v.cablecom.net> <CALkWK0kVDbyQBTSTbEDoVFs8E6JKWw3Z6L77NCXSb=FU8GNDkw@mail.gmail.com>
 <B91DA87BC1F548ECB1FDB9550F4AB017@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 23:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUNz9-0006Eb-Gc
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030Ab3DVVJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:09:11 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:48203 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab3DVVJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:09:09 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so7644865ief.21
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QXk6QpeXz+RqRdxrOfduwGpjUdYNm4jVGmbXpiahDWs=;
        b=sX7P6oVbf8TWMx9rIRvE329+X1MMtB5DnjhJUHgn0C5aPoCojwRLpqgwIfJwLt6vai
         HAm6Bx7zv1KAStl+pWhnlpq8hp1B3EIhTDZGefQflCs4Fwa7wX8WyVqtnSNmPO5Km8OY
         4z7ur76ALdTTHvqaw6dHVpGx11m/BrvAUINstFbWLs1+VHct2XcZQHvdwxBOWPeH9mqe
         QplXS8/9pr1McH2CjN/bR+H1SckExtm+rImKKohqC3OpJcTm/PvkSRSioTaroA5rt/72
         pupvYN86ND2tO/nZcSk2KVUFLkzpGY5bd2XTbCulANRAdOgV9bvOXDG1p2FQYO8cFewm
         rMGA==
X-Received: by 10.50.17.71 with SMTP id m7mr16374650igd.14.1366664949152; Mon,
 22 Apr 2013 14:09:09 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 14:08:28 -0700 (PDT)
In-Reply-To: <B91DA87BC1F548ECB1FDB9550F4AB017@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222093>

Philip Oakley wrote:
> Is this not similar to the previous attempts at bulk rename detection? Such
> as $gmane/160233.

Yes.  Does anyone know what happened to the series?

... and I wonder how git merge -s subtree works (still reading).
