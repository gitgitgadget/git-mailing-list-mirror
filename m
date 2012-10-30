From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 14:17:57 -0700
Message-ID: <CAGdFq_jJwZMLq=3co13hs7gas6y9kZRTKwcT+CP=n6-24Uv5Og@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
 <1351617089-13036-5-git-send-email-felipe.contreras@gmail.com>
 <CAGdFq_j1RROOwxDi1FfJZJ6wiP9y9FWzSpc7MXVSvRmgk0sF9A@mail.gmail.com> <CAMP44s3MHrG_XeZEodnxemrW-V18+NHnFvi7koyx9mH8XuHc6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ">" <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:18:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJD1-0002Gr-NA
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934642Ab2J3VSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:18:39 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64719 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934639Ab2J3VSi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:18:38 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so756114oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dyYcVc0ZJQyV2UMZnVWb28tQ0kAGdiJzf3Js3kwWukc=;
        b=BoJeBDiYrgqLoSLZ9v5gNX/GU0NXPPtp5Js1ZbcJ15aSI14/NzmmD4skzi2I2lCcrP
         kf3I8+inRrCktp9q5ow3zLWNEWHemVob0EkPDZffz/0YtOnaeoluRIBtiKzStrx+Q0t7
         itw5zQCPMoKhLhVDst5kHZo8O4ANRvOkoCcijbiAs9REMZ+VlmlhEUZhCrTFgTaus0dk
         /CYmwTpylGHYKLP1QmL6kwTGPYS8hIFVjR6INVy5kaVIE0hiuzt3uzlKnEx2vKBOqiuN
         pFtJp9cvEac+tv2t1UhhI0te65x58JtuUIRKq9XlfdUbQEATIexNxHYpVC8bYhyFDnH9
         F9MQ==
Received: by 10.182.64.114 with SMTP id n18mr16734078obs.95.1351631917365;
 Tue, 30 Oct 2012 14:18:37 -0700 (PDT)
Received: by 10.60.95.97 with HTTP; Tue, 30 Oct 2012 14:17:57 -0700 (PDT)
In-Reply-To: <CAMP44s3MHrG_XeZEodnxemrW-V18+NHnFvi7koyx9mH8XuHc6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208738>

On Tue, Oct 30, 2012 at 11:47 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Why would it? We are not changing the way objects are exported, the
> only difference is what happens at the end
> (handle_tags_and_duplicates()).

Because the marking is per-commit, not per-ref, right? Perhaps you
could add a simple test case to make sure it works as expected?
Something along the lines of the scenario I described in my previous
email?

-- 
Cheers,

Sverre Rabbelier
