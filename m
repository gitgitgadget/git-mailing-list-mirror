From: John Szakmeister <john@szakmeister.net>
Subject: Re: Rename edge case...
Date: Fri, 9 Nov 2012 05:25:26 -0500
Message-ID: <CAEBDL5WeQEWdyaJuuNbnnQbbsLYv8NO1ZSj3eHHpjW+ToS9X1A@mail.gmail.com>
References: <CAEBDL5U+OSTCAqgWoApE_m21Nef24Wqvt78oB6qqV4oEvU0vXQ@mail.gmail.com>
	<1352453243-ner-1164@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 11:25:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWlmQ-0008Au-Bb
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 11:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162Ab2KIKZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 05:25:29 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:39294 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab2KIKZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 05:25:28 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so2835742lag.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 02:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=9guzfB4kZnaXxif/aG3o9wxAy442NLgY65htWlzEgMI=;
        b=extX6GRRnbcHOQjbgwuPAzyWHIxOsDw552ldhtqmA+TG5BRCBPPbbl8d601lC7gdAE
         HLff+JkZlioXrFJZzyG4J5j1IZRbmkW99XFtpFVeG48NS1dTMtJS/8j+7BObTX7Tz+lJ
         mD5bZtW9v6IjAitbwXl2i2gGWT3VfYS+/gGCw6TSmNbZKTeIL4KHnXQ47ESlzBtxLLNs
         G3PAj98aK2tUYesqmayDmxRDD49niIgdOwjNKBYoMeOUj/MHsjPkl3HDUNF0qps8Ptfc
         GDSGXOFiNccFmBju9OvrhphpXr+UXGWoMOiIyaASf8xV8Dw6as7Zv593NywCt2RgL768
         sv4g==
Received: by 10.152.114.100 with SMTP id jf4mr10316198lab.47.1352456726299;
 Fri, 09 Nov 2012 02:25:26 -0800 (PST)
Received: by 10.112.162.39 with HTTP; Fri, 9 Nov 2012 02:25:26 -0800 (PST)
In-Reply-To: <1352453243-ner-1164@calvin>
X-Google-Sender-Auth: pjL8EgTANJnq8fW7iwViE8PvVe0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209211>

On Fri, Nov 9, 2012 at 4:27 AM, Tomas Carnecky <tomas.carnecky@gmail.com> wrote:
[snip]
> When merging two branches, git only looks at the tips. It doesn't inspect
> their histories to see how the files were moved around. So i doesn't matter
> whether you rename the files in a single commit or multiple commits. The
> resulting tree is always the same.

I guess I figured that when I saw the final result, but didn't know if
there was a way to coax Git into doing a better job here.  I guess not
though.  At least it's a situation that doesn't come up often.

-John
