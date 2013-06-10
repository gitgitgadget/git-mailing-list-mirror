From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [PATCH 6/6] template: Fix comment indentation in pre-rebase hook
Date: Mon, 10 Jun 2013 23:46:45 +0200
Message-ID: <CAD77+gTv-x7ZKAR3PycDWNhqeWcnEFEhK290ndxeyqqkBfWfeQ@mail.gmail.com>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
 <1370889365-6239-7-git-send-email-richih.mailinglist@gmail.com> <7vli6hg2ut.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:47:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um9vk-000866-Qc
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab3FJVrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:47:08 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:43187 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab3FJVrH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:47:07 -0400
Received: by mail-wi0-f179.google.com with SMTP id hj3so1144124wib.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 14:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dFurDIi0y1+VtCfWZaISDB9bGW9ws4bR3QMvsvgCe38=;
        b=k10/3t3qhcJNMn71IEi/WfWrMOr77Rcs9adKyq6YTTiXphT0pqMOiMmHNvRJz/UUgv
         VEBwT6oF332zgKO5dFsrb/RiBjrpODzeLkrYgJQTvL3awa9f3l7ES0WdI5YVTAx81M4C
         swF/EcHsyw+5XUp+TCjhcstobQP4rwHNp6aXsdD4aGgmq7Uc0yix+POVpYgIjqIhBnpr
         43U3a+Yb+hZbF5tVFKw7BRWvlgslaJyOsKW1/T+tpbx0Waxmun2LS1iUd7JCg7aoY0Rr
         PZhf3kfKi70CsnnWPAOibfG1/c5e1BCVIhQ+3VJ1MGY9kixRipgYrBA4AAzJ90wTQ6bS
         8cDg==
X-Received: by 10.194.216.39 with SMTP id on7mr6560356wjc.4.1370900825353;
 Mon, 10 Jun 2013 14:47:05 -0700 (PDT)
Received: by 10.194.17.9 with HTTP; Mon, 10 Jun 2013 14:46:45 -0700 (PDT)
In-Reply-To: <7vli6hg2ut.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227391>

On Mon, Jun 10, 2013 at 9:52 PM, Junio C Hamano <gitster@pobox.com> wrote:


> I think offsetting the actual commands to the right is correct, but
> "if these match" and "if this is empty" should be flushed to left as
> this patch shows.

I actually considered this and decided against it as it seemed to be
deliberate. Should I re-roll and re-send?

I will gladly re-send the whole, or part of the, series once I know
which patches are OK and which need more work.


Richard
