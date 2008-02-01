From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Fri, 01 Feb 2008 03:19:03 -0800 (PST)
Message-ID: <m37iho9b70.fsf@localhost.localdomain>
References: <7ihp802o.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 12:19:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKtvr-0001UM-7r
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 12:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738AbYBALTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 06:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756147AbYBALTJ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 06:19:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:37661 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbYBALTI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 06:19:08 -0500
Received: by ug-out-1314.google.com with SMTP id z38so732167ugc.16
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 03:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=UEq8Jd6+olhKu2g5vCpx34HPiAi4bRVkfvIZaRxMpmE=;
        b=HOHCJT/yUo+v9SZyfuDfOV4LgbrRBTHSyfS8OhmcuZ1jPEwj1os5WAP/D6NdXnUGGUhNtvFnmrun17ASZCwt86h4nyMqSNmMEHEgNSy4S2I7+4dDVR/p8mzUcDG2e25VlFImMlkVNUZulir/HvpHc3u0cVfR+JMjCvQ6yaY+iAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=AU/KJqUAmzeyeF8QEUwccneC6Wfd/oBEM15cdMWn+hI+VTWYGukbBjBdPMA70sPXtMNEq0XzahDOlV3AL2Wowoh8D2f72ds+A+KWzw+wWrAQOgqQK9xC33kfdk0fcwYwKTX/D15ilThZZnKPBQIjWeom3z565VVibSkyc8XIVuY=
Received: by 10.67.122.10 with SMTP id z10mr5343862ugm.44.1201864746796;
        Fri, 01 Feb 2008 03:19:06 -0800 (PST)
Received: from localhost.localdomain ( [83.8.248.93])
        by mx.google.com with ESMTPS id 18sm10921736ugk.18.2008.02.01.03.19.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Feb 2008 03:19:03 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m11BIwOq016602;
	Fri, 1 Feb 2008 12:18:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m11BIhhE016594;
	Fri, 1 Feb 2008 12:18:43 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7ihp802o.fsf@blue.sea.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72168>

Jari Aalto <jari.aalto@cante.net> writes:

> Change (list|...) to <list|...> to denote required command. Adjust
> the 'save' command syntax to better reflect the call parameters:
> [save] [message...] => [save [message...]].

While I agree with the second change, i.e. the "[save [message...]]"
part, I think that the first part is a mistake.  Parentheses does not
imply the optional part: brackets do; parentheses are meant to
delimit the alternatives.  Angle brackets if I understand correctly
are meant to denote part which you have to enter, the user supplied
info (the reast ou have to enter literally).

So IMVHO the SYNOPSIS for git-stash(1) should read:

SYNOPSIS
--------
[verse]
'git-stash' (list | show [<stash>] | apply [<stash>] | clear)
'git-stash' [save [<message>...]]

or

'git-stash' [save [<message...>]]

> -- 
> Welcome to FOSS revolution: we fix and modify until it shines
> 

Nice one. Can I add it to http://git.or.cz/gitwiki/FortuneCookies ?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
