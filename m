From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git-http-backend with hooks
Date: Sat, 26 May 2012 21:59:13 +0530
Message-ID: <CAMK1S_hG7+5MU00UZouBs6+7JvHfxf-b5z=HKuJhioWPsc+aNw@mail.gmail.com>
References: <4FC0E4AB.5050103@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Tajti_=C3=81kos?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Sat May 26 18:29:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYJrr-00044y-5j
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 18:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab2EZQ3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 12:29:18 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56551 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab2EZQ3O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 May 2012 12:29:14 -0400
Received: by obbtb18 with SMTP id tb18so2832353obb.19
        for <git@vger.kernel.org>; Sat, 26 May 2012 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mvcYkRLaL1tD0XeJ/dYHZbmpoh4H5PT8Pid42LxxSOs=;
        b=vx09XAJvVbtw/LzkBKiszhDf9csrUd/tBFMMIgdFnmkJPE3nSjqKO+C09wCTyoKb82
         om/N754kKBXL8wdrcPih3MvoAHW2E6vyI9zC5gVOTMv7be+g1hZBD5uNAlm6jqI7sgOW
         ODrdYH3qtnj1/4pou2OvlNsViiDqxtV5lZK0MV6ZUa9yZbEXforddAzxdWNHKibtAZu1
         YgfMmowC8Bj5v7jDRPxtV89LsqiTy8dbt8c+XsMOS7iAoiTnjkDBABaH3zrehCGFAiTs
         h5+ZMWZ9Zer2CxNKi3Xk/tmTW8BJPgjaWJpZPAwKfA2E+yiSMmd6m8o1BiT0dhiqKIaE
         oEDg==
Received: by 10.182.2.193 with SMTP id 1mr2779327obw.46.1338049753461; Sat, 26
 May 2012 09:29:13 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Sat, 26 May 2012 09:29:13 -0700 (PDT)
In-Reply-To: <4FC0E4AB.5050103@intland.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198565>

On Sat, May 26, 2012 at 7:41 PM, Tajti =C3=81kos <akos.tajti@intland.co=
m> wrote:
> dear list,
>
> we wrote a script that is basically a proxy before git-http-backend. =
All git
> requests go through this and if some criteria is true then they're pa=
ssed to
> git-http-backend. We also have hooks in our repositories. The problem=
 is
> that in some cases we don't want the hooks to run. Is it possible to =
somehow
> tell git-http-backend that the hooks shouldn't be run?

set an env var in your proxy (before it passes to git-http-backend)
then test for that in the hook code and exit
