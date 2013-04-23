From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Tue, 23 Apr 2013 23:07:13 +0530
Message-ID: <CALkWK0nbY6EcBmsOFPVtKoajiZnKacFKBVmpSYw9pJw3pQ4fgA@mail.gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
 <1366725724-1016-8-git-send-email-artagnon@gmail.com> <7vr4i1i3a9.fsf@alter.siamese.dyndns.org>
 <7vip3di21r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 19:38:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUhAG-00085R-VP
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 19:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757135Ab3DWRh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 13:37:56 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:59593 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757000Ab3DWRhz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 13:37:55 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so803297iaf.18
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 10:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KDEuvyusKIHT6nnLLOhwobpLBxCtTsgd4lJIqfhVP3Y=;
        b=OvnId4G+W2XDe1Cy74hUN5aLIdNNqM+bw06jQBQECfnFVhT89A1qN8aCaqWCabVWoW
         amZs4cHYbXNA+WOlqNCilY3jhEzMpcFvUU4NDzA7j9Mbf4DnAbwgboEO7UylEbQzET/x
         /TLz+BWmJIfmOtPpT/vEuE1hqznOYGfGhQkCX1AS9K1FK4P5iFWlHvTdF4QoDuPs25v1
         nl/oF54rfzQSsl4b8hWrwo3k/O+nHm+4aAA6b/6lsHazg7/Tviy49f/+85uSIYomixXX
         hjhcN4y5eVf2LxcWYbHwmtTOYKUnWe3286tsY8Fiy8U7BMwjEUTc+Z5hIufj0PGDS/ga
         80cg==
X-Received: by 10.50.119.102 with SMTP id kt6mr19238303igb.12.1366738675049;
 Tue, 23 Apr 2013 10:37:55 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Tue, 23 Apr 2013 10:37:13 -0700 (PDT)
In-Reply-To: <7vip3di21r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222200>

Junio C Hamano wrote:
> Perhaps "finish_rebase" or something?

Sure.  That makes sense.

I was too busy struggling with shell code to notice these things ;)
