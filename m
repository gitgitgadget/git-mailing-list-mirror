From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/8] sh-setup: make die_with_status clear GIT_REFLOG_ACTION
Date: Tue, 18 Jun 2013 21:17:09 +0530
Message-ID: <CALkWK0kE1g5k=TxJCBQoHi+o7SZD5skQ2s6utxEgeuK=_C9ULg@mail.gmail.com>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
 <1371557670-12534-7-git-send-email-artagnon@gmail.com> <7vbo738na9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 17:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoy8S-0003xV-Fi
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 17:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143Ab3FRPru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 11:47:50 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49043 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab3FRPrt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 11:47:49 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so10555890iea.4
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nCuzIToE8PGPgEpCDTR0igWb54M0lhZ+G22BkI4JlXI=;
        b=QyiM97JnRuR2ihcZGfpai7o5opjL0inRjyDPw4h+MxpA/6JducDaCTSbGJ9xBmwyt7
         3V2VucZy9SrIals7OdXWHmcww751DJXAK69rUfrhMmn+AkDpRiL9fGddfi5J1h/ThHCV
         ZcL5A+CtE8NMg6fpcAvhbmHLAQW1VUZEjbOhY1VnxWQAjeicDj66kkGfbS2IjXyqd9yl
         soNZeb4Him0HJqKLsygF9Euk+nc6h5FPvg+8l2u5ZhbFt4G9DtC5zMkIUHXaMo8J7pCs
         WDfq1X0B1Dlv+FO+rgvDjdn33+3g7ifPzvCYFFnbbGYR8EEKU/9tUMecknQsGq/92vAS
         ISTA==
X-Received: by 10.50.25.194 with SMTP id e2mr7840040igg.111.1371570469330;
 Tue, 18 Jun 2013 08:47:49 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 08:47:09 -0700 (PDT)
In-Reply-To: <7vbo738na9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228255>

Junio C Hamano wrote:
>  - There is no mechanism for you to affect environment of your
>    parent process.

Please excuse my stupidity and drop this patch.  I got mislead by your
SQUASH??? patch which took care to set the environment variable and
call checkout in a subshell.
