From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] diff: parse separate options like -S foo
Date: Thu, 05 Aug 2010 05:16:38 -0700 (PDT)
Message-ID: <m3zkx1ntkk.fsf@localhost.localdomain>
References: <vpqmxt14gjt.fsf@bauges.imag.fr>
	<1280996576-1165-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 05 14:16:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgzNN-0007BW-W6
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 14:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759112Ab0HEMQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 08:16:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40296 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878Ab0HEMQl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 08:16:41 -0400
Received: by fxm14 with SMTP id 14so2802194fxm.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=c9fgisja5owTHQ+nebuV5jwdYnz+j2b08TNkRGquqLY=;
        b=GjX7bJxd+1kg0DpkQpYtML35VnkCXpSyE12kUlGfbvcFNrby3HR6tCJQaue2Ehh5JN
         VJooZF+rv5vsV+Ilo8tWZ7s6qC2KErQW/kec33yvZwwCO8xJE4tCHPZjp0/coJ/5XDne
         8oaOWjv+nEnS1LaqonahxFwH53Pcd2aMhrvQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Rs67CuUXRs2UBFcyJfZrrj/TyOjZG5AghRGA8TigbvdX+K/S9glUtAEi3fpc+pbtbc
         pcP6yyLP8quupjcJZme/2DAdvjWmSj/ajbuoHfpMkRq2tD6LeiBg3wp/W6q8M4hRA0Js
         8j1QQl1cQTX4pV7+hsaSmyQAI7NGQmxrBpSAU=
Received: by 10.223.124.205 with SMTP id v13mr10490990far.94.1281010599724;
        Thu, 05 Aug 2010 05:16:39 -0700 (PDT)
Received: from localhost.localdomain (abvh194.neoplus.adsl.tpnet.pl [83.8.205.194])
        by mx.google.com with ESMTPS id c5sm46543fac.43.2010.08.05.05.16.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 05:16:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o75CGaWd032427;
	Thu, 5 Aug 2010 14:16:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o75CGDlL032408;
	Thu, 5 Aug 2010 14:16:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1280996576-1165-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152650>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +static inline int short_opt(char opt, const char **argv,
> +			    const char **optarg)
[...]
> +int parse_long_opt(const char *opt, const char **argv,
> +		   const char **optarg)

Just a nitpick question: why it is 'parse_long_opt' but just 'short_opt'?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
