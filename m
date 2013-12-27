From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 19:58:19 +0600
Message-ID: <CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 27 14:58:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwXvp-0001zQ-1Y
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 14:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab3L0N6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 08:58:20 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45608 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab3L0N6U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 08:58:20 -0500
Received: by mail-vb0-f46.google.com with SMTP id w20so4824416vbb.33
        for <git@vger.kernel.org>; Fri, 27 Dec 2013 05:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AN9Kjfiw0bsMb87dOAvlc/ndK++o4QtKqSzROL5AYmo=;
        b=KT+u/G1md6Hmc+ZuWE6TK6aK5OFluSWeKfbKK8RCA7vI5AFcyppAsCtywBKhKFUkcg
         dbDUlaWLVdemKDPbQUYqVqW8Hf2p2WlKtXwioaj/KVJxCmfh49OFgX3S5oVePDWhD61p
         m/t84ZQ8upzB1wCjkaBl7bvcbeFOEP1pJVqwgpmq7tVDkCraA59tO+unlmlPvV4KKh1L
         SdrdSvJ9aeytohkrC1SBfbn11rt2x6neqWPiwhFEmO27BAxt/i13AWJ5IyJHgoDDEFV3
         yFE4REI3M5D1d9otuYew098u696ooQ5TKVIUMPJekbeE1tEXeORycDc3gjO5T5dyGKXf
         qVOA==
X-Received: by 10.58.216.133 with SMTP id oq5mr1477520vec.80.1388152699222;
 Fri, 27 Dec 2013 05:58:19 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Fri, 27 Dec 2013 05:58:19 -0800 (PST)
In-Reply-To: <20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239728>

Hi,

On Fri, Dec 27, 2013 at 7:36 PM, Konstantin Khomoutov
<flatworm@users.sourceforge.net> wrote:
>
> The Git protocol does not implement it itself but you can channel it
> over a TLS tunnel (via stunnel for instance).  Unfortunately, this
> means a specialized software and setup on both ends so if the question
> was about a general client using stock Git then the answer is no, it's
> impossible.

Ok, got it.

> Yes, but it will only be secure if you've managed to verify the
> server's certificate and do trust its issuer (or a CA higher up the
> cert's trust chain) -- people tend to confuse "encrypted" with
> "secure" which is not at all the same thing.

We've got CA-signed certificate atm and it's about to be also
EV-signed for our server (git.blender.org). So this is not gonna to be
an issue. Cloning over https:// works fine, but we wanted to be sure
all the bits are secure.

So guess we just need to recommend using https:// protocol instead of
git:// for our users?

-- 
With best regards, Sergey Sharybin
