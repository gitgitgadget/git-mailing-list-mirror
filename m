From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Fri, 14 Jun 2013 21:43:21 +0530
Message-ID: <CALkWK0m6iiDAmbxG9wrpgxJ3=nM816U7RM519Mu62qSgDwJbaQ@mail.gmail.com>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
 <1371196058-23948-2-git-send-email-artagnon@gmail.com> <7vli6crau5.fsf@alter.siamese.dyndns.org>
 <7v61xgraba.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 18:14:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnWde-00045Q-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 18:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab3FNQOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 12:14:05 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43538 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab3FNQOE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 12:14:04 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so352870bkb.19
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cyscKziIs3bG+TidtlQH0cespyuMP9/QrUIzr43DNUs=;
        b=dWi3xdo4e2bLpGToJYy8JBTtswPoY4sI7P2l44+Z1+pGfp8UQb4eOto3vbsZo0YgaO
         HwwVbXCXqqqWcNZ/w1HQhuiMPToT1fAOCo3XAYu70Vbc/U7Ob3iLQZN+oagsF1ikJnwI
         54FT0rmeoZ5N+xb55aEuyQA5WQdkwrsFWcrxf9jqvSUFauluJmGGM0wpmyfRGoWHsjSM
         EPGZ2+HUocpNxhv9rFGGLNykR6AstGVqj1lFVTE9HUi/k7GFhamcR3JfsFPvUgnYAauX
         tyE1BfHjFNbTArAg2r8jCvIOVHq6d6ebBKUoVoswIfxrPmPXB844jC85iqWQ03/zf0HR
         OXsg==
X-Received: by 10.205.115.5 with SMTP id fc5mr442405bkc.155.1371226441629;
 Fri, 14 Jun 2013 09:14:01 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Fri, 14 Jun 2013 09:13:21 -0700 (PDT)
In-Reply-To: <7v61xgraba.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227892>

Junio C Hamano wrote:
> And then the message triggers at the second test in t3420 when
> applied on top of 587947750bd7 (rebase: implement --[no-]autostash
> and rebase.autostash, 2013-05-12) or 45acb7592825 (Merge branch
> 'rr/rebase-autostash', 2013-06-11).

What was triggered?  (I didn't understand what you said)
