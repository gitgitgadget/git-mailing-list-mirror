From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Tue, 23 Apr 2013 04:29:46 +0530
Message-ID: <CALkWK0mHsMRYc2MZ92ALzfLC9mxytA5OiL3i4Wh+BE6bZMb2hQ@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> <CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
 <CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
 <CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com>
 <87zjwqpebl.fsf@hexa.v.cablecom.net> <vpqr4i2z35n.fsf@grenoble-inp.fr>
 <7vmwsqns4p.fsf@alter.siamese.dyndns.org> <CALkWK0mO0L4YrZFGmzWkiO4V18p-ydKyjVOe4vJ2H-d7Kz+qOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 01:00:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUPit-0007sT-Is
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 01:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877Ab3DVXAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 19:00:30 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:61723 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab3DVXA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 19:00:28 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so4103iec.29
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 16:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SQbohJiRFL/1yWzoCXm14C6UWpDIqn24LNpUhRqebqY=;
        b=Iti71rw+CieRcOI8glGWDvzR6A5Ju6pYVXzm68Mj2AzvrIlZi5pgLqYoenUswfP6J8
         zLGMw5jQvzOaUlsMfOqfNx6r9lnQxILLCjSJ4unoBChnkMBbfflvGSag9vcL2NHlbstw
         wFrtbJLIyd3AJsrn+2wpn8znaAbhzkiHU9BF304M1khbse/gCFPNPSDc7DZFKJt7JLPD
         EKjv0z4LD9QJvoURtARBO5XzZGFPAlp7Vt3NKlb1bMRvzP9ksN2cakA9CPjiOhkDnlmt
         hjurtHUbXlpde34xLv1E2jVyzEKkvD0cNDokNTIPyRyPEX9rIdsgDUVu+1twHu/ttQFV
         sAcQ==
X-Received: by 10.50.17.71 with SMTP id m7mr16566089igd.14.1366671627991; Mon,
 22 Apr 2013 16:00:27 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 15:59:46 -0700 (PDT)
In-Reply-To: <CALkWK0mO0L4YrZFGmzWkiO4V18p-ydKyjVOe4vJ2H-d7Kz+qOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222127>

Ramkumar Ramachandra wrote:
> [...]

Oh, and I forgot the best part.  True floating submodules when the
bind line references a zeroed-out hex.  Naturally, the diff'ing to
figure out changes introduced by the submodule will be blocked.  Also
good for dropping in huge binary files at a particular path.
