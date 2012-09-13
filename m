From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sound fixes for 3.6-rc6
Date: Thu, 13 Sep 2012 19:51:14 +0800
Message-ID: <CA+55aFyo6do-dZiZMiwZkN1Ko+W58+4-zkbfJnpQR+ufw=+8ig@mail.gmail.com>
References: <s5h392m1728.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Takashi Iwai <tiwai@suse.de>
X-From: linux-kernel-owner@vger.kernel.org Thu Sep 13 13:51:53 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TC7xU-0000Wz-9v
	for glk-linux-kernel-3@plane.gmane.org; Thu, 13 Sep 2012 13:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757710Ab2IMLvi (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 13 Sep 2012 07:51:38 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57980 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757686Ab2IMLvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Sep 2012 07:51:36 -0400
Received: by wibhr14 with SMTP id hr14so3449981wib.1
        for <multiple recipients>; Thu, 13 Sep 2012 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=/gf6i4fT0tjL1DfvMZ1i4iRljHV8/nR650Z+92oBlfg=;
        b=kiuGwbhTrhWXMg5TzGv0t8w1xoqNGq8OVRE19LoTbi58oq65T3QezsinWvox2J0/Mk
         zw4OshQKcCJFy+l96J7+Gu9q5rkWYelhRqCf3CRv8KQjHPKaGaISi5bHzgWpSTINvxQ7
         ttJ06edQvICAGulFXGw9tS7JIpYcVv60jXcfMwJsIZw+a9MFdVEyD88X6sLGMhuv2OfP
         5YYQSRxQaiaOfGjhfhmASDAZfXc7ziDbrjE3oe5gFA6XQI05UVpLUK6Opc3zk1CFgHeb
         8ZWAui/iZJ8ICGc8Dgi4PMBtSNxwXP+33gqnxkqscTvGphLAp6h4RGaKpiWhOte9BG27
         kCqg==
Received: by 10.180.94.38 with SMTP id cz6mr4362310wib.10.1347537094930; Thu,
 13 Sep 2012 04:51:34 -0700 (PDT)
Received: by 10.216.109.2 with HTTP; Thu, 13 Sep 2012 04:51:14 -0700 (PDT)
In-Reply-To: <s5h392m1728.wl%tiwai@suse.de>
X-Google-Sender-Auth: ZoWugGHafZeD45BrxIdBa3lZk3o
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205363>

On Thu, Sep 13, 2012 at 7:43 PM, Takashi Iwai <tiwai@suse.de> wrote:
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-linus

*PLEASE* don't do this.

You point to a branch, but then the pull request clearly implies there
is a tag with extra information in it.

And indeed, the actual thing I should pull is not at all "for-linus",
it seems to be your "tags/sound-3.6" tag.

I don't know if this is the old "git pull-request" breakage where it
stupidly "corrects" the remote branch when it verifies the branch
name, or whether it's some other scripting problem. I think current
git versions should not mess up the tag information, if that's the
cause, but please verify.

            Linus
