From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Discuss] soften warning message after cloning "void"
Date: Wed, 18 Feb 2015 18:54:00 -0800
Message-ID: <CAPc5daVoHCxg8-xEVxJK-G0HKKHApbwCzTd0q6jab5jfyHcarQ@mail.gmail.com>
References: <xmqqh9ui2481.fsf@gitster.dls.corp.google.com> <CAGZ79kYu1k=iKRWTxVD9Q=C9F5J0d653czeR0NCy04wGobB=Vw@mail.gmail.com>
 <CAPc5daUzdiS0HkVbqZvQvSm_49FhQj++hicmDTb717Cd7hg8hA@mail.gmail.com> <CAJo=hJt4qVd_dybSn9Wy2UPpvm1+Kg0pE=vyB_fr0eHqQEXdVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 03:54:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOHG2-0000P5-Fj
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 03:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbbBSCyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 21:54:22 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:45647 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbbBSCyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 21:54:21 -0500
Received: by mail-ob0-f176.google.com with SMTP id wo20so9893400obc.7
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 18:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MPNU/6+qf8fsJn90N5HhRfAHngDbbzDqjYrld9Yk9x4=;
        b=YqJVZVEVSQqm/XH0tO9Fp5gqJSE3Rot9jvO+9BOmUVez85RlgPP+XkGItQMUrTWk8q
         bMx2k8NzYALe4rMtoEcXRwIOcsK7ZavS527AZwMTgdjnqjdYHnmXnnGUHfwcwo6/y4ik
         nRMV49v6To0gOQZXA3OhAmW9k1LpF87iIpbe9pc4vdKWAX0sqYMOya/jydKc+ZiTzdyr
         UW5SGkUgCj/WcL9RQ7MRy8h4vSiqbdUdbarP9yfA5VEPSozLktRk4Ec4kJrQLefZMoM+
         3n1D31Rcn7O7dprMu0DrRZic89+cEAp24+5QHXupNFMfvprpQLkSTAK3nInbMoOOFkIM
         uPqA==
X-Received: by 10.202.85.17 with SMTP id j17mr1397618oib.65.1424314460584;
 Wed, 18 Feb 2015 18:54:20 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Wed, 18 Feb 2015 18:54:00 -0800 (PST)
In-Reply-To: <CAJo=hJt4qVd_dybSn9Wy2UPpvm1+Kg0pE=vyB_fr0eHqQEXdVg@mail.gmail.com>
X-Google-Sender-Auth: y-41VrLqJraqtdTk191LzgxyxYY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264080>

On Wed, Feb 18, 2015 at 4:43 PM, Shawn Pearce <spearce@spearce.org> wrote:
>
> This fails from a JGit server because the ref advertisement for an
> empty repository differs and disagrees with the format used by
> git-core. The result is a confused client spewing an odd checkout
> message.

That is exactly why the rephrasing was brought up, wasn't it?

As the Subject: line says, this thread is for people who want to
help those users with un-odd message, so discuss away
and come up with a final applicable patch ;-).
