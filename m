From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 00/16] Cleanup {branches,remotes}-file cruft
Date: Sat, 22 Jun 2013 00:39:28 +0530
Message-ID: <CALkWK0mHyOU35NmZPf8x-f4FduZ9Mt=Uyqa8t9PvVmRiq+RcUA@mail.gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
 <7vsj0bo7pr.fsf@alter.siamese.dyndns.org> <7v38sbo230.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, akpm@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 21:10:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq6iw-0007Hl-1E
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 21:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423680Ab3FUTKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 15:10:11 -0400
Received: from mail-bk0-f43.google.com ([209.85.214.43]:48540 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423604Ab3FUTKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 15:10:10 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so3547541bkc.16
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 12:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KMBJm5Tzkvb/JdU3GeVf3tIXkekxJk6awVSs9iMYVIk=;
        b=Fcv7McDQpUwR5kxVpsiTMSawjFF6v74sNsLujNEg0Pq8yVHxTk9CQFn7k27suUtKrF
         IjkQ0XzVxDEJSV6MsXBRF37TIJsiq/XbnzxaF5EuntMxRE9eJ5aJeQpKeIW39XgimLj9
         B5h03sqTwUrTV4yZqWkdvmBQW7tMpgIY98yS/ibotkVBtDs0pwDnn18YTsDqemVWSmIF
         4XfTyOwQuuaRYBTASQRFsDqNyOZLYvvsH4XYi9HeG1j5mlEzHPSk37wxZx6ZebkjJIHy
         7ChH/YntO0irf32IA6ZzEGvTYW+kat/OoWn+I6XNGfJ8QeNgtlHaq4hLqMMAWJfWWbmU
         C7eQ==
X-Received: by 10.204.228.207 with SMTP id jf15mr2060281bkb.16.1371841809221;
 Fri, 21 Jun 2013 12:10:09 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Fri, 21 Jun 2013 12:09:28 -0700 (PDT)
In-Reply-To: <7v38sbo230.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228654>

Junio C Hamano wrote:
> So from my point of view, a proposal to remove them has an almost no
> benefit vs potentially very high cost of having to break many people
> who are silently happily using them; not a very good benefit/cost
> ratio.

Yep, it should stay around because it's useful to some people and harms nobody.

> I say "minor" only because I think the cost of keeping these old
> mechanisms alive is very low (if it is a heavy burden on the
> maintenance, please tell me and how).

Yeah, the point of this series is to reduce that maintenance burden.
After it is applied, there will be exactly two functions (each with
one caller) that are tested fully by precisely three tests in
t/remote; and exactly one piece of documentation will refer to
branches-file/remotes-file, namely urls-remotes.txt.
