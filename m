From: Richard Peterson <richard@rcpeterson.com>
Subject: Re: ACLs for GIT
Date: Mon, 16 May 2011 11:26:38 -0400
Message-ID: <BANLkTimMP3aJrQ-ivzR+yOhb12t-qQTz2Q@mail.gmail.com>
References: <4DD02876.1040404@bbn.com>
	<20110515201513.GA27758@jpl.local>
	<4DD1250D.50005@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Magnus_B=E4ck?= <magnus.back@sonyericsson.com>,
	git@vger.kernel.org
To: Martin L Resnick <mresnick@bbn.com>
X-From: git-owner@vger.kernel.org Mon May 16 17:26:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLzgz-0006a8-Eb
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 17:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab1EPP0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 11:26:42 -0400
Received: from edgy.cirtexhosting.com ([75.126.140.58]:35784 "EHLO
	edgy.cirtexhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769Ab1EPP0l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 11:26:41 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:48344)
	by edgy.cirtexhosting.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <richard@rcpeterson.com>)
	id 1QLzh4-0006rT-TV
	for git@vger.kernel.org; Mon, 16 May 2011 11:26:50 -0400
Received: by yia27 with SMTP id 27so1449402yia.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 08:26:38 -0700 (PDT)
Received: by 10.236.192.231 with SMTP id i67mr4502557yhn.40.1305559598199;
 Mon, 16 May 2011 08:26:38 -0700 (PDT)
Received: by 10.147.98.18 with HTTP; Mon, 16 May 2011 08:26:38 -0700 (PDT)
In-Reply-To: <4DD1250D.50005@bbn.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - edgy.cirtexhosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - rcpeterson.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173740>

On Mon, May 16, 2011 at 9:22 AM, Martin L Resnick <mresnick@bbn.com> wrote:
> Thanks Mangus.
>
> You pointed out some hurdles I'll have to think about
> (blocked files not matching the SHA and so can't be committed).
>
> As to why I want to do this consider NSA non-export rules.
> Our application would be built with NSA encryption
> but we have foreign nationals working on the code
> and so they are not permitted to see that part.
> The makefiles look to see if the NSA encryption code file
> is there and link it in. If not a stub is used.

I bet you could use a submodule.

-Richard
