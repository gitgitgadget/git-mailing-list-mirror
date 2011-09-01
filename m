From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] (short) documentation for the testgit remote helper
Date: Thu, 1 Sep 2011 13:27:57 +0200
Message-ID: <CAGdFq_grmJLoTt7JMUuoXrd02Gx8JdcEL-wa7YQ=-FkurRqfWA@mail.gmail.com>
References: <1314809222-30528-1-git-send-email-Matthieu.Moy@imag.fr> <1314814498-13699-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 01 13:28:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz5Rt-0006hX-UV
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 13:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757114Ab1IAL2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 07:28:38 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39029 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab1IAL2i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 07:28:38 -0400
Received: by yxj19 with SMTP id 19so266525yxj.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ti54qH0lmD7pfN3utO4go9b+MuKE8YZOC0YLFNeSQ4s=;
        b=JrNhzj6gAEBt1gdfod0sJd0JSJ0XmhbURGOySalrgQB4GR7N4xKEiRqnTnsDFZU9Kp
         pta9vKOqf4MwKXt1oz4waZQnPKZBUKx87oFlsG2AEnLk9mRgcfrhbfzBzXvDKMWRSp5e
         uYve1A9FPOW7zKZYxQa9quyHUm64nCRV8rEuQ=
Received: by 10.68.28.103 with SMTP id a7mr166611pbh.160.1314876517050; Thu,
 01 Sep 2011 04:28:37 -0700 (PDT)
Received: by 10.68.43.9 with HTTP; Thu, 1 Sep 2011 04:27:57 -0700 (PDT)
In-Reply-To: <1314814498-13699-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180529>

Heya,

On Wed, Aug 31, 2011 at 20:14, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> +# To understand better the way things work, one can set the variable
> +# "static int debug" in transport-helper.c to 1, and/or the "DEBUG"
> +# variable in git_remote_helpers/util.py to True, and try various
> +# commands.

Both are controlled by an environmental variable, it would be better
to mention these directly.

I think that for remote-testgit it is GIT_DEBUG_TESTGIT=1.

Other than that:

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

-- 
Cheers,

Sverre Rabbelier
