From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Thu, 08 May 2014 18:39:59 -0500
Message-ID: <536c15cf8594b_6f3bb152ecb@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <xmqqha515ebt.fsf@gitster.dls.corp.google.com>
 <536adf96f37ec_3caaa612ec69@nysa.notmuch>
 <xmqqtx902k45.fsf@gitster.dls.corp.google.com>
 <536be16ba5ef1_3ce710a12ecdb@nysa.notmuch>
 <xmqqppjn29o3.fsf@gitster.dls.corp.google.com>
 <536c084ecb546_4f6fd2f30cdd@nysa.notmuch>
 <xmqqha4z27ly.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 01:50:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiY5V-00089y-1o
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 01:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbaEHXut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 19:50:49 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:47953 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbaEHXus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 19:50:48 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so3992620obc.27
        for <git@vger.kernel.org>; Thu, 08 May 2014 16:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=3GR6k1Mxk+upCS0HVWk7tnnBDM5hPkNGqpi1fRRxRA4=;
        b=X1ksuremGp69TV1ltMpk9nvNzYaImcyyo2uoB34L1R/fi7M2ithne3zAMC3K0sXcPt
         nxaHLGtsQsdJAb/m8Vlv1HzJguVjzGEnPcJvH1Bo4aKKSgLeaxmd1kHmLXQtc/53QpMN
         P2cEEeApvmYRZ+95YIcLcRVPom/p+GPWwfBelet0IXJYnaz2osqyOphYSqmJIiEJ+lKc
         OpMzFyR38zBONDQjuFxXvskXRjVUFEouOedutE3NpdIM2DCMm/ckRcLQOrBhCFH7fyT9
         n6fmyavGEcFavy+tQin2674jkG4FpgtatfRRK3EZB89HhzZZdlv4upW3qtvrt0G/A05V
         nlBg==
X-Received: by 10.182.45.161 with SMTP id o1mr9120492obm.29.1399593048335;
        Thu, 08 May 2014 16:50:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm9992770oej.5.2014.05.08.16.50.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 16:50:47 -0700 (PDT)
In-Reply-To: <xmqqha4z27ly.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248463>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > I already said this multiple times, but let me be clear once more:
> >
> > MASTER HAS A REGRESSION (for all versions of Mercurial).
> 
> As you said, that is not a regression, isn't it?  It is an old
> breakage that existed even before 1.9 (was it 1.8.3 or something?)

No. It does't happen in 1.9, it will happen in 2.0.

That's a REGRESSION.

> >> If you no longer want to have it in contrib/, I can drop it in future
> >> releases (but not in v2.0), so that people can find the latest and
> >> greatest directly from you.  Otherwise, queuing a fix on 'pu' and then
> >> to 'next' in preparation for an early graduation for the release after
> >> v2.0 (and as a fix, it may want to go to older maintenance releases)
> >> is also fine by me.
> >
> > Are you saying that the graduation plan is going to continue and they
> > are going to move out of contrib and be distributed by default?
> 
> I do not think that is going to happen.

Then I don't understand what you mean by "graduation".

> As we discussed already, I do see merit in unbundling it from my tree.

You are blind. Move git-p4 and git-svn out of your tree.

You know what will happen.

> I can keep it in contrib/ as that is a slight benefit for you

What is the benefit of being in contrib/? Even you yourself argued that
there is not much point of 'contrib/' nowadays[1]. The only reason we
might want something in contrib/ is so that it has a chance to mature
before becoming part of the core.

> (i.e. you can be lock-step with Git) but as long as you live in my
> tree, you need to follow the same release schedule as the other
> contributors, which may be detrimental to your users, compared to a
> case where it is unbundled.

It's much more beneficial to *our* users if these tools are distributed
by default.

> I do not see a strong reason to move it out of contrib, either.

Really? So why did you say this?[2]

> > Either way, I think if things go well, remote-hg will prove it's
> > worth and move out of contrib and into git's core.
> 
> That was what you promised when we started carrying it in contrib/; I
> am still hoping to see it happen when it matures.

Jeff said the same thing when he was acting as maintainer[3], and you
didn't correct him:

> I would one day like to have it as part of the main distribution, too,
> but it would be nice to prove its worth in the field for a while
> first.

All this time I've been operating under the impression that once
git-remote-hg proved itself, it would graduate out of contrib.

So basically you tricked me, and I wasted insane amounts of time chasing
a target that was impossible to reach.

Fuck this.

[1] http://article.gmane.org/gmane.comp.version-control.git/220178
[2] http://article.gmane.org/gmane.comp.version-control.git/220277
[3] http://article.gmane.org/gmane.comp.version-control.git/208648

-- 
Felipe Contreras
