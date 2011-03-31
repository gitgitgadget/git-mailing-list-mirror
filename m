From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] revisions.txt: structure with a labelled list
Date: Thu, 31 Mar 2011 14:46:23 -0700 (PDT)
Message-ID: <m3mxkb3qwt.fsf@localhost.localdomain>
References: <cover.1301569271.git.git@drmicha.warpmail.net>
	<9e7095318e6dc40657db0cfef3400a66f6de20a4.1301569271.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 23:46:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5PhH-0003F3-2K
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 23:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759035Ab1CaVq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 17:46:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49760 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab1CaVqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 17:46:25 -0400
Received: by wwa36 with SMTP id 36so3341871wwa.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=ImtFk0+0RKN8beD8nlgHNO4Drjb71eVP+udRh3pJXnw=;
        b=hqPrzZ3GQjhLAwYWNfwc1dTxNrjjsVakjmsdwGUFcW36eCuGda4kmORr1x2OvZGdc+
         110sYQd/mc5VWcCBudFqaQaZOE6v3UbyJDRyRJz03yUy9cx9OiU3CxyDjMoEHmi1I1cl
         6VXHk/C4s+0P1K44aj2Vymo1Kjo/SRL7yA21g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=VXJfUOYewyadbEnSb79acAHmKXhRY6om+WL5kJRdTK+nO3+vdrwynUyuNkjTIwm0la
         k1OxydPfyH0DWna0UM4TDuL7XrC2xiaSwW0jkskwYTHxXcjvhDeA3Xi7yOWvXZNlD6tf
         Uxi3gKR9VnxllyLFjnI5b7P2uY1XEfcLkP0EM=
Received: by 10.216.239.73 with SMTP id b51mr23318wer.44.1301607984279;
        Thu, 31 Mar 2011 14:46:24 -0700 (PDT)
Received: from localhost.localdomain (abwa39.neoplus.adsl.tpnet.pl [83.8.224.39])
        by mx.google.com with ESMTPS id j49sm724619wer.14.2011.03.31.14.46.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 14:46:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2VLjs1T000935;
	Thu, 31 Mar 2011 23:46:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2VLjcu4000931;
	Thu, 31 Mar 2011 23:45:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <9e7095318e6dc40657db0cfef3400a66f6de20a4.1301569271.git.git@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170533>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> -* The special construct '@\{-<n>\}' means the <n>th branch checked out
> +'@\{<n>\}', e.g. '@\{-1\}'::
> +  The special construct '@\{-<n>\}' means the <n>th branch checked out
>    before the current one.

I think you meant

  +'@\{-<n>\}', e.g. '@\{-1\}'::

here.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
