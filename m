From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: StGIT 0.13 recognizes but not list packed StGIT controlled branches
Date: Mon, 19 Nov 2007 12:57:07 +0100
Message-ID: <200711191257.09158.jnareb@gmail.com>
References: <200711190005.49990.jnareb@gmail.com> <b0943d9e0711190320r28224763t5a6c9ed7758a12b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 12:57:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu5Fw-0005QY-8c
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 12:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbXKSL5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 06:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbXKSL5R
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 06:57:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:58405 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbXKSL5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 06:57:16 -0500
Received: by ug-out-1314.google.com with SMTP id z38so931606ugc
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 03:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=/lsp32bJ3D25MGKf7M13qoqcmjumPglv7K0cWhNO1Kk=;
        b=Tl38fsch5m697MlsfHXxhKa4NsmKGUJz4p+xaoAh8jLzeyLzltVREfXEy9/7M5sTkOqHA6xUzW0ofA9xyVyt4Fdhyb69fRcTXOvWuugZ60Lq9Mg8t3jtCwKaIbm4Pzy7Y8BivvWUT1zETGgJVZJX1V4YNTpHYJHyVuxzws3gTjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TQR7CpqPjpn4KuYpDY8uWwBWSjHCqKxdjSQVv4vHPzUqSfUGrDstwNAnjHeSwjbE4JXClUVPwwBRvAaJReHEPNJ3aDbVSqApkSi5aCyTahLBGBFS+cUEy7cyhBArQM9QwM6kZ80/eGSe3EJsWDRWZDiRsWU3ooTLnIbUG+vTvBA=
Received: by 10.67.106.19 with SMTP id i19mr1231651ugm.1195473435206;
        Mon, 19 Nov 2007 03:57:15 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.241.246])
        by mx.google.com with ESMTPS id 13sm8705217fks.2007.11.19.03.57.12
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Nov 2007 03:57:13 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <b0943d9e0711190320r28224763t5a6c9ed7758a12b3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65431>

Catalin Marinas wrote:
> On 18/11/2007, Jakub Narebski <jnareb@gmail.com> wrote:
>
> > I use Stacked GIT 0.13 with git 1.5.3.5 (and Python 2.4.3).
> > StGIT does recognize old StGIT branches (and converts them),
> > but "stg branch -l" list only one branch. I guess that is
> > cause by the fact that all the rest of branches are packed.
> 
> Have you tried the latest StGIT snapshot? We added support for this
> and it will be available in 0.14 (to be released pretty soon).

Would it work with Python 2.4.3? Yes, I know I should upgrade my
Linux distribution (I use now Aurox 11.1, which is based on Fedora
Core 4)...
 
> > Another StGIT question: how to check if given branch is controlled
> > by StGIT (needed for my bash prompt)?
> 
> 'stg branch -l' lists the branches and marks those controlled by
> StGIT. For a simple test, just use a command which would fail on
> non-stgit branches (stg id base). Yet another way is to check for the
> presence of '.git/patches/<branch>'.

Thanks. 'stg id base' is quite a lot slower than 
'test -e "$(git rev-parse --git-dir)/patches/$branch"', and it _does_
matter in prompt creating.

-- 
Jakub Narebski
Poland
