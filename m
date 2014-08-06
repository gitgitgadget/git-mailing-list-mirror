From: Linus Arver <linusarver@gmail.com>
Subject: Re: [PATCH 1/7] Documentation: git-init: typographical fixes
Date: Tue, 5 Aug 2014 21:58:48 -0700
Message-ID: <20140806045847.GA12559@k0>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407002817-29221-2-git-send-email-linusarver@gmail.com>
 <xmqqr40uoalz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Drake <sdrake@xnet.co.nz>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 06:59:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEtJT-0008Ia-9k
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 06:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbaHFE6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 00:58:54 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:40888 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaHFE6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 00:58:53 -0400
Received: by mail-yk0-f178.google.com with SMTP id 142so1300902ykq.37
        for <git@vger.kernel.org>; Tue, 05 Aug 2014 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wQLKNkrG3dn633Ki2gbDsNf92l4xU/i9qR7B7wqyW2w=;
        b=As9g1nE0hdXtDyLuevGOf6WyLdOamb1s1fsQYSysLnVkFZmwlhjDNgU2ZJO89iPSa2
         WyrCa+q0tmDhTBZGCRx0FsTdOpxx0OiRsUXHvb8dA74O4EYEHeryLlYrG6cVbxV+1UNm
         pf+J7ZI1Tx5Wkb0Lm3apOHSrTI11NRpKTBfVc+6dH9KpyERoRrF75Nu5GxBEMKEtjZhU
         RCeeTzG1LJxwjaVa639Sojc+ilbyngh2v72+XxqdfujfNRPpjtAdvXZch7UB98JHyIQx
         o+JpGNIO7JHnepYqhZJ2VIr6Uc3fXhjZsPXzdbVcBnq4AiB2xZdp+P5qkOXPjGyAMi3T
         fhTg==
X-Received: by 10.236.30.197 with SMTP id k45mr12658615yha.157.1407301132810;
        Tue, 05 Aug 2014 21:58:52 -0700 (PDT)
Received: from k0 (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id g25sm6771590yhk.38.2014.08.05.21.58.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Aug 2014 21:58:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqr40uoalz.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254842>

On Tue, Aug 05, 2014 at 03:06:00PM -0700, Junio C Hamano wrote:
> Linus Arver <linusarver@gmail.com> writes:
> 
> > Signed-off-by: Linus Arver <linusarver@gmail.com>
> > ---
> >  Documentation/git-init.txt | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> > index afd721e..5ed5859 100644
> > --- a/Documentation/git-init.txt
> > +++ b/Documentation/git-init.txt
> > @@ -43,7 +43,7 @@ OPTIONS
> >  -q::
> >  --quiet::
> >  
> > -Only print error and warning messages, all other output will be suppressed.
> > +Only print error and warning messages; all other output will be suppressed.
> 
> OK.
> 
> >  --bare::
> >  
> > @@ -97,7 +97,7 @@ is given:
> >     create a repo that is readable and writable to the current user and group,
> >     but inaccessible to others.
> >  
> > -By default, the configuration flag receive.denyNonFastForwards is enabled
> > +By default, the configuration flag 'receive.denyNonFastForwards' is enabled
> >  in shared repositories, so that you cannot force a non fast-forwarding push
> >  into it.
> 
> If you are going to quote something that the user should literally
> use, it is probably better to use `backticks` so that the quoted
> contents will be typeset in monospaced typewriter-font.

OK, that is simple to change.

> > @@ -113,7 +113,7 @@ TEMPLATE DIRECTORY
> >  The template directory contains files and directories that will be copied to
> >  the `$GIT_DIR` after it is created.
> >  
> > -The template directory used will (in order):
> > +The template directory used will be (in order):
> >  
> >   - The argument given with the `--template` option.
> 
> OK.
> 
> Thanks.
