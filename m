From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Thu, 08 May 2014 19:23:36 -0500
Message-ID: <536c20084d92e_741a161d31094@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <xmqqha515ebt.fsf@gitster.dls.corp.google.com>
 <536adf96f37ec_3caaa612ec69@nysa.notmuch>
 <xmqqtx902k45.fsf@gitster.dls.corp.google.com>
 <536be16ba5ef1_3ce710a12ecdb@nysa.notmuch>
 <xmqqppjn29o3.fsf@gitster.dls.corp.google.com>
 <536c084ecb546_4f6fd2f30cdd@nysa.notmuch>
 <xmqqha4z27ly.fsf@gitster.dls.corp.google.com>
 <536c15cf8594b_6f3bb152ecb@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 02:34:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiYln-000884-OI
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 02:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbaEIAe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 20:34:26 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:53363 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbaEIAeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 20:34:25 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so4053354obc.28
        for <git@vger.kernel.org>; Thu, 08 May 2014 17:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=hlx1l+A3qORJMcnWeP4Ry3yoJ/pNCOHVxSUIpKdyAVc=;
        b=bMzB0tl92XqKI+vKoptkP3S6QOryK/KVCgDj82KalDqJ6/LedMyS8LhI6A3zJ/TPPZ
         +L/IUYUO2W/ScVK2yWsh+MnvrFgQkGy6tIv9BD4M894ksADU0M4yLNqt0TAOOVKSXWSs
         MWHgJcDXttx+azmwmHsKzEELOaz5H3+WicMudxERQpHq/6HxPyCb77ZB40nOwJj9KW93
         kzzTMFbqI++ORSmksl97XwyVk3UG2WPNISYqTDcdnuLEtnvn5IBVFX8IuMo1lJ795HmM
         EinSayhGoWSfFxvbsuL9K1I6hAT0FSWbkAWutyFkVY3MNuv1WQhaHJgkaZ6LS/vIgU8y
         54ZQ==
X-Received: by 10.182.225.163 with SMTP id rl3mr7947103obc.79.1399595665236;
        Thu, 08 May 2014 17:34:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zm8sm8572obc.16.2014.05.08.17.34.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 17:34:24 -0700 (PDT)
In-Reply-To: <536c15cf8594b_6f3bb152ecb@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248465>

Felipe Contreras wrote:
> Junio C Hamano wrote:

> > I do not see a strong reason to move it out of contrib, either.
> 
> Really? So why did you say this?[2]
> 
> > > Either way, I think if things go well, remote-hg will prove it's
> > > worth and move out of contrib and into git's core.
> > 
> > That was what you promised when we started carrying it in contrib/; I
> > am still hoping to see it happen when it matures.
> 
> Jeff said the same thing when he was acting as maintainer[3], and you
> didn't correct him:
> 
> > I would one day like to have it as part of the main distribution, too,
> > but it would be nice to prove its worth in the field for a while
> > first.
> 
> All this time I've been operating under the impression that once
> git-remote-hg proved itself, it would graduate out of contrib.
> 
> So basically you tricked me, and I wasted insane amounts of time chasing
> a target that was impossible to reach.

Even contrib/README says so:

  I expect that things that start their life in the contrib/ area
  to graduate out of contrib/ once they mature, either by becoming
  projects on their own, or moving to the toplevel directory.  On
  the other hand, I expect I'll be proposing removal of disused
  and inactive ones from time to time.

-- 
Felipe Contreras
