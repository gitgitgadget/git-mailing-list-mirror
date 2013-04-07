From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 00:56:56 +0530
Message-ID: <CALkWK0kA86YgonuXv=h2hA_hV8RfWPsBjtrk6OnHXiP=qDBjwg@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 21:27:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOvFe-0003Oa-Jr
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 21:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933157Ab3DGT1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 15:27:38 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:53962 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933063Ab3DGT1h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 15:27:37 -0400
Received: by mail-ia0-f174.google.com with SMTP id b35so4586179iac.33
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=X9Vrp/wwMZcvvU0x+TwT2Xd74JTW1nLe+bZZWcU9Wuo=;
        b=lGi7i8pne12y3AdxbKEx8rRk85xSVm8QhrjdR1834I1wMJ8chIFeqP11IkDcNyXeY2
         AjlLLxA4UqUSjSV5TUR6Q3jyLV8oWUmEgu/JgVupiPOZRFyWa9NNEfY2HFMdhtPK9bOP
         F5g1u/+vyZ3SytOvVoENfj8gC7Bf6XAXS15Ve7diprb3Vl+TNYNvZhReSdmNJGGYZ1mO
         wPV8tvppFQfBsFdNW+xscNwO0sZuDqHiIst7y0xaQy92EsnlFsjr/JXlOHzQQS9UkR7X
         s+/lY/zZETFEp3h15WLgZl6r9YhWzcYHjN6sT5cu3XoKcJyfnQR/9TiG/Pv0rDfAJanU
         pZ3g==
X-Received: by 10.50.108.235 with SMTP id hn11mr4684064igb.107.1365362856898;
 Sun, 07 Apr 2013 12:27:36 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 12:26:56 -0700 (PDT)
In-Reply-To: <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220365>

This reminds me of the commit generation numbers thread.

"But how can we determine ancestry?"
"Use the commit timestamp."
"But what if there are clock skews?"
"Put in a slop."

It breaks existing stuff, and it's hard to show any end-user benefit.
I fear this proposal will meet with the same fate.
