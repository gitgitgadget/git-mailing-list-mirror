From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 43/44] builtin-am: check for valid committer ident
Date: Wed, 1 Jul 2015 14:43:16 +0800
Message-ID: <CACRoPnRH_Wr=pVF-3yp70hhB4AvcfCF91yrh+eeKzyq9Oxh38Q@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-44-git-send-email-pyokagan@gmail.com>
	<CAGZ79kaUYS1kiiFTwTTA=Wh924JcHMLOU61mSuMZxiqZFO7PPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 08:49:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZABq7-0006T5-GK
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbbGAGnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:43:23 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:34721 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbbGAGnR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:43:17 -0400
Received: by lagx9 with SMTP id x9so34095850lag.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eO71NTjPq3HFN6/CECH5JuLhchYQj/12+S0kQwrllag=;
        b=UaLw1+tNGHVr2od/mgt4GqSY6VQpO2KG/McOz70IaCzg7YmkvW+L8lVMrptU+I6tpC
         fIPsaAFqouglXjNYY3leSVVbGNTcBYbWsqF6VT4Ano1g/Rq7BjXHGg57GZyd0agIgGzT
         6yBoZp9mr181pyh9nQPYLPaKUmEi+2ca53Bc4qHWCzgRoO9z+r3L4wMvSTWSEz5YFGHe
         yy6g85aVNBviaPPbTQjJQZCemXfgdTYkQOjZqQeO4RmRlVbIV0ct3n0iql5ujaoSfGCF
         Bf8Fx0YQG+HMXOLvM1cI0rPeAkgqsEU/Nr/KXl9LIwslHK0f4pw/EjpC9fY3ZNsj8/3D
         f9oA==
X-Received: by 10.112.142.232 with SMTP id rz8mr22795109lbb.74.1435732996240;
 Tue, 30 Jun 2015 23:43:16 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 30 Jun 2015 23:43:16 -0700 (PDT)
In-Reply-To: <CAGZ79kaUYS1kiiFTwTTA=Wh924JcHMLOU61mSuMZxiqZFO7PPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273133>

On Tue, Jun 30, 2015 at 4:02 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Jun 28, 2015 at 7:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> When commit_tree() is called, if the user does not have an explicit
>> committer ident configured, it will attempt to construct a default
>> committer ident based on the user's and system's info (e.g. gecos field,
>> hostname etc.) However, if a default committer ident is unable to be
>> constructed, commit_tree() will die(). However, at this point of git-am,
>
> s/. However,/, but/ ?

Yeah, thanks.

Regards,
Paul
