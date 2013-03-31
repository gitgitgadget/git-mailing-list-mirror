From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] git-send-email.perl: implement suggestions made by perlcritic
Date: Mon, 1 Apr 2013 02:29:46 +0530
Message-ID: <CALkWK0nGZUV9umbe9UoV79QU+ojCc-=j+RFpCNn_vjM_QTPyPQ@mail.gmail.com>
References: <7vfvzgn3ob.fsf@alter.siamese.dyndns.org> <1364474835-23416-1-git-send-email-artagnon@gmail.com>
 <7vsj3fs22i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 31 23:01:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMPNA-00025T-B7
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 23:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab3CaVA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 17:00:27 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33411 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab3CaVA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 17:00:27 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so1825153ieb.17
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gsHYqecED7z1xS9KZUjOY3P9uDW+ZMw3hYfeI4ur4Os=;
        b=jLaHQFVDEtXzYjk7wfZ/IZXBSEWMT9Bq4CAyyJ6tPWIuaK9dhctz8sZiESC+oKjrpS
         uX7yL3j56ymc98Lim3Ws+Zn0E+UbVSVakfFSUOv9Wc44CTXbwFvtWuRm5YUTQPg5BvPM
         zrPkHDp33tFMjOljt91CdaS/cOPaKt6MJlF5r6o84d+V+XTWCIpbv5AabrE01aSz13EN
         Vh//QK3GrS3CY8z4AYot9FBwKTUFzZKZVKwU5WazuWpdBzCar9IOk/bVaEJYTjwPtmal
         klOUNCPh7P/ygDBKZeKoU6gco19PWd5H928hpsTD9J2psNeVVEbXiqoht8ZYfg2AXI8p
         T17A==
X-Received: by 10.50.17.201 with SMTP id q9mr2369297igd.107.1364763626852;
 Sun, 31 Mar 2013 14:00:26 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sun, 31 Mar 2013 13:59:46 -0700 (PDT)
In-Reply-To: <7vsj3fs22i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219642>

Junio C Hamano wrote:
>     sub foo ($) { my ($arg) = @_; print "$arg\n"; }
>     sub bar     { my ($arg) = @_; print "$arg\n"; }
>     my @baz = (100, 101, 102);
>     foo @baz; # says 3
>     bar @baz; # says 100

Ouch.  Please drop this patch; I'll resubmit when I feel confident
about my change.

> This patch fell under the cracks, and reminding me with a "what
> happened to it?" was the right thing to do.  Literally, that is what
> I ask in the "Notes from the maintainer" message.

Right.  Thanks for clarifying.  I'll actively track the patches I submit.
