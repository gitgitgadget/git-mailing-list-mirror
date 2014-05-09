From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Fri, 09 May 2014 04:20:40 -0500
Message-ID: <536c9de8f07ae_39ea14ab310f9@nysa.notmuch>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <20140509055024.GB30674@dcvr.yhbt.net>
 <536c7f9089b77_182dd0d31084@nysa.notmuch>
 <20140509081507.GA26494@dcvr.yhbt.net>
 <536c939781d8b_2bf0e952f08@nysa.notmuch>
 <20140509085937.GA29347@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin@laptop.org>
To: Eric Wong <normalperson@yhbt.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 11:20:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wigz5-0001FY-0c
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 11:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659AbaEIJUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 05:20:46 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:60101 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610AbaEIJUp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 05:20:45 -0400
Received: by mail-yk0-f176.google.com with SMTP id q9so3205236ykb.7
        for <git@vger.kernel.org>; Fri, 09 May 2014 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=paUoyKGnE9tul/tq10MIOBWAmFuJK+LCvTOc3e5O0dg=;
        b=g3jiOHyVav7JAY5YE4rIzgpOOvQvlTllURBmbU8QSEuhwbJtgcn5WfDNEBsnOWtXUy
         SjnfgjUOpttE4W2U3BwQLittxhCP/yVFMPtu2dXleEJYGfURaWE9n2b0dqDCo3+xSGNq
         FoaVsP7E6lQf4kMBMM9Obdc8u6I60mm1NtLdUZ62HWr6WyEdA3C1up1ryqwANCuPix2P
         oxFLdBcda9wFp0Ze40+U5ANeHZUpQcc72FTkJ5FQmIertgkkYTyYgDxcyqbrvEy4gwUO
         1mpu148GJ6+/m6TgOlZxgdOAa7RVl54ppBlo/rtETtng+XPytGohb0Ilke4G93NmjSlP
         bMvQ==
X-Received: by 10.236.229.133 with SMTP id h5mr13531070yhq.64.1399627245022;
        Fri, 09 May 2014 02:20:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r46sm5366461yhd.29.2014.05.09.02.20.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 02:20:44 -0700 (PDT)
In-Reply-To: <20140509085937.GA29347@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248541>

Eric Wong wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > As a minimal token that anybody might possibly be using it, I would like
> > to see it work at least once. Since you said you have arch repos, can
> > you confirm that it does something?
> 
> Those repos are in offline/offsite storage and I do not have time to
> retrieve them.

Then we have no reason to believe they still work, and therefore, no
reason to believe anybody is using this.

> I've forgotten how to use tla to get a public repo, even.

No surprises there given how unfriendly tla is.

> > Eric Wong wrote:
> > > No, I am not convinced existing foreign SCM tools should move
> > > out-of-tree.  Perhaps something like the following would be helpful:
> > 
> > Tell that to Junio.
> > 
> > If tools like git-remote-hg with tests and active maintanance and many
> > users cannot be in the core, why should 'git archimport' be?
> 
> Perhaps it's easier to deal with a benign, unmaintained tool than
> to deal with you as a maintainer?

That is irrelevant to the bad quality of 'git archimport'.

> > Would you at least be OK with a demotion to contrib/?
> 
> I don't see the point of moving it around, even.

So basically you think we should keep 'git archimport' forever in the
core, even if nobody uses it ever. So much for compromises.

I think it should be removed altogether. If somebody complains the were
using the tool, it can be added to contrib/ as a temporary measure.

-- 
Felipe Contreras
