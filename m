From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #02; Wed, 4)
Date: Thu, 05 May 2011 02:08:32 -0700 (PDT)
Message-ID: <m3sjstv7kz.fsf@localhost.localdomain>
References: <7vsjstc1pp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 11:08:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHuY5-0001RZ-Oj
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 11:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab1EEJIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 05:08:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42010 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab1EEJIf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 05:08:35 -0400
Received: by bwz15 with SMTP id 15so1653422bwz.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 02:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=WzaVJJ+blip/D2ZOL44cM+Z/iBAVPCa3aoZwCpPraxo=;
        b=ZpXYUjm9UGHuxiV9mEb53ZDraAixBFMUW8gRU1jRbo0VfKR+9A7hUTeJOD8YQWKsOL
         9vb6t3vp2QZPWLms8tGG4KBG//WuxqxnnykigoI4kktaJVB+FQPtTl5DM3vv3rqRyiIb
         vqa+FzpdpcAQj66yT6yycmupPuxHjIemrgkBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=m+ubtQB6Pnt+zQndWUF0RVafrctj5jEhdqoPXEInrnqRP9du/T6Sqdg26Rmso5GW0+
         sTyAtZBojlSKhTW/drU1ha9EfyRbFJA4jkVBp8/NXUVnP6FXRG8kWGJ8hTwfqHpAeh8C
         8g+vpGQjYuJ/ZHtyQyRIMknxh/V0gv4KWZAug=
Received: by 10.204.19.5 with SMTP id y5mr606202bka.194.1304586513908;
        Thu, 05 May 2011 02:08:33 -0700 (PDT)
Received: from localhost.localdomain (abwg161.neoplus.adsl.tpnet.pl [83.8.230.161])
        by mx.google.com with ESMTPS id q24sm1249105bks.9.2011.05.05.02.08.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 02:08:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4597vl6004779;
	Thu, 5 May 2011 11:08:08 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4597f9D004775;
	Thu, 5 May 2011 11:07:41 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vsjstc1pp.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172820>

Junio C Hamano <gitster@pobox.com> writes:

> --------------------------------------------------
> [Stalled]
> 
> * jn/gitweb-js (2011-04-28) 13 commits
>  - gitweb: Make JavaScript ability to adjust timezones configurable
>  - gitweb.js: Add UI for selecting common timezone to display dates
>  - gitweb: JavaScript ability to adjust time based on timezone
>  - gitweb: Unify the way long timestamp is displayed
>  - gitweb: Refactor generating of long dates into format_timestamp_html
>  - gitweb.js: Provide getElementsByClassName method (if it not exists)
>  - gitweb.js: Introduce code to handle cookies from JavaScript
>  - gitweb.js: Extract and improve datetime handling
>  - gitweb.js: Provide default values for padding in padLeftStr and padLeft
>  - gitweb.js: Update and improve comments in JavaScript files
>  - gitweb: Split JavaScript for maintability, combining on build
>  - Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
>  - git-instaweb: Simplify build dependency on gitweb
> 
> Rerolled.  Waiting for comments.

Should I extract first two commits i.e.

   - Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
   - git-instaweb: Simplify build dependency on gitweb

into a separate patch series?  Even though their existence was
triggered by further patches in series, or to be more exact

   - gitweb: Split JavaScript for maintability, combining on build

I think this cleanup is worthy on its own.
 
> * jn/ctags (2011-04-29) 6 commits
>  - gitweb: Optional grouping of projects by category
>  - gitweb: Modularized git_get_project_description to be more generic
>  - gitweb: Split git_project_list_body in two functions
>  - gitweb: Mark matched 'ctag' / contents tag (?by_tag=foo)
>  - gitweb: Change the way "content tags" ('ctags') are handled
>  - gitweb: Restructure projects list generation
> 
> Waiting for comments.

Should I do and post benchmarks for

   - gitweb: Restructure projects list generation

change (when 'forks' feature is used)?

Note that "gitweb: Mark matched 'ctag' / contents tag (?by_tag=foo)"
has ACK from Petr Baudis ('pasky').  I think http://repo.or.cz is main
or even only user of content tags.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
