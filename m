From: Kevin <ikke@ikke.info>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Mon, 12 Nov 2012 18:12:16 +0100
Message-ID: <CAO54GHC9ibTwxqLnk1vGSo9R011HE05JOL1mgpTGzeWX7cCcwQ@mail.gmail.com>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Douglas Mencken <dougmencken@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:12:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXxZ5-0007Kb-Vn
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab2KLRMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:12:38 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61115 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab2KLRMi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:12:38 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so4335248wgb.1
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 09:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=Wp27a6FbdGD9rMqYIrTcuk4ppftDbGk/R0FCts1KNzk=;
        b=BwcdSb+k/Yj3wJxl3iIljKq8Hle7kZI41/Gh3QNQE7EF7OXhJPOCXZWGySkwYN8ZBD
         sOAQIsK8QcW/RBvhzQuKMRUGb7YpoOQM/kW7BIoHSeGwu8J3tfsLtZKT5f7ZnXmBgqgE
         pZ+lTiz/HzpN3aXCoJZNoeMSKfhrzngTsHhdDZxERCfweCW3J+zivSAjNpqWWmvOZ+xd
         eIeM7VGhzJqWvVuNw1ogWKsAAcoiOSliZghqsgvOq/IbSOIOAM/Pz9fCb/gXJ5jPmHG6
         bsWCH9J6mvXO7DO/pqwTHszXACZlvojj99Rwj2tt2o0wmKVjClsO96EVuF40xnLN8++P
         tBBA==
Received: by 10.216.202.138 with SMTP id d10mr8641851weo.46.1352740356481;
 Mon, 12 Nov 2012 09:12:36 -0800 (PST)
Received: by 10.227.29.101 with HTTP; Mon, 12 Nov 2012 09:12:16 -0800 (PST)
In-Reply-To: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
X-Google-Sender-Auth: AQpNJlOt13AratwGw3Dh4lePfeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209489>

Maybe handy to say that you're on a Powerpc platform.

On Mon, Nov 12, 2012 at 5:32 PM, Douglas Mencken <dougmencken@gmail.com> wrote:
> *Any* git clone fails with:
>
> fatal: premature end of pack file, 106 bytes missing
> fatal: index-pack failed
>
> At first, I tried 1.8.0, and it failed. Then I tried to build 1.7.10.5
> then, and it worked. Then I tried 1.7.12.2, but it fails the same way
> as 1.8.0.
> So I decided to git bisect.
>
