From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git check out file time
Date: Sat, 07 Aug 2010 06:46:20 -0700 (PDT)
Message-ID: <m3aaoyo7sz.fsf@localhost.localdomain>
References: <AANLkTinuD8YQ+maWwD3v1C0B4YCOdTS4OsVjHLizga3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tong Sun <suntong001@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 15:46:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhjjJ-0002JL-2n
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 15:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762670Ab0HGNqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 09:46:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33051 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab0HGNqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 09:46:22 -0400
Received: by fxm14 with SMTP id 14so4338069fxm.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=GJAJCkr4dYHzPfGXk2MX7bJf1aXNuRGRqn7igOMywwE=;
        b=UsKql/65I0QzLTlonwW9GVAv3VD8DR0hIALSuFYDty8QYRO/rCvhg8j2qNm9ysrF9g
         Yy2y14+jNWW2pVL5nhGFrEpAu280UDjgxBsB/nY49ciU/JFwrEJX10nlLg3mgrlEg3wP
         x83c3CeJuP65HcSPwVNJxMXRU1Sz5JSqsj5qA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=OdI/U1RcdTdvFXXFD5g6B7nvn8rXvSq3w1QKDw6wMaKRaVotvKFK+QyU2m4pn+CdXF
         YhNchk864YchbZ5NR1d+WmuiuaGaeGH7v2ExfbQTTczWZxcsMix4NclNkK41+vmyFhA2
         560qPtYMFr1iyuUcY2pZeQKv8S04O0RjXb1Y0=
Received: by 10.223.113.65 with SMTP id z1mr14285054fap.38.1281188781110;
        Sat, 07 Aug 2010 06:46:21 -0700 (PDT)
Received: from localhost.localdomain (abwi49.neoplus.adsl.tpnet.pl [83.8.232.49])
        by mx.google.com with ESMTPS id r5sm1044160faq.8.2010.08.07.06.46.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 06:46:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o77DjlFZ004814;
	Sat, 7 Aug 2010 15:45:58 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o77DjYX4004807;
	Sat, 7 Aug 2010 15:45:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinuD8YQ+maWwD3v1C0B4YCOdTS4OsVjHLizga3c@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152858>

Tong Sun <suntong001@gmail.com> writes:

> Quick Q, is it possible to keep the original file time from the git
> server when checking out / cloning a local repo?
> 
> When I did
> 
>  git clone git://git.remote...
> 
> All my local git files are set to the check out time.
> 
> Please help and CC me when replying.

Only with third-party extra tools such as Metastore (or etckeeper that
uses it), or git-cache-meta (or IsiSetup), see
  https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools


Git itself doesn't store original file time, and with its intended use
it would screw up mtime-based make rebuilding.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
