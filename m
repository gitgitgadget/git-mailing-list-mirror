From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2011, #07; Wed, 27)
Date: Thu, 28 Apr 2011 12:39:02 -0700 (PDT)
Message-ID: <m37haew4io.fsf@localhost.localdomain>
References: <7v1v0n75rj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:39:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFX3P-0007aO-Up
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188Ab1D1TjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:39:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59233 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756370Ab1D1TjF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:39:05 -0400
Received: by fxm17 with SMTP id 17so2043809fxm.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=fvwdSJPncax89r2AiHJIKipypFAVYKQKtuVxmYUN9XY=;
        b=cTEk1Rjzup4DfayqVmfAuDP2vpUFcQcp4iJaWbuE4S0uJwL+tzb6P6QhXHlrLGjtiG
         uAatWBiCZ1GwafVfjXclU11BLVWqKBfvVkDIXGVpsQi3A36WF4hlMQRrT3meZvhgipr1
         dIzjjowNA3OEiC//G8v5ojX+xJ36dT3pJ++gE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=JCsfccScmyY5Fcj4CBysApsNHkEDljG6yU8HewPtY0CdgyDcC/dCLKj4a/5LqzgXQB
         ux1Xxqbb7DflxMmndWACVYp29oAVkiTu42xDiGKMu5tjf0PsoYSVhGbaaYYH9A6NN7xr
         wUrWW0K6FRo4MTyVnE8XEPgz5uz47Mn5zUffw=
Received: by 10.223.25.152 with SMTP id z24mr882540fab.123.1304019543211;
        Thu, 28 Apr 2011 12:39:03 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id j18sm677590faa.42.2011.04.28.12.39.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:39:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3SJcOSZ012772;
	Thu, 28 Apr 2011 21:38:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3SJc8E3012768;
	Thu, 28 Apr 2011 21:38:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v1v0n75rj.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172398>

Junio C Hamano <gitster@pobox.com> writes:

> What's cooking in git.git (Apr 2011, #07; Wed, 27)

> --------------------------------------------------
> [New Topics]

> * ft/gitweb-tar-with-gzip-n (2011-04-26) 1 commit
>   (merged to 'next' on 2011-04-26 at 8e59a0e)
>  + gitweb: supply '-n' to gzip for identical output
> 
> Will merge to "master" by the end of week #2.

Nice.
 
> --------------------------------------------------
> [Stalled]
> 
> * jn/gitweb-js (2011-04-15) 13 commits
>  - gitweb: Make JavaScript ability to adjust timezones configurable
>  - gitweb.js: Add UI for selecting common timezone to display dates
>  - gitweb: JavaScript ability to adjust time based on timezone
>  - gitweb: Unify the way long timestamp is displayed
>  - gitweb: Refactor generating of long dates into format_timestamp_html
>  - gitweb.js: Provide getElementsByClassName method (if it not exists)
>  - gitweb.js: Introduce gitweb/static/js/lib/cookies.js
>  - gitweb.js: Extract and improve datetime handling
>  - gitweb.js: Provide default values for padding in padLeftStr and padLeft
>  - gitweb.js: Update and improve comments in JavaScript files
>  - gitweb: Split JavaScript for maintability, combining on build
>  - Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
>  - git-instaweb: Simplify build dependency on gitweb
> 
> I do not recall seeing this series much reviewed. Is everybody happy with
> this series?

I have just resend this series in cleaned up form, containing all the
fixes and extra patches; in fact nearly the same as 'jn/gitweb-js'
branch.  It includes comparison to J.H. patch.

I think it addresses all the issues Kevin and you found with previous
versions; I haven't heard from J.H. yet.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
