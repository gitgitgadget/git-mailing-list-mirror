From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git gui replaces amend message when prepare-commit-msg hook is used
Date: Thu, 4 Jul 2013 14:42:40 +0200
Message-ID: <CALWbr2zAt4a6vkQy8PhP-dH5eZ9_5VMzbiWqSEKE_1V5rsfh+A@mail.gmail.com>
References: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
	<20130704103440.GH9161@serenity.lan>
	<CAGHpTB+ObJjqvQ-xfQOdGG+ZSZdCijVZXh1NBp97TZ=hO-QVgQ@mail.gmail.com>
	<20130704111901.GI9161@serenity.lan>
	<CAGHpTBJzwuPw6u=DKUkik5w=hQoCF3F_4wqjuU3UJ528gfcdpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, git <git@vger.kernel.org>
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 14:42:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uuis1-0005LD-NX
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 14:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575Ab3GDMml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 08:42:41 -0400
Received: from mail-qe0-f41.google.com ([209.85.128.41]:49735 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab3GDMml (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 08:42:41 -0400
Received: by mail-qe0-f41.google.com with SMTP id b4so725972qen.28
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HvoU9wTT36xsBri9d69qfMQashre3ogL79sFjmBGZGg=;
        b=VNUj3xAtOMiSh2aaq6lTOTwhQxyBgn8ZSMQfzzBgvCquzLvGu7qx+cOqzb7inNmLdh
         wv/itdJpnHBdtwC/HmDB/AHJGLsuX8wZR1ytjE43FbI2NBcTjXM4bXmJVo8f99wZqyJo
         nGulqCmmEENAmq2y9h2VXLycDr60XiqqMpsYNepAJOoQoZydFcJuM6Dc7nm7rmoKmQLx
         BJlI+xwdWT/MxAsUBxQOIHDLLvHD1G0Tr4rsf19zpv6eLa8rBcfYjkfnEIDe0ilJ74Nr
         gCZSoR6WEElv69x5lTAMDz25yK9WQZ79JmE757/E4Cxxq7DpVSZwL16tprbxw1iAlaxl
         pWnQ==
X-Received: by 10.49.48.83 with SMTP id j19mr4838880qen.56.1372941760216; Thu,
 04 Jul 2013 05:42:40 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Thu, 4 Jul 2013 05:42:40 -0700 (PDT)
In-Reply-To: <CAGHpTBJzwuPw6u=DKUkik5w=hQoCF3F_4wqjuU3UJ528gfcdpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229574>

>> Your problem is that your hook script is not checking $2 so it is
>> overwriting the message even when you do not want to do so.
>
> No, it isn't. Not by git-gui at least. Check /tmp/hook.log with the
> hook I provided...

So what you mean is that the hook is not executed with the correct parameters?
Could you please provide the output of the /tmp/hook.log file (I can't
reproduce right now) ?
