From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Sat, 12 Jul 2014 10:47:03 +0200
Message-ID: <CAOvwQ4gjfzh4+fNg9-7DecdubzYRW=6t4-4Exq7+mNLAPumb1w@mail.gmail.com>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
 <1405024438.3775.3.camel@stross> <CAOvwQ4hq5AZ0ZhB-1etUZfLfJ4X=11_03syH2pgY_fi=FSLAPQ@mail.gmail.com>
 <1405025616.3775.6.camel@stross> <CAOvwQ4h=uFCN36dQt4uqwJv8393iVhiCh09+71DhhzyWrbCfUA@mail.gmail.com>
 <CAOvwQ4in4aufZX2PGkAoX4vWhg_mq+n6Baov_ifGjiyfR_UbPQ@mail.gmail.com> <20140712045616.GA14459@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 10:47:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5syF-0003Zc-4h
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 10:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbaGLIrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 04:47:46 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:45053 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbaGLIro (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 04:47:44 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so2290546oac.36
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aFVhvWLhGarAD+TH04nnQTmDTAvIHp1LGHrtZmJ4QUc=;
        b=Nxnh7WsbBBsGEzYgOSJ6rE0usDQcSKUfz6qCfLp6PRQ3boSMpCJ7KhjJotW0zPTyyu
         vq6gfnpW/sXFQMUDJpJn+vKpeL9TA6AES78xRdVNLEiEKV77+09CDBaBVIVi268qys2O
         yU0I0yfS7zFIIfXGormGnvP9uSia2bp3SqdnDYl3SRyyFFSg727+viUyVRoz3qvwO8kK
         OS3Y0B/CxKizn15BKrKb/3iqx6WJGg+DB/eJFrNOk52kaxtZ4J5kSovlRqDuRLAMTEuM
         IXKfwXXxZXKPUmHHnR4tgMjQllyWTeOAiTMp3LTUc2Cn5GkVoAI8uRL0xm0jEcypkhwF
         ydXA==
X-Received: by 10.60.73.129 with SMTP id l1mr5357578oev.2.1405154863889; Sat,
 12 Jul 2014 01:47:43 -0700 (PDT)
Received: by 10.76.127.116 with HTTP; Sat, 12 Jul 2014 01:47:03 -0700 (PDT)
In-Reply-To: <20140712045616.GA14459@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253385>

On Sat, Jul 12, 2014 at 6:56 AM, Jeff King wrote:
> On Fri, Jul 11, 2014 at 12:12:55AM +0200, Tuncer Ayaz wrote:
>
> > Sorry, didn't test properly when I tried with/without config.mak,
> > and PROFILE=BUILD was the problem. I had that in config.mak based
> > on information gathered from INSTALL and Makefile. To be clear, is
> > PROFILE=BUILD (still) supported?
>
> I think none of the regular devs uses PROFILE, and it bit-rotted
> somewhat. Andi Kleen recently posted a series to fix it[1]. I can
> reproduce your problem without that series, but compiling with
> ak/profile-feedback-build merged in seems to work OK.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/253005

Yes, Andi's patch works.

Any idea when ak/profile-feedback-build will land in master?
