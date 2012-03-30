From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Fri, 30 Mar 2012 14:29:20 +0100
Message-ID: <201203301529.20942.jnareb@gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com> <201203291114.15284.jnareb@gmail.com> <CACeyogcCGhqcQp98JFJVntP9=BvX0TkMWA5JPj7At0bxPwvmfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: chaitanyaa nalla <nallachaitu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 15:29:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDbtY-0000pr-M8
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 15:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760768Ab2C3N31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 09:29:27 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:61793 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933630Ab2C3N3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 09:29:24 -0400
Received: by wibhr17 with SMTP id hr17so685911wib.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=iD6GVk5h+A/S//L9UbLIUCFPfRSYxTo58tqjr0M4L1M=;
        b=kN87vHqlhhE2gowh+F2hrzoP33CIEpTLlzRrCS3CZBJFGA0z0xDWk2enGIwnmxme80
         lVJX4FtRcKDaQTGnO/HeuddH9/Zd6fgKWhADc7Lvz7E6aQELxuYNxc98vtUSZiNbdyBa
         5CcKg9Z7VE/5ofIRCD1Ra6LgDjzWyG88mg6CZfevm9mq/QSiZeqslZfCWmbf+A3gAe2f
         J+/MQsjaQS0ZS5RnlCvzzRqeHUctrvLG2JJck/8M36ye/3VBRWt9Ab4LzmpQToGHWd5y
         3v/ebXtfvGpClNQKKDuYFit2WmW5WNjHcZiGlYqEoRNf0DClbXnO+75zMUoSFkCQLfLm
         AHfQ==
Received: by 10.180.91.10 with SMTP id ca10mr6475059wib.17.1333114162551;
        Fri, 30 Mar 2012 06:29:22 -0700 (PDT)
Received: from [192.168.1.13] (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id fn2sm10406438wib.0.2012.03.30.06.29.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 06:29:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CACeyogcCGhqcQp98JFJVntP9=BvX0TkMWA5JPj7At0bxPwvmfQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194357>

On Thu, 29 Mar 2012, chaitanyaa nalla wrote:
> Jakub Narebski wrote:

>>  adding UI to compare arbitrary commits in the page
>>  using commitdiff view similar to MediaWiki page history view.
> 
> could you please tell me a rough estimate of how much time can it be
> completed? I am expecting to complete it with in 1 week.

Well, the goal is to add an UI to the existing gitweb ability of
showing (commit)diff between two arbitrary commits.


One solution would be to make use (perhaps only as inspiration) of
Martin Koegler <mkoegler@auto.tuwien.ac.at> patch from 2007:

  [PATCH 5/7] gitweb: Prototyp for selecting diffs in JavaScript
  http://thread.gmane.org/gmane.comp.version-control.git/44517/focus=44523


Another would be create in 'log' or 'shortlog' view ability to
diff between arbitrary commits, similar to MediaWiki (and other wikis)
page history view, e.g.:

  http://en.wikipedia.org/w/index.php?title=JQuery&action=history

Or you can take GitHub as source of inspiration.

Anyway any solution extending or creating a new log-like view will
require server-side changes, therefore I think 1 week might be a bit
too optimistic.

-- 
Jakub Narebski
Poland
