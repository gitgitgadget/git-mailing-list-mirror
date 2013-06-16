From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #05; Sat, 15)
Date: Sun, 16 Jun 2013 11:48:11 +0530
Message-ID: <CALkWK0m8ioUjc3+4s9qBFVH=L0wCwe1Vz1H5fdR87LM+3sc1=w@mail.gmail.com>
References: <7vehc2k32k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 08:19:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo6Iy-0003ou-4G
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 08:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab3FPGSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 02:18:52 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:44967 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab3FPGSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 02:18:52 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so4562757iea.11
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 23:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FHCbLoMkovXixreZaOfxIb5gppG0aV45tiNtcIAKdFY=;
        b=eglkdd2bnu92G9jk2G/MYB37MFuQFZo3eyL0Osi7iRZATumZElle7LruQhX3P1WTXM
         oA9LnzU1iUKGJ73hNQcp5tm/BdjZ7j2040aCMpJfWAu0UwXEMVQlLSVYcG3PvrsYJobp
         ALGuGALUr/Pq/U7TzEAbiA8CGGIbDA6PWBbLntWwMBTYC44KllJwO3ZDFKoYOBOxG47S
         teI0wAGuQZZbB0reSvAAVHPCGW2aAV4N24URhLZPqTS4tzSA/TYWCZQFmTOue5FkOUNN
         1FAvAqQPoKPR4lQTLVQa28lymrThGacnMnnEjHaHDX7m4S4A1HOiHLdeuW6PJKkrP2Nz
         YidA==
X-Received: by 10.50.80.9 with SMTP id n9mr2319838igx.42.1371363531758; Sat,
 15 Jun 2013 23:18:51 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 15 Jun 2013 23:18:11 -0700 (PDT)
In-Reply-To: <7vehc2k32k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227992>

Junio C Hamano wrote:
> * rr/am-quit-empty-then-abort-fix (2013-06-14) 2 commits
>  - SQUASH???
>  - am: handle stray $dotest directory

Please pick up the latest iteration.

http://thread.gmane.org/gmane.comp.version-control.git/227946

> * rr/triangle-push-fix (2013-06-09) 4 commits
>  - t/push-default: test pushdefault with all modes
>  - t/push-default: generalize test_push_{success, commit}
>  - push: make upstream, simple work with pushdefault
>  - t/push-default: remove redundant test_config lines
>
>  Tries to apply the 'push.default = upstream' semantics to
>  triangular workflow where it does not quite apply.
>
>  Waiting for a reroll.

Still haven't figured out a solution; will hopefully come up with
something in a few days.  Discard if necessary.

There are some other topics I posted awaiting responses.  Take some
time out to read especially the for-each-ref enhancement series that
Duy and I wrote.

Thanks.
