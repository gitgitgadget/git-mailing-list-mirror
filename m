From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Sun, 16 Jun 2013 12:06:08 +0530
Message-ID: <CALkWK0k9hhCvYs=SrCi_s=q-MfhFWtkw8q2PYG+Vy-tRq65nsA@mail.gmail.com>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
 <1371196058-23948-2-git-send-email-artagnon@gmail.com> <7vli6crau5.fsf@alter.siamese.dyndns.org>
 <CALkWK0mF7s7Zfp4VTekT9AhHNhd80Jj3GT8SaKVs4gAATACsBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 08:37:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo6aL-0007M2-5L
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 08:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941Ab3FPGgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 02:36:50 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47779 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913Ab3FPGgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 02:36:49 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so4539219iec.33
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 23:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i/CumA0P80JKFieB09hRf5cktxTFY0Q+UE1qxb7Nrc4=;
        b=Mk/PwZr8e4UoEcQ6L+UHMLhfoVSvJi1/rzpkfeHDzsAUdO8AID6jDwJLgbxrLUmc+F
         J5WkkMa2GRfyr/2rYOOGjnQkMZWvU7PgXn2P0/cttoI7rn25Dt+IpvrLq1Ok7qZRGvVK
         CKzCFnU6TThHPFu2vgBUdCkCPCDVuQdQ908ahvpVH/uk74d1hvsBXHRGi48qFFSc9p4r
         t9LQ/fI1qvov186Wzv9qxGJLv6/JZBmqvt4Uzs26UITv9DdjaQJOZSP3AGNzO+ZXXXZK
         9QcQWpdoAX9Lpvjm2f86NOb534S4YEQVclkvqAxrPPiIUjE3QszdsjEvGk0JHKzUArRD
         EFvg==
X-Received: by 10.50.79.231 with SMTP id m7mr2279053igx.40.1371364608997; Sat,
 15 Jun 2013 23:36:48 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 15 Jun 2013 23:36:08 -0700 (PDT)
In-Reply-To: <CALkWK0mF7s7Zfp4VTekT9AhHNhd80Jj3GT8SaKVs4gAATACsBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227993>

Ramkumar Ramachandra wrote:
> Can you tell me how to get shell-script-mode to indent the
> case statement properly? (I used the default indentation)

Never mind; I figured it out:

(setq sh-indent-for-case-label 0)
(setq sh-indent-for-case-alt '+)

Maybe we should dump the relevant parts of my .emacs somewhere in-tree?
