From: Marco Paolone <marcopaolone@gmail.com>
Subject: Re: Nits abut the italian translation (was: Re: Please pull git-l10n
 updates on master branch)
Date: Fri, 1 Jun 2012 14:36:42 +0200
Message-ID: <20120601123642.GA11543@quizzlo.invalid>
References: <CANYiYbF3sbtKVTZJOTbQ-aOjBKGKFZfq-xQDwyOvR56C7akrLw@mail.gmail.com>
 <4FC8A88D.3080700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 14:37:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaR6u-0000pQ-Gk
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 14:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759536Ab2FAMg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 08:36:58 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53959 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759520Ab2FAMg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 08:36:58 -0400
Received: by eaak11 with SMTP id k11so518658eaa.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 05:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=23shXZHVw+0StLEB+tfSaQhfyMwEG0gR7aqtWckmPto=;
        b=EnV7LVxmQeWFFXjRpIcKv4Qeq+HUhFg6BXZ6YJ+mzB33qRluitFgW21+yGyNuk9KRv
         JfpIesqbn1PkAv3vNZOW8bR3y3H00uF6fiFExnUYiMAxSTx18cBFqNAXzWF1BDPSNYup
         XpSEXA7i30uP4gY3va44y7IioFHuwAk1W0Ay18KZbOBVZVJSx4a4PSWBoVUBw3ehRbe3
         7rHYGmbXLXFDk/Z5LFtDXHr4szaE7ODONOwPboRXpfDlOLcuTswBzVE0V5Y8C9+ZfTB6
         +FMxG5T+kNx76gtIcE794jIfBl1gpT/gjeQ91r1i8C2p6m1zdFu0eXzINK8C+yN3Ay5/
         rM+g==
Received: by 10.14.47.204 with SMTP id t52mr1529427eeb.100.1338554216417;
        Fri, 01 Jun 2012 05:36:56 -0700 (PDT)
Received: from quizzlo.invalid (host31-60-dynamic.181-80-r.retail.telecomitalia.it. [80.181.60.31])
        by mx.google.com with ESMTPS id h53sm6580473eea.1.2012.06.01.05.36.53
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Jun 2012 05:36:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FC8A88D.3080700@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198984>

On Fri, Jun 01, 2012 at 01:33:33PM +0200, Stefano Lattarini wrote:
> I see few minor issues with the new translations; I hope it's OK if I report
> them here.  Do not consider the following as an exhaustive list, since I've
> just skimmed the it.po file.  And sorry for the messy and out-of-order report,
> but I'm short of time in these days.

Thanks for your report, I'll fix them in next commit.  We could even leave terms
like "branch" or "tree" untranslated, but translation wouldn't have much sense
at this point. Some guides, like [1] use "ramo" or "albero" to better explain
how Git works, especially for beginners. Obviously we should leave terms like
"cherry-pick" or "push" as is.  What do you suggest?

[1] http://www.linux.it/~rubini/docs/git/git.html

-- 
Linux Registered User #401479
GPG: 0x897AF14E
