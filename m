From: Atsushi Nakagawa <atnak@chejz.com>
Subject: Re: Reset by checkout?
Date: Sat, 07 Jun 2014 13:55:58 +0900
Message-ID: <20140607135556.7894.B013761@chejz.com>
References: <53898448.8040105@bracey.fi> <20140601132624.821C.B013761@chejz.com>
Reply-To: Atsushi Nakagawa <atnak@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Kevin Bracey <kevin@bracey.fi>, git@vger.kernel.org
To: Atsushi Nakagawa <atnak@chejz.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 06:56:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt8fl-0002HE-43
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 06:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbaFGEz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 00:55:59 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:33160 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaFGEz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2014 00:55:59 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so3311048pbc.12
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 21:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chejz.com; s=google;
        h=date:from:to:subject:cc:reply-to:in-reply-to:references:message-id
         :mime-version:content-type:content-transfer-encoding;
        bh=49ruF+wHqHAPZrZtdDbpj4cnL4Ujgjral5bHzaTQULI=;
        b=VWf1OPMSexyWKz6ZZN8GeSyWPegXH67ai4gALxDywHI+HC6Oy4KKi3c9SPhSecprWD
         ok+AlbuEZx6xYes90BxO6V23XM9cmVzMZ2OJJY25ebcUKspLR+DwKK36mfasZ/FfdusS
         6Zx5c2EuF9IDgIGdN7mqjiXVOJdlehW+nlulQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:cc:reply-to:in-reply-to
         :references:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=49ruF+wHqHAPZrZtdDbpj4cnL4Ujgjral5bHzaTQULI=;
        b=Ecxrfu1WWChNpHm1xianNdm4uaVkjLjIQhMy5QIGD0KXBzcmctfdazbudyto7KmpkW
         oYTyXw/JSU1WL7JZTk7J4kmEQSVW89MfO50nalbsWSBDMLbf30gYP9WeJZIaiqmo3lBF
         HEMFAqjoqKXuoUoLxp4y4H6hE3O8axOBUCxPhYzZSVb5BvKCxWIwbCJSc9YKJwPtyMYM
         uetqSXISmLMo5u5F4dbQ96GsXuJ5B7A7ercsq+YvepxaanMF+u1RqWQWgGppRh4ez9Hx
         1aX+exepoaOnv9ESklQdn7i8XfDil3sCWC0mNy/oa65vZpeWDBP3o2J4Rn8EYavwhAka
         8i6w==
X-Gm-Message-State: ALoCoQm3m3V64auj3YVlmMUsIrkOf4+s8a1y1jEJF2fgfp8dGpUk2HT9hB5pdujiRQLK2nVmOgn4
X-Received: by 10.68.173.65 with SMTP id bi1mr321963pbc.130.1402116958832;
        Fri, 06 Jun 2014 21:55:58 -0700 (PDT)
Received: from [127.0.0.1] (KD106168138162.ppp-bb.dion.ne.jp. [106.168.138.162])
        by mx.google.com with ESMTPSA id gw8sm43333261pbc.28.2014.06.06.21.55.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 21:55:58 -0700 (PDT)
In-Reply-To: <20140601132624.821C.B013761@chejz.com>
X-Mailer: Becky! ver. 2.65.07 [en]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251019>

Atsushi Nakagawa <atnak@chejz.com> wrote:
> Kevin Bracey <kevin@bracey.fi> wrote:
> > On 31/05/2014 08:46, Atsushi Nakagawa wrote:
> > >    `git checkout -B <current-branch-name> <tree-ish>`
> > >
> > > This is such an useful notion that I can fathom why there isn't a better,
> > > first-tier, alternative.q
> > ...
> > 
> > I guess in theory using "checkout" allows fancier extra options like
> > "--merge" and "--patch", but I don't think I've ever used those with
> > checkout, let alone this mode, where I really do just want a "reset",
> > with safety checks.
> 
> It does indeed have those fancier options.  However, I just noticed
> there's even a 'reset --merge'!  And like you say, I can't remember ever
> using 'checkout --merge' together with 'checkout -B'.

I'd assumed 'reset --merge' was like 'checkout --merge' and was elated..,
but it was something else entirely.

Cheers,


-- 
Atsushi Nakagawa
<atnak@chejz.com>
Changes are made when there is inconvenience.
