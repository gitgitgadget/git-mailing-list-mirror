From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] de.po: Fixup one translation
Date: Thu, 25 Sep 2014 22:20:57 +0200
Message-ID: <20140925202057.GA27696@ralf-ubuntu>
References: <CAN0XMO+D7dDh_Xpcgekg3fsDA9Zhh+i7Asi46G3aBpnknivNjA@mail.gmail.com>
 <1411476886-13141-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, ralf.thielow@googlemail.com,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 22:21:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXFXG-0006Qy-G5
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 22:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbaIYUVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 16:21:01 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:52116 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbaIYUVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 16:21:00 -0400
Received: by mail-we0-f173.google.com with SMTP id x48so7179973wes.4
        for <git@vger.kernel.org>; Thu, 25 Sep 2014 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NQvZWGxTUp3LRKspWIPdZNrTKfjmPHmsgmg36OM85X4=;
        b=p2Yn1JNGUXG5pfu//au711Dqj9+RVwN8xQk5ZR9NUnaaCGhF88BjBF2FmncbPqWe91
         PpUKgfNxdlg5v5Mmkvb9SBprCeNiOF+dLvpVLKDUTpMNssmbU0wK/jXcV0gXCft/UIpe
         woAH939j3qw11nD65JxyRPDZdhHzJDys7Ohs1Wf4Rw+wDfxIQv8/6nW42ghp3M0hhIBB
         aXSOse0dRezW8aBB+Hx/MEvEkyWoVi+iths4SXY6BJiqftoVDgYT77pAYaMw8qZ6Ez6x
         ob3YS23YKdp0sdj5TpQ3I4SSuy/rEyC7LhNyi00RlzWgZwmmeTVwzD7KKaPIhgXcIjgA
         D2KA==
X-Received: by 10.180.210.201 with SMTP id mw9mr42228339wic.35.1411676459202;
        Thu, 25 Sep 2014 13:20:59 -0700 (PDT)
Received: from localhost (dslb-178-000-162-213.178.000.pools.vodafone-ip.de. [178.0.162.213])
        by mx.google.com with ESMTPSA id fl6sm4278241wib.21.2014.09.25.13.20.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Sep 2014 13:20:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411476886-13141-1-git-send-email-stefanbeller@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257495>

Stefan Beller <stefanbeller@gmail.com> wrote:
> English grammar with German words doesn't make it a German translation. ;)
> 
> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> ---
> Here we go again without sentence fragments.
> 
> Thanks,
> Stefan
> 
>  po/de.po | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/po/de.po b/po/de.po
> index e5d2b25..bae3723 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -3463,13 +3463,13 @@ msgid_plural ""
>  "\n"
>  "%s\n"
>  msgstr[0] ""
> -"Warnung: Sie sind um %d Commit hinterher, nicht verbunden zu\n"
> -"einem Ihrer Branches:\n"
> +"Warnung: Sie sind um %d Commit hinterher, folgende Commits sind in\n"
> +"keinem Ihrer Branches enthalten: \n"
>  "\n"
>  "%s\n"
>  msgstr[1] ""
> -"Warnung: Sie sind um %d Commits hinterher, nicht verbunden zu\n"
> -"einem Ihrer Branches:\n"
> +"Warnung: Sie sind um %d Commits hinterher, folgende Commits sind in\n"
> +"keinem Ihrer Branches enthalten: \n"
>  "\n"
>  "%s\n"
>  

That are two sentences. I'll queue this:

-- >8 --
From: Stefan Beller <stefanbeller@gmail.com>
Date: Tue, 23 Sep 2014 14:54:46 +0200
Subject: [PATCH] de.po: Fixup one translation

English grammar with German words doesn't make it a German translation. ;)

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/po/de.po b/po/de.po
index e5d2b25..fe940d1 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3463,13 +3463,13 @@ msgid_plural ""
 "\n"
 "%s\n"
 msgstr[0] ""
-"Warnung: Sie sind um %d Commit hinterher, nicht verbunden zu\n"
-"einem Ihrer Branches:\n"
+"Warnung: Sie sind um %d Commit hinterher. Folgende Commits sind in\n"
+"keinem Ihrer Branches enthalten:\n"
 "\n"
 "%s\n"
 msgstr[1] ""
-"Warnung: Sie sind um %d Commits hinterher, nicht verbunden zu\n"
-"einem Ihrer Branches:\n"
+"Warnung: Sie sind um %d Commits hinterher. Folgende Commits sind in\n"
+"keinem Ihrer Branches enthalten:\n"
 "\n"
 "%s\n"
 
-- 
2.1.1.446.g43bbf76
