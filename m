From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: side-by-side diff for gitweb?
Date: Thu, 11 Jun 2009 13:03:12 -0700 (PDT)
Message-ID: <m3zlce35ds.fsf@localhost.localdomain>
References: <3a69fa7c0906111241w3d105003xecb44125822ac501@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 22:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEqUe-0002w8-2W
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 22:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbZFKUDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 16:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbZFKUDN
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 16:03:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:1905 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbZFKUDM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 16:03:12 -0400
Received: by fg-out-1718.google.com with SMTP id 16so536117fgg.17
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 13:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=gscI0ZL9aBaJ2d5wxtbt7oummLKKo+Og4VWN+jW0ayI=;
        b=PY7g5FExPbtvTnUO7DxC6oN/D9JsEqMZZeHU1bhWnwMeEzbDltXwM6sxX5vseaHC0m
         yzw63tHIKOWR7uGXARyL0A355gegr6Ie4+Jc7FWZOlf+JEJ6poG4piIni0HMC0mEI6He
         L0vRlIIZ062PqDv1q4XpN/R/j5s8DHGfPwedw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=dNsZAozS+Tf/TMutocXvLOi+SukcPZsT8lbUYls9nIfs8saLHQ60N8qxjy3Phrg+Bq
         1in49zfU6SqXzJjzOs7TTwlNofbBomg6/rCfTEpDQTqcsM7mx87YnM3O5eat1WPPNs9B
         3hsuRaYZ+RwUvX1ivUTza+7FMpCQ5DQmCk/RM=
Received: by 10.86.86.2 with SMTP id j2mr2698131fgb.74.1244750593413;
        Thu, 11 Jun 2009 13:03:13 -0700 (PDT)
Received: from localhost.localdomain (abwl198.neoplus.adsl.tpnet.pl [83.8.235.198])
        by mx.google.com with ESMTPS id e11sm3173791fga.21.2009.06.11.13.03.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 13:03:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5BK3Dnx015446;
	Thu, 11 Jun 2009 22:03:13 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5BK3BB1015437;
	Thu, 11 Jun 2009 22:03:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <3a69fa7c0906111241w3d105003xecb44125822ac501@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121357>

E R <pc88mxer@gmail.com> writes:

> Is there a a side-by-side diff viewer for gitweb?

No, it is for a long time on TODO list for gitweb, but it never got
implemented.

> If not, any suggestions for the best way to go about implementing one?

Take a look at other web interfaces in Perl, and find how they do it
(IIRC Codestriker web review tool is in Perl, and has side-by-side
diffs).  Ask on #perl.  Ask on perlmongers.  Search CPAN[1].

[1] Note that we frown upon introducing extra dependencies for gitweb,
unless they are optional, and best detected automatically.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
