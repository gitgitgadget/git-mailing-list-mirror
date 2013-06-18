From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 4/5] stash: introduce 'git stash store'
Date: Tue, 18 Jun 2013 14:20:21 +0530
Message-ID: <CALkWK0n3aEC+BxM7iAY=pcy7fKzpLeTAeRf8UttJ+K1PURP2rQ@mail.gmail.com>
References: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
 <1371302006-29775-5-git-send-email-artagnon@gmail.com> <7vtxkwd1cw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 10:51:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uord7-0005iq-Pl
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 10:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037Ab3FRIvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 04:51:04 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36877 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058Ab3FRIvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 04:51:01 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so9416072iec.41
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sjZ3PY7RtamrSaocipa09Esqr8EUtXe5f960mVMpUX8=;
        b=fCTx/xt8Uv2wEuqG1VdrnxJ4QwL0MG7/wXuqEaaZD7YKd9xnJYj018z6cO6BlPIXUz
         xTx1nYMOHGPlQtAja3WMKvHHCZuX3np+pPG/6hDeezU/zOeOluUtVQbGE2Ph+6uGYAFP
         mvlTKcqz5u1Yf/IPPRk4T7wwwu4LI7rk7NpJB2WYvs+/j6ri7mCnXzzbrFAbd4slNKqC
         PFjZoE8bG2w7JtpmIiDv3G4Pm4Ue79ccXnvXplaBSJoPtXF1AuVm5lWrmePuFqlx20qP
         /FmT9BWLe13oNpgAWsKkAWnTKBh/m6zpPGhX5O63BX8BACJAbXscunBvDnghia7GIslW
         rOIA==
X-Received: by 10.50.98.104 with SMTP id eh8mr6993967igb.111.1371545461576;
 Tue, 18 Jun 2013 01:51:01 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 01:50:21 -0700 (PDT)
In-Reply-To: <7vtxkwd1cw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228176>

Junio C Hamano wrote:
>> +     test $# == 1 ||
>
> This is broken under POSIX shells.  No need to resend (will locally
> patch up).

Ugh, my C habit.  Thanks for catching it.
