From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/7] rebase -i: return control to the caller, for housekeeping
Date: Thu, 25 Apr 2013 20:00:44 +0530
Message-ID: <CALkWK0n6gDTBk0G+gm6UHgMb_ueLGMZQyYVP_D24G8uXCyjXvw@mail.gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
 <1366725724-1016-6-git-send-email-artagnon@gmail.com> <CANiSa6hmh1d7ECBCAm+AKFV4KXh7eoHfk7pL0RjaqZj4XbKhpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 16:31:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVNCs-0005Sk-KJ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 16:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137Ab3DYObZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 10:31:25 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:53944 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757413Ab3DYObZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 10:31:25 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so2667077iar.30
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8R5Wu0wkU3HnmkHhyos/xOEeh7GnGM3aXiQ0jJAJTvk=;
        b=oo5imlqPQSVuK13GdYtXs0bWdJtrgXWq2ajkz5Hht3gH40064lHX+rVXhtMPwxtOCK
         2khfApD9VnqdwzIHSsgr9HCFAUDI/FYQZVKu6Fmi6SfIcxMraEMM4R52b6oqdISWFUdx
         LKGD+23TTeIMHQTnrjVIpEG1LthNwsPTxP9KH/0CY/WpFAIFGGw+Pw8imAgFSbkuLIWI
         V88lfdNXREecwhCppOXFtgOu7jaQZcew2qzmQOWeTt64edUwWGV3BLqYpR1pCnj8HOaq
         Oj2ChI0ipRdum9WLSAA55PnkP7QMxxSP9zQPzjp62fbQceT6Awhf6016QzFPxor/b7VF
         DkPg==
X-Received: by 10.50.66.197 with SMTP id h5mr8616341igt.63.1366900284832; Thu,
 25 Apr 2013 07:31:24 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 25 Apr 2013 07:30:44 -0700 (PDT)
In-Reply-To: <CANiSa6hmh1d7ECBCAm+AKFV4KXh7eoHfk7pL0RjaqZj4XbKhpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222384>

Martin von Zweigbergk wrote:
> Normally one would break if unsuccessful. What would fail if this was
> replaced by "do_next || break" and the above ".. && return 1" was "..
> && return". I assume that was your first attempt, but why did it not
> work?

Thanks.  This was a major thinko on my part, but I don't remember
exactly why I got confused.  I'll explain this patch properly in the
next iteration.
