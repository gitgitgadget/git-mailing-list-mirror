From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [ANNOUNCE] Sharness v1.0.0
Date: Tue, 14 Jun 2016 23:13:31 +0200
Message-ID: <CAP8UFD2wT0Qoxksza1uU1GMTWRD4GcfdYzDTrNh+JLtfT9h3rA@mail.gmail.com>
References: <CAP8UFD0uvaB-2_CrXs2ZvoqLRHfCd8efA-S7-tE2Qa6Pn+rAAg@mail.gmail.com>
 <CAGZ79kYaQTdVoXOGpKbQmWsdRftY10TBZTTf_Ya-fdegykU-QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Mathias Lafeldt <mathias.lafeldt@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 23:13:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCveV-0001Gj-03
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbcFNVNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 17:13:35 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35035 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbcFNVNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 17:13:34 -0400
Received: by mail-wm0-f52.google.com with SMTP id v199so138110610wmv.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TVQi5KQ/I+2laNFCDmyfJCzVGWbY5N0WpIK/yNnJ4mc=;
        b=cwbEaHhxiHNFQDPLgWWU6JeeMwqirr1qWDcc8qwP2OVm+Y4NbKamvTjUUs2KFO2ijM
         tPRlUYUXnSp0QeYLlA48CobKp7nZ8hzI1wH8EWclQYHZFT75OXbMww5VEcOMihH2C4t7
         p6/oZLrTQWY0e0H29oQT4WfIKW0soOtWoy+sDX/DOk2ekCm1+jtEIPdtU/vjg+Lw3rBe
         2h7jvS0/8SgSOpX+puXRs+B54SYwlICjIGNyrxVeZUkGnTHH/pDxukTfT/sQog2ZR26u
         C9ysK6MIV/apyFkiZcP1j6avpsNHCupQZMxsDvpEpxJBqjQzNsS1nzO3r+SvbiqsqNgX
         vY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TVQi5KQ/I+2laNFCDmyfJCzVGWbY5N0WpIK/yNnJ4mc=;
        b=JtUTeAW1euyQ+TZvNn7z0dsfTElzvtClAyYJU2pknLOp4DUNBHAtrdlelYQ+i9Xlig
         ybTqbViJ8nZkl8EuoQZTvr+CgOYNNIQAU1yN/VpFoOtHGyTlkR9tKMNLBQ1NdLWfbh72
         nrhMkc/MKn++EslhqpHb0qN7YOddM+LQnKA0DhqiJoYbptIvXdv83Yag1r1QxJKZ59gv
         aV9DVvRHXcyHVjdOqJUsTPLVEcu42Z0nrwQyARh8bLoIGLZree6WWLb3nwoKZrT+TayS
         N1p/9eEAFHxxDdg5ZZjOxD1sEoyhOEtMtNTL2qnnQlDr6h1Lsh6sUUcQVMIeuIKq1KTK
         WUtg==
X-Gm-Message-State: ALyK8tIxNoG2V+uyLcMopBGqR9sEZ1bLn/DsjVvtOQSfofOh3JflpQ21C0us8ejmWMQrzeSypAr+Tx/SKAn9hw==
X-Received: by 10.28.129.208 with SMTP id c199mr6228848wmd.79.1465938812459;
 Tue, 14 Jun 2016 14:13:32 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Tue, 14 Jun 2016 14:13:31 -0700 (PDT)
In-Reply-To: <CAGZ79kYaQTdVoXOGpKbQmWsdRftY10TBZTTf_Ya-fdegykU-QQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297330>

On Tue, Jun 14, 2016 at 9:48 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jun 14, 2016 at 12:34 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> Sharness was first announced on this list in July 2012 [4]. It was
>> created from Git's test lib in April 2011 by Mathias Lafeldt who
>> improved and maintained it until a few days ago.
>>
>> Thanks a lot Mathias!
>
> Thanks for picking up the work, Christian!
>
> Is there any word out there from Mathias on making you the designated
> new maintainer? (I cannot tell if this is a genuine maintainer change, or
> a [hostile] fork by reading this email, and I don't know much of the context,

Mathias gave me commiter rights on the repo
(https://github.com/mlafeldt/sharness at that time) one year ago.

A few days ago, as I wanted since last December to release v1.0.0, but
was uneasy to do so without at least a LGTM from him, I contacted him
by private email and he decided to transfer the repo to
https://github.com/chriscool/sharness, to give me maintainership and
to step down completely. So yeah this is a genuine maintainer change
and not an hostile fork at all.
(I cc'ed Mathias again so he can confirm if he wants.)

> as I did not know git Git test suite was a stand alone thing)

I am not sure it qualifies as a stand alone thing there are some
differences and for now some features are going from Git's test-lib.sh
into Sharness but not the other way around.
