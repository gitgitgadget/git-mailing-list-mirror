From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Mon, 26 Mar 2012 01:44:22 +0100
Message-ID: <201203260244.23556.jnareb@gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com> <201203251955.21454.jnareb@gmail.com> <CACeyogdCsFZEqmm057ZMcCYRuxiZ2-yfcV9+e1AdOOhTjne8vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: chaitanyaa nalla <nallachaitu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 02:44:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBy2w-0004NR-7w
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 02:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605Ab2CZAoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 20:44:24 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:33542 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab2CZAoY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 20:44:24 -0400
Received: by wejx9 with SMTP id x9so3856530wej.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 17:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=QvBTBM1EuVzk+NOdPmHUoUo66g4ffAc7jwVYO1IF2vA=;
        b=PbiyvB10K6KkPRk/aMeyAKJ6i6uSUpeOoprjgR9sYnytHDaEmQw782tPUJTMki1zZO
         WKKfydbeOPqFSyJ68RYHX/yoZf+CGOeRKQrfRlWmGpv0tsb7626oeh+g8Hok2DzMykb/
         7YOJ4KaG3AeXMg0ujNoI8iDOsEHIkheVCUyUreK8nOSIM9xgcoY3jdKKkvJW2KUMx3B6
         luY/cuMMBE1woc8Xp6DgGBqO6SzolvRCd0ejf8F9XJJMxJ18jmafJB9/remsfNJSeNLy
         WkTMACf9ZSlyhpZIf8Bi77VRXdrWznorKOtBbKHcasGeiYce8k6ZVr2B8MuJVyLUcHrE
         nunA==
Received: by 10.180.80.70 with SMTP id p6mr13901434wix.21.1332722662685;
        Sun, 25 Mar 2012 17:44:22 -0700 (PDT)
Received: from [192.168.1.13] (epy159.neoplus.adsl.tpnet.pl. [83.20.66.159])
        by mx.google.com with ESMTPS id l5sm36503523wia.11.2012.03.25.17.44.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Mar 2012 17:44:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CACeyogdCsFZEqmm057ZMcCYRuxiZ2-yfcV9+e1AdOOhTjne8vA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193887>

On Sun, 25 Mar 2012, chaitanyaa nalla wrote:

> "creating side-by-side diff from unified  diff in JavaScript, so that
>  switching between unified and side-by-side diff view  could be done
>  entirely client-side, without hitting the server"
>
>  could you please elaborate on this, I didn't understand this completly. 

Side-by-side diff is a new gitweb feature, available in v.7.9 (since
commit 6ba1eb5 (gitweb: Add a feature to show side-by-side diff, 2011-10-31))

Both git.kernel.org and repo.or.cz are based on an older version of
gitweb.  You need to install gitweb to test this (and perhaps git-instaweb
for easier HTML preview).

In short: unified diff like this:

  @@ -119,8 +119,8 @@ UI, Workflows & Features
   ctx
  -foo
  +bar

is turned into side-by-side diff:

   ctx                    ctx
  -foo                   +bar

Commit  6ae683c (gitweb: Add navigation to select side-by-side diff,
2011-10-31) allows switching between unified and side-by-side diff;
the goal of this feature would be to make it client-side (hijacking
the link).

-- 
Jakub Narebski
Poland
