From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] branch, commit, name-rev: ease up boolean conditions
Date: Tue, 6 Aug 2013 14:46:34 -0400
Message-ID: <CAPig+cR05=vfutGJ1pB7JbOV9-rrtwwEeondWCBDs6Av94tTkQ@mail.gmail.com>
References: <5200F3D6.5040004@googlemail.com>
	<1375794434-12257-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 20:46:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6mHM-0005Pt-Aw
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 20:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612Ab3HFSqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 14:46:39 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:56775 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307Ab3HFSqi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 14:46:38 -0400
Received: by mail-lb0-f169.google.com with SMTP id u10so782401lbi.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GN86VW45/BM2Fu+suPlfMEu7PGRiZxhF4KbGRYw/ygo=;
        b=A92Mvp1USiySXn11SL9Yin2zhKIfjzJ7RWHxCuq5JpmfeA9v8CFQeEYeiJ6KnXE/Ne
         x1GEy8mxlMvv3W1so8QR7VEdK8mPcetzs59Al6zPpRB97RsulPooiSaxYbADBB3YvvoJ
         TGiYPVvJ9QtF586j07SvZvvOi60S1iVbHaUKs9Il3h/sdeyTVgd1un3fISjo1Hc/xgLr
         uX7wVg+rF+I/a/ee40eB+iKQylROqOl5qhzlTM89BnlmJqiiGQejXVRO/zo/eUue8KzT
         mMCppVKLUMmU8iSF6VcjzMlqIygO8uxu5nRSVdO74bz1Yc083cZTc+4ofdEPvva9glIH
         ZIpw==
X-Received: by 10.152.18.229 with SMTP id z5mr1338664lad.31.1375814794673;
 Tue, 06 Aug 2013 11:46:34 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 6 Aug 2013 11:46:34 -0700 (PDT)
In-Reply-To: <1375794434-12257-1-git-send-email-stefanbeller@googlemail.com>
X-Google-Sender-Auth: F3QAIRAI6U5Eysg4yCgH4rWsZmY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231775>

On Tue, Aug 6, 2013 at 9:07 AM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> Now that the variables are readin by OPT_BOOL, which makes sure

Do you mean s/readin/read in/ ?

Or should it be s/readin/set/ ?

> to have the values being 0 or 1 after reading, we do not need
> the double negation to map any other value to 1 for integer
> variables.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
