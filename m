From: Andreas Ericsson <ae@op5.se>
Subject: Re: Newbie grief
Date: Wed, 02 May 2012 00:17:01 +0200
Message-ID: <4FA060DD.9030208@op5.se>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com> <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com> <4FA055D0.7040102@palm.com> <86aa1rmvhb.fsf@red.stonehenge.com> <4FA05E9F.9090709@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Wed May 02 00:17:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPLNh-0002ME-6V
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 00:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096Ab2EAWRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 18:17:07 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59060 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab2EAWRG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 18:17:06 -0400
Received: by lbbgm6 with SMTP id gm6so7899lbb.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 15:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=zOnmuH1CF1tjXnuxfFb6+sp05fbJz8tpygBE37XAOcY=;
        b=Duju2GrIwNvDlPwSwX2zb8xdNI8ZBmbyMKpFa0do2tJjA9hBzkkTf8deDcHkvxTIQz
         Nlyxd3TZSRgBOTUJM7AIXsCJ2oljCVCnW4AP/+ZU8O5qQsosa84YXQ9ouXO+7dulTubW
         5lKh1Ol/84krDRxOa4o29MAj8hvk5QE/heiNwVpGA/WqU6n0JLRhjuCXyICA5aY0i2/T
         mKlqorylZjcj00N5ReT4YGkIfCf1H8FSWSqzA3VvjqQ2WAcl9xgqo0iHyFcFbKKdML0r
         ziSKI+rXGM32Jc9AwUbHso1PvxdWAT7B4APPeSsHV9hVpty1zeUACQqLp7sMLEtiVyTY
         b/tA==
Received: by 10.152.112.97 with SMTP id ip1mr24629364lab.31.1335910624843;
        Tue, 01 May 2012 15:17:04 -0700 (PDT)
Received: from vix.int.op5.se (c80-217-218-226.bredband.comhem.se. [80.217.218.226])
        by mx.google.com with ESMTPS id c3sm26254231lbg.6.2012.05.01.15.17.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 May 2012 15:17:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120424 Thunderbird/12.0
In-Reply-To: <4FA05E9F.9090709@palm.com>
X-Gm-Message-State: ALoCoQnuBhxZ/bcqeicgK2z6yUf5c2KxUwy3p/ShdCZmHV36LPyaloIzlRQ4TFm8VtkT/xjyGhN2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196762>

On 05/02/2012 12:07 AM, Rich Pixley wrote:
> On 5/1/12 14:39 , Randal L. Schwartz wrote:
>> 
>> Rich> My particular situation is that I'm developing a "feature"
>> and to do that, I need to be testing on multiple machines.
>> Tens of them.
>> 
>> I think you're now confusing git with a deploy system. That is
>> also something that will lead you to unnecessary grief. Pick a
>> deploy system that's not git, and integrate git with it.
> 
> No, not a deploy system. You use a deploy system to set up something
> like multiple server http farms. What I'm doing is more akin to
> porting the same piece of software to 20 different operating system
> distributions. I'm not "deploying" the source code. I'm developing
> it.
> 
> Thank you for acknowledging that git is a poor match for this
> scenario, though.
> 

Git works well for that if you put hooks in place to trigger builds
and test-runs on the testservers though. We do exactly that, and I
doubt we're the only ones who do automated testing of every push.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
