From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Tue, 23 Apr 2013 02:53:44 +0530
Message-ID: <CALkWK0=n=06sd76Ah_kL-a3P0WQ7GkOH24kaNPzfzg=qpinMCQ@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> <CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
 <CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
 <CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com>
 <87zjwqpebl.fsf@hexa.v.cablecom.net> <CALkWK0kVDbyQBTSTbEDoVFs8E6JKWw3Z6L77NCXSb=FU8GNDkw@mail.gmail.com>
 <B91DA87BC1F548ECB1FDB9550F4AB017@PhilipOakley> <CALkWK0=EcXP-tUOhcn8vmqPtzetX19QOgRb14Op1ZM9ZtxEz3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 23:24:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUODt-0003Dw-GE
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151Ab3DVVYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:24:25 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:55237 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab3DVVYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:24:24 -0400
Received: by mail-ie0-f172.google.com with SMTP id c12so3761400ieb.31
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=0Z2l1ZpAiP36ZCVORALurJz7z9yPsTgoDKIo+J0DQP8=;
        b=K4n0m1pzpQR+bGVtE8RSPmsw2VQKcEV7IZiE5OSb35efk8bzUJOXjkVPCeERepMUIP
         1No0fz4BMiV6l1kC1xyS7wW6R8mBgVbY3PyiXd7QtiPo0hBNHvXLwkHqzn+aHrrnjzq8
         QNBItj+iQSadHH65H6HfWMM+gsdClBWDwKG7hY11FkvPWddpopBg6wO4oeYu90kbZl9j
         TeeXYVy6a5xtCBgewlXABzxaZ+4Piy0Eh0iZPxHTnLYyfrVco/BnlqdaRriOUraS23ao
         mMgtDPhV2YCYSy0FNM1P0+JcJoZWJHNrx/Vjue/x/kK61BusBNCeBKnYmK8K0Gz+SPDz
         2W8Q==
X-Received: by 10.50.17.166 with SMTP id p6mr9140114igd.12.1366665864196; Mon,
 22 Apr 2013 14:24:24 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 14:23:44 -0700 (PDT)
In-Reply-To: <CALkWK0=EcXP-tUOhcn8vmqPtzetX19QOgRb14Op1ZM9ZtxEz3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222095>

Ramkumar Ramachandra wrote:
> Philip Oakley wrote:
>> Is this not similar to the previous attempts at bulk rename detection? Such
>> as $gmane/160233.
>
> Yes.  Does anyone know what happened to the series?

Hm, this and the series Matthieu posted ($gmane/163328) seems to be
solving the more generalized problem.  My initial problem was to do it
only when following a single file's history (probably a --tree-follow
corresponding to --follow).  And to probably restrict looking only in
merge commits (?).
