From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Wed, 24 Oct 2012 23:07:17 -0700
Message-ID: <CAGdFq_jfiX9apPyq6pba4S4iCQLGLmDvSrLaujSB5rO0i+fzfg@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-2-git-send-email-srabbelier@gmail.com> <CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
 <20121024180807.GA3338@elie.Belkin> <CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
 <20121024191149.GA3120@elie.Belkin> <CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
 <20121025042731.GA11243@elie.Belkin> <CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
 <20121025052823.GB11243@elie.Belkin> <CAGdFq_gg3gPvCADje9ibz8xHgPOLF+=79EqksVzG2JeTOfHocw@mail.gmail.com>
 <CAMP44s3kBxzJbyoxPqWbRMWmpX9sNPGjdRy_KrTeRoVmGC-+Hg@mail.gmail.com>
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
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 08:08:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRGc1-0007dQ-Hn
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 08:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914Ab2JYGH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 02:07:59 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:39336 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756510Ab2JYGH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 02:07:59 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so3247609qad.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 23:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SLwQLsWzYCTWeGmHxuy+Fu8HUDUUyZI07yq5q8SFLUY=;
        b=JNlSJ/MQ0rLmn2DyXu25KpPDecIEUITKsY1wku3fUNHKkOP7rM544lVuTETLXGjuQO
         /oZT3jbvPVmSu2OUNKj4Iiljnl0pxWh0DIsKQibf1kyEUcnHzC5iEPrfooemQoPCQ3Rf
         685FALw+G8V1MPpckOpIddAHrpm7+418qdh9HAhWLgJ9crEpH7x65mMXRp1XagwQ3vnU
         02fQVECQMECssbCrtcCX4OjTMftXO8xyv+Fdnmi86089h+vLDcf+hnKwWDNJm1hSVgdD
         ik+hNpbVPILR/zd0/iY7oZ81TdZDbGAik4kKOKB4FkQ3YZpPDETTeo6Lh6X3J7C93apg
         DS4A==
Received: by 10.224.208.68 with SMTP id gb4mr7149617qab.99.1351145278177; Wed,
 24 Oct 2012 23:07:58 -0700 (PDT)
Received: by 10.49.36.195 with HTTP; Wed, 24 Oct 2012 23:07:17 -0700 (PDT)
In-Reply-To: <CAMP44s3kBxzJbyoxPqWbRMWmpX9sNPGjdRy_KrTeRoVmGC-+Hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208350>

On Wed, Oct 24, 2012 at 10:50 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This works just fine. Go ahead, apply my patch, and run it, the second
> branch gets updated.

Yes, but as you said:

> That is already the case, my patch will cause this to generate the same output:
> % git fast-export --{im,ex}port-marks=/tmp/marks ^foo foo.foo
> Which is still not got, but not catastrophic by any means.

Which is exactly the reason we (Dscho and I during our little
hackathon) went with the approach we did. We considered the approach
you took (if I still had the repository I might even find something
very like your patch in my reflog), but dismissed it for that reason.
By teaching fast-export to properly re-export interesting refs, this
exporting of negated refs does not happen. Additionally, you say it is
not catastrophic, but it _is_, if you run: 'git fast-export ^master
foo', you do not expect master to suddenly show up on the remote side.

I agree that your test more accurately describes what we're testing
(and in fact, it should probably go in the tests for remote helpers).
However, this test points out a shortcoming of fast-export that
prevents us from implementing a cleaner solution to the 'fast-export
push an existing ref' problem.

-- 
Cheers,

Sverre Rabbelier
