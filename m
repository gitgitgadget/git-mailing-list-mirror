From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-1.0
Date: Mon, 24 Sep 2012 11:19:14 -0400
Message-ID: <CAFuPQ1KW3HkxPCDDtzOB+UJWh6KiLSXQc1A_yQyMYrBvnP7VQQ@mail.gmail.com>
References: <20120510134449.GA31836@diku.dk> <CAK6bCaz7yPR0QmcOwY0iUP0hyisTf-bz=c0G_1nZkjCLDWDR+A@mail.gmail.com>
 <CAFuPQ1+22erJZ11fm1381-RPs0rKZr=EZJgZWQ1Jp00r6Wc8HA@mail.gmail.com>
 <CAK6bCawaqEvKFf43wzv+Yz5eem5W-qi9p1i+-9+jiMFs=tZ8xA@mail.gmail.com>
 <CAFuPQ1+6EkeVDmkQg-r0_KegDDmC0QnO4mtn0ad=4UK8G=9iCA@mail.gmail.com>
 <CAK6bCawuaYnd=YnevU6cXKmy=X9ExQ5kKxZopHC12+VTyPp-qQ@mail.gmail.com>
 <CAK6bCazQvYP8dgQzF5BY5+UNfGvm_SOcrVZoREdpszyrHOjEuQ@mail.gmail.com> <CAK6bCazoVPSmyGtU_7qWTZpfnmVikkZa1zAz9S02OwFN0qh1dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jean-Baptiste Quenot <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 17:19:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGARl-0001tE-Py
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 17:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264Ab2IXPTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 11:19:36 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:32890 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756241Ab2IXPTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 11:19:35 -0400
Received: by qcro28 with SMTP id o28so4392957qcr.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 08:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=ikopdIgesQBpnL0CsOBzqUkf4JRVHlsIAj+SW/BNwfg=;
        b=L9rKhNOjAk343hAHEGbm+QGhZd6U2SIDGRz+lqpedHveF8FOe9vJ0fXVVyrbH2kuWq
         r8sQ1q/oOI5fSxqkwG2HlsiV7MvNgcG/G6b38E6k2H4qWhtXQHTEHrj+QbSKvD2UIKrk
         l2qB/4KU35q3nFQquY89mkPdgVw70FDGXX7+FtJL7ViecUZtULEro89KRKQeigRfn8fn
         KOXg2b1zNcFEDdoz2AhjRYR47r5phk628cXTjF4aSon2nOn0IGe721+KJqhlJzBDCSqL
         1qS9Z3Xn58V+RNrqbkHLoWBliLiwQZ6lg+EzTOZ6xNtNs2SWlmOP2FdMLC+y5mPDs1JP
         C+KQ==
Received: by 10.224.218.65 with SMTP id hp1mr19747668qab.50.1348499975256;
 Mon, 24 Sep 2012 08:19:35 -0700 (PDT)
Received: by 10.49.119.73 with HTTP; Mon, 24 Sep 2012 08:19:14 -0700 (PDT)
In-Reply-To: <CAK6bCazoVPSmyGtU_7qWTZpfnmVikkZa1zAz9S02OwFN0qh1dg@mail.gmail.com>
X-Google-Sender-Auth: Irl0Bwi-rJCZc-r1oeTk80oRx_M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206284>

On Mon, Sep 24, 2012 at 10:57 AM, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
> This actually happens everytime I run a git command with a key
> binding, be it successful or not.  The main view is restored to the
> tip of the current branch.

If I have understood the problem correctly, you have a keybinding
mapping 'M' to `git merge %(commit)` or something like that and when
you type 'M', tig will list the commits in the master branch after
executing the external command.

I didn't account for this in the patch, and I will have to figure out
a way to disable the current behavior of reloading the main view after
executing an external command.

-- 
Jonas Fonseca
