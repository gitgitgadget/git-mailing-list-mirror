From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Wed, 16 Mar 2016 20:40:54 +0700
Message-ID: <CACsJy8CyLGtYpPnwdhS-AD4d2pcU7RVv=OxPEePcHYhFpDh4pg@mail.gmail.com>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com> <56E6D8C4.2010205@drmicha.warpmail.net>
 <xmqqoaahaw99.fsf@gitster.mtv.corp.google.com> <xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
 <56E96096.4020108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 14:41:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agBhe-0003Lv-Sa
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 14:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966284AbcCPNl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 09:41:26 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35868 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092AbcCPNlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 09:41:25 -0400
Received: by mail-lf0-f45.google.com with SMTP id l83so19529986lfd.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gAquP2XGzl/m04MnMxKbzRqiIvAuW6xs5MFvtHM3vpA=;
        b=CvF9gYtEUQR59UKpU4gEJQYlVkBam7IFRjeLXf+9egOqQPPh3gpH8JhtFDN5wL+Coa
         LUhasi5DhX0dDjlNaa4mhExAnpmjrmXo/ofOFpb/4vc3VSXCFD2Cvm8GLjkgdk4glzXG
         zuDXuhkH0AbMjyZLzCi38I7ABNokvk+jG3Qql5uhfhz0Q0JCFZb3K3PsegOTAt4QF+lZ
         AFnK+u1SkTIixZo1xaFMFAPzp1uwUk9CM3iHaYBP1iQ2LyZ3gu3VQVTRIXTEjW+cajMB
         U8EJsw5FBREqRVcIcwie1TxXHtt192CBK3QxoYxmZCScLOkZfXMYtoidvqRgO/H63Tg6
         PuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gAquP2XGzl/m04MnMxKbzRqiIvAuW6xs5MFvtHM3vpA=;
        b=iSsofduBIwHXSj6WKOa9Rwy9NX3AGod4F1WIuZlhXPnZ1bOeP7KwnF30jlwgM+nKYx
         4JSZm+GI9E76csDvDznIk7HxjQTEPUQY3WjShWXDY2Nh53dtEQIyNuAG40RCjqPY8cZL
         sYwTygeqdNC7j5RVNoyHNCWRW+/R+9SZLsOUxYLzECoS/AwzrE4R8KhLRJQJkN6Y55ur
         px7lpQOCAHoBtrEiJM1aYiEhbU0w39BfgSQcv8QpSHo4f2wY+b9J0hCi7icWJNk27pkO
         q2jnXR7NLlVgQjrSMEGUr0ataP2PBq1tSEdOfYGYZqyqZNDsQgFH1hh97ye8oHuxjVo4
         DSvw==
X-Gm-Message-State: AD7BkJJ52JUr038pS1OaLe28AqT0qFfDZdqFrH59GhhBXvXxJoFQcLQMzULB+PnHOPfvsTNupPzeaeY/pyQJhg==
X-Received: by 10.25.211.75 with SMTP id k72mr1440993lfg.45.1458135683718;
 Wed, 16 Mar 2016 06:41:23 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 16 Mar 2016 06:40:54 -0700 (PDT)
In-Reply-To: <56E96096.4020108@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288972>

On Wed, Mar 16, 2016 at 8:33 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> In hindsight, what happened must have been like this:
>
> "ahead " was marked properly for l10n and translated in the past.
>
> 7a76c28 (status: disable translation when --porcelain is used,
> 2014-03-20) introduced those extra parentheses. Matthieu probably didn't
> rerun "make pot" and "msgmerge" so that he didn't notice the consequences.

.po(t) files are _very_ noisy because they record line numbers and
that pretty much guarantees huge diffs. Even I as a former translator
do not want to "make pot" and see the differences. If only msgmerge
supports an output without line numbers...
-- 
Duy
