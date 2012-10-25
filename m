From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 08:19:36 +0200
Message-ID: <CAMP44s1cRg_we5nXeRG1WcWz7YUOBrauJigeNna1YETcno9p=A@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
	<1320535407-4933-2-git-send-email-srabbelier@gmail.com>
	<CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
	<20121024180807.GA3338@elie.Belkin>
	<CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
	<20121024191149.GA3120@elie.Belkin>
	<CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
	<20121025042731.GA11243@elie.Belkin>
	<CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
	<20121025052823.GB11243@elie.Belkin>
	<CAGdFq_gg3gPvCADje9ibz8xHgPOLF+=79EqksVzG2JeTOfHocw@mail.gmail.com>
	<CAMP44s3kBxzJbyoxPqWbRMWmpX9sNPGjdRy_KrTeRoVmGC-+Hg@mail.gmail.com>
	<CAGdFq_jfiX9apPyq6pba4S4iCQLGLmDvSrLaujSB5rO0i+fzfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 08:19:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRGnG-0006K3-FD
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 08:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515Ab2JYGTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 02:19:38 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50045 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab2JYGTh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 02:19:37 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1245449obb.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 23:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zr4WDi1yiUtAmUGo1zPnFLf1ehcQdHV4QMxo4HyDhNQ=;
        b=wBpo/5XzN9skmn9CKYxpfFD9VCPKWBOF7YwzH2t9yi/D9tOJRf3A4CBHL2g5IM0Ew9
         WERJBXrdkGymClkhTE2YoP1Y4CL7cjuinfRzIxS48FH7EqosPwjco3QnNy9G5/fna0ar
         VgwxnJZ4xFvfBdwto8lt5cDL5DBLVmegfKEMSs4JvYCi+oG/HK6e96UvxUJKOpKy+ZZL
         f/2FEE1daakR/gy+UHSERkvEuksSPKU6oCzSnrP7HYAbBGssnC3v5xIaQKNLLZndU2Y2
         91rBlrFH69Phhqffhjv+9PiEWA1WejDNbNKwMZiDwhWusdr4Ow6tWl03mV+FaJVfYKE/
         cRng==
Received: by 10.60.12.233 with SMTP id b9mr16211206oec.95.1351145976714; Wed,
 24 Oct 2012 23:19:36 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 24 Oct 2012 23:19:36 -0700 (PDT)
In-Reply-To: <CAGdFq_jfiX9apPyq6pba4S4iCQLGLmDvSrLaujSB5rO0i+fzfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208351>

On Thu, Oct 25, 2012 at 8:07 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Wed, Oct 24, 2012 at 10:50 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> This works just fine. Go ahead, apply my patch, and run it, the second
>> branch gets updated.
>
> Yes, but as you said:
>
>> That is already the case, my patch will cause this to generate the same output:
>> % git fast-export --{im,ex}port-marks=/tmp/marks ^foo foo.foo
>> Which is still not got, but not catastrophic by any means.
>
> Which is exactly the reason we (Dscho and I during our little
> hackathon) went with the approach we did. We considered the approach
> you took (if I still had the repository I might even find something
> very like your patch in my reflog), but dismissed it for that reason.
> By teaching fast-export to properly re-export interesting refs, this
> exporting of negated refs does not happen.

Oh really? This is with your patches:

% git fast-export --{im,ex}port-marks=/tmp/marks foo1 ^foo2 foo3..foo3
reset refs/heads/foo1
from :21

reset refs/heads/foo3
from :21

reset refs/heads/foo3
from :21

reset refs/heads/foo2
from :21

This is with mine:

% ./git fast-export --{im,ex}port-marks=/tmp/marks foo1 ^foo2 foo3..foo3
reset refs/heads/foo3
from :21

reset refs/heads/foo2
from :21

reset refs/heads/foo1
from :21

Now tell me again. What is the benefit of your approach?

> Additionally, you say it is
> not catastrophic, but it _is_, if you run: 'git fast-export ^master
> foo', you do not expect master to suddenly show up on the remote side.

If 'git fast-export ^master foo' is catastrophic, so is 'git
fast-export foo ^master', and that already exports master *today*.

> I agree that your test more accurately describes what we're testing
> (and in fact, it should probably go in the tests for remote helpers).
> However, this test points out a shortcoming of fast-export that
> prevents us from implementing a cleaner solution to the 'fast-export
> push an existing ref' problem.

Which is something few users will notice. What they surely notice is
that there's no remote-hg they can readily use. Nobody expects all
software to be perfect or have all the features from day 1. Something
that just fetches a hg repo is already better than the current
situation: *nothing*.

And BTW, in mercurial a commit can be only on one branch anyway, so
you can't have 'foo' and 'master' both pointing to the same
commit/revision. Sure bookmarks is another story, but again, I don't
think people would prefer remote-hg to stay out because bookmarks
don't work _perfectly_.

Cheers.

-- 
Felipe Contreras
