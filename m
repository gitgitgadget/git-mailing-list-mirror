From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 16:01:05 -0500
Message-ID: <5356d8918948a_6cbadd72f0d@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
 <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
 <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
 <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
 <vpqlhux3yhr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 23:11:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wchyc-0005b5-8k
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 23:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158AbaDVVLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 17:11:31 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:47602 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbaDVVL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 17:11:29 -0400
Received: by mail-ob0-f170.google.com with SMTP id vb8so56167obc.15
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=+rLPb5gdj7YT29DB3D1SXUE6rTjR/vgFXHpvEoCpiIQ=;
        b=yz31pofJybImlnv4rGkod087ZIQbu7Yg1jludBxhXOffg5gwPNddHPIAlMafzY4zOO
         +ptFNWgWxSCBuYz8Ws0DtJCQZxozam7RPtOyQJ6ZxNdK7PtK9LBNSF6dVoUmUxGlOpZL
         sQzYecwh60Bd7BeXAU4z8MAQp54zjQ/Y/3HZtIDgNZIORffFnOa1Ks0IoWLQqj0x5ksq
         gK5qg+UXNMY4E88/ni6xFG5dNIqtQHo1mTxr3m4XuYHJUN/Kf+CnSCdh6Nmp8l33PuLG
         HPdhNSryChT6fw+c0ZxwnQpevrlouDu6EM8XNIW1yJ9eTr2H3XdcxgxA8mLJcWTHModk
         yjng==
X-Received: by 10.60.125.72 with SMTP id mo8mr34807366oeb.36.1398201088606;
        Tue, 22 Apr 2014 14:11:28 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 10sm78851075obq.18.2014.04.22.14.11.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 14:11:27 -0700 (PDT)
In-Reply-To: <vpqlhux3yhr.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246785>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Why is not material for v2.0? Because you say so? Are you going to wait another
> > ten years to introduce this to v3.0?
> 
> There's no need to wait for a 3.0 to introduce this. If these would
> be low-priority compared to user-defined aliases, there's no backward
> compatibility issue, it can very well be a 2.1, or whatever number comes
> after 2.0.

Can it? I would like Junio to say so.

Still, v2.0 is a better time for this.

> > This is actually the perfect time to do it.
> 
> Junio has just tagged a -rc for 2.0, so it's clearly too late to start
> discussing new features for this particular release.

And whose fault is that? I never saw any warning about the -rc tag, and I never
saw any discussion about possible features missing in v2.0.

Given that the next backward-incompatible release might be in a decade, I would
have expected people to have put more thought into v2.0, but I guess the Git
project is not really interested in progressive features.

-- 
Felipe Contreras
