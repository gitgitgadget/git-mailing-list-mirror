From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/6] t/checkout-last: checkout - doesn't work after rebase
Date: Fri, 14 Jun 2013 00:00:54 +0530
Message-ID: <CALkWK0nH5Qjc-PNNH0cAhsgZje7VzuLGqXZwjRQESOxLt-T78g@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-2-git-send-email-artagnon@gmail.com> <7vfvwlvr7e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 20:31:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnCJI-0002Hq-Mv
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168Ab3FMSbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:31:37 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48796 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759161Ab3FMSbf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:31:35 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so11565916iec.19
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=y8Vad+mge9rj79qUggrod7xK53KWsYBU4ejPvDL3yKU=;
        b=yPec6YxsgmZsigQ5u8KK/ZuG+eJ4ua8dyJTQ91Y2cwBxddqUuLu2SiooeSD/UbeEHL
         5MIOXn2T7kwP4SyZoNsl6PIy50fihkJDi42VumLFZMis9+xzbA4ZfZ+GcvIDtoSO7PXl
         w67ssuPThqERZHj0xIkKpoZnE060FwbVc/DTZ+H4FBRNXrjbiAq4UBrROpDmMJoNQ49c
         BuFISYRZdY0OAxjnJgMbGwwOH08s4+0kPaEmSUIURiOzG3JK3H+1GjqyqnPA3VTwVERx
         jHzJx0xtBhWVxvvHatbiht2Y74IB/YljOMlp2GnF7VsSwnfB22EHtqKAtq02PW+FMHBn
         jieA==
X-Received: by 10.50.154.106 with SMTP id vn10mr6158823igb.0.1371148294777;
 Thu, 13 Jun 2013 11:31:34 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 13 Jun 2013 11:30:54 -0700 (PDT)
In-Reply-To: <7vfvwlvr7e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227770>

Junio C Hamano wrote:
> Why two?

What breaks checkout - is the initial HEAD detachment (which writes
that "checkout: " message), before anything else happens.  None of
<onto>, <upstream>, and <branch> make any difference: I'm testing
exactly the code that I patched.

I have recently been told that I should be testing "end-user behavior"
by treating the programs as black-boxes, instead of "implementation".
What is your opinion on the issue?  Should I write more tests?
