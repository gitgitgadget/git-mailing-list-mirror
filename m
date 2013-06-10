From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] rebase -i: write better reflog messages for start
Date: Tue, 11 Jun 2013 00:06:14 +0530
Message-ID: <CALkWK0mmSKDH2vrz4a8Qb8=++NSAp2x5mCUEuLpPo9HLfmgFLw@mail.gmail.com>
References: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
 <1370881332-9231-4-git-send-email-artagnon@gmail.com> <7v8v2hizpc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:36:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6xe-0005aS-FV
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab3FJSg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:36:56 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:51848 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab3FJSgz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:36:55 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so1463741iej.15
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mKDZjjpClbr5/VEkENyo3fG46tsUZgWHdtrg3ZpaYcA=;
        b=VpEXWN5KLMtAsdJL8cVqr2s2sPkSnHcleIRVubthMu300RtWbKQNkTv3F5S5KjQOGY
         79Qno87Nx9ahY+v3FXSCAcYJS/Q0zfLZC5qC4TeArN9HBpZYhthnkG+zue0TgtZWWX0A
         GBx6I9XvZh6j6Fzv1nSsGIVE/n4lSvyPkdA7kka1T61Aio5qFIz3x0Sv1m07xWKbkFUx
         7QTW7+L/tnl+LAOmU3SLyaKawKzEt+k5Tvjq9AyOlEOIRM9lS4DhKhUGzwevAAnunrnn
         g+Naeks1fxL7Yh90EoTIgVQ77VaWvyJr/ubgLig5okyc3FSOP+l7XMrR+UT/n7TbGVni
         aVDQ==
X-Received: by 10.50.98.104 with SMTP id eh8mr4553690igb.111.1370889414866;
 Mon, 10 Jun 2013 11:36:54 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 10 Jun 2013 11:36:14 -0700 (PDT)
In-Reply-To: <7v8v2hizpc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227354>

Junio C Hamano wrote:
> I am curious what breaks, though.

t/status-help.  Looks seriously unrelated, and I'm breaking my head
over it.  Any clues?

--- expected    2013-06-10 17:16:42.276356867 +0000
+++ actual      2013-06-10 17:16:42.279690201 +0000
@@ -1,4 +1,4 @@
-# HEAD detached at 000106f
+# HEAD detached from 88a81b6
 # You are currently rebasing branch 'rebase_conflicts' on '000106f'.
 #   (fix conflicts and then run "git rebase --continue")
 #   (use "git rebase --skip" to skip this patch)
not ok 5 - status when rebase in progress before resolving conflicts
