From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/6] transport-helper: clarify pushing without refspecs
Date: Wed, 17 Apr 2013 17:14:44 -0700
Message-ID: <CAGdFq_j-Z-HCxLQwYEK3esuipUGLy6kNqZzSH+CQxQbkiAR6Cg@mail.gmail.com>
References: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com> <1366243524-18202-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, Max Horn <max@quendi.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 02:15:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UScVe-0000nq-5w
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 02:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935697Ab3DRAP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 20:15:26 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:37136 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935433Ab3DRAPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 20:15:25 -0400
Received: by mail-ia0-f174.google.com with SMTP id m10so10170iam.33
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 17:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RJVapPAfPBttddr1UMvMPGmGcVL4WylsKRK/cR4T4l4=;
        b=t+EztWcgPaLqV+ltzAFukmYTBSGWrbHF0yOGJQyYpejRvT6MxpMoih+f+94vjVv3oF
         Cc0TxxKkHqRgWxwJHEQr4BDO7zE9M0HudNmsraFOJgyIe+jLRuE0ZVcGy3eWE0o0+Lz+
         kDoPldflJBW8GrHwvXHrt8ek0QZHOfa5DjuOmgqsyxGk+CYYKwzvFhG2L8yM+dnGS4J3
         2aciiQBJVCZMyB8PYhvdUepjlG40TPxw/8ksqzojE4t/UUyYGvnCCftasfpr6YUlOyqr
         zhq5xN5DgnpLfi4Z5MbeiEts0OvJaIsm5xWYsUODp4cjVcWQtIJ1hqNkHCKg12L7H0/9
         B43Q==
X-Received: by 10.50.100.201 with SMTP id fa9mr11444151igb.28.1366244125019;
 Wed, 17 Apr 2013 17:15:25 -0700 (PDT)
Received: by 10.50.157.229 with HTTP; Wed, 17 Apr 2013 17:14:44 -0700 (PDT)
In-Reply-To: <1366243524-18202-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221595>

On Wed, Apr 17, 2013 at 5:05 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This has never worked, since it's inception the code simply skips all
> the refs, essentially telling fast-export to do nothing.

Makes sense.

--
Cheers,

Sverre Rabbelier
