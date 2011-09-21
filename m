From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [PATCH 2/3] branch: teach --edit-description option
Date: Wed, 21 Sep 2011 10:15:20 +1000
Message-ID: <CAH5451nai988=jB8cgFcUaQZWWUyALC-tOSV_jdLX0r_2UfbPw@mail.gmail.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
 <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
 <7vobynui8a.fsf@alter.siamese.dyndns.org> <7viposfgvd.fsf_-_@alter.siamese.dyndns.org>
 <7vy5xi4y3m.fsf@alter.siamese.dyndns.org> <7vty864y24.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 02:15:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6ATb-0004VG-Ky
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 02:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab1IUAPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 20:15:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49644 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab1IUAPl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 20:15:41 -0400
Received: by fxe4 with SMTP id 4so1039497fxe.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 17:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8jJlX0zGLPtHg7U4CiPZxH3RpWJnZuysSxwL8N4kWqY=;
        b=ov90qqjlea/KPQczDeyU7fbFqpEXhq96PgsCnF1Q+tbfQpZVXebH9kCBGVP2ULvJJo
         ir6sDcuYDBIEowybsSQO6djZ6f49gnJOKs/eE8+xC60hYdxVAm2UtpAtvOekJvUtw4m5
         xqlpraxGtthz8GRbH0kMHd/zRF4UjVwENEonc=
Received: by 10.223.64.66 with SMTP id d2mr2168358fai.116.1316564140357; Tue,
 20 Sep 2011 17:15:40 -0700 (PDT)
Received: by 10.152.37.66 with HTTP; Tue, 20 Sep 2011 17:15:20 -0700 (PDT)
In-Reply-To: <7vty864y24.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181808>

On 21 September 2011 09:02, Junio C Hamano <gitster@pobox.com> wrote:
> Using branch.$name.description as the configuration key, give users a
> place to write about what the purpose of the branch is and things like
> that, so that various subsystems, e.g. "push -s", "request-pull", and
> "format-patch --cover-letter", can later be taught to use this
> information.
>
> The "-m" option similar to "commit/tag" is deliberately omitted, as the
> whole point of branch description is about giving descriptive information
> (the name of the branch itself is a better place for information that fits
> on a single-line).

I understand your reasoning here, however is there a way to allow
setting the branch description in, for example, a script?

Additionally I can imagine it would be useful to be able to set the
branch description from another tool, what is the recommended way of
doing that? Should tools modify the config directly??

Regards,
Andrew
