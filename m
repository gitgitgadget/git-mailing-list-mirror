From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] compat/regex: fix typos in comments.
Date: Sun, 6 May 2012 14:55:48 +0200
Message-ID: <CACBZZX4K5vh7CjJ6SqX-reuuNqse7koONC=1HcXCuY0vbXRpbQ@mail.gmail.com>
References: <1336308300-4858-1-git-send-email-semtlenori@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Yi, EungJun" <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 14:56:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR10Z-0006AF-S5
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 14:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab2EFM4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 08:56:11 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59171 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab2EFM4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 08:56:10 -0400
Received: by eaaq12 with SMTP id q12so1171612eaa.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=25ZyjIQbAVOBqnFTvtA4ki5vTXozzJQYq960JMwivKU=;
        b=x+IB1B29Spx5iUFOnWS+4gvGRrVLfg5pj5Ks5xH5rIYkSl+RR7Qcrb0Q9XV90nn1ad
         35b8hLcRpgZ/dTprDet4eaS2c/Vhg3rPk0yRL95r97mII13EHnpwpbSDNHo+1EH++UM3
         s3/4JmyVaPPnPgv8g0RYo/IV3XP83MmcpohvXEgcQ5UBikolzpUyevYqf69MBuCOq5r+
         i6Idic/tIV70NRkt0fC0qNae/Gaq4qfHgV3IHqsqm7uf5VT3IKI8rxqo+zo7Ren49gmv
         MuEvgjyMdwIDro54iWmx/xGDBRIGtQTKwXYhggvPKwGT12c4HXSwnfayEFvyLNuyF3Z/
         h6/g==
Received: by 10.14.127.204 with SMTP id d52mr2132152eei.18.1336308968913; Sun,
 06 May 2012 05:56:08 -0700 (PDT)
Received: by 10.213.108.81 with HTTP; Sun, 6 May 2012 05:55:48 -0700 (PDT)
In-Reply-To: <1336308300-4858-1-git-send-email-semtlenori@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197180>

On Sun, May 6, 2012 at 2:45 PM, Yi, EungJun <semtlenori@gmail.com> wrote:
> From: "Yi, EungJun" <semtlenori@gmail.com>
>
> occured => occurred

In d18f76d I changed compat/regex to use the engine from gawk, there
have been a few fixes of ours to it since then, some of which may be
applicable for upstream inclusion:

    $ git --no-pager log --oneline --reverse d18f76d.. -- compat/regex
    a997bf4 compat/regex: get the gawk regex engine to compile within git
    de83172 Change regerror() declaration from K&R style to ANSI C (C89)
    b50f370 compat/regex: define out variables only used under RE_ENABLE_I18N
    178b331 compat/regex: get rid of old-style definition
    ce518bb Fix compat/regex ANSIfication on MinGW

But I don't think we should be taking patches like these. I think they
should instead be sent to the upstream gawk developers who I'm sure
would be happy to take them.

But this is not code that we're maintaining, and patches like these
just make it harder to merge the code from upstream.
