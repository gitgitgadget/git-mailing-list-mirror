From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: To page or not to page
Date: Thu, 01 May 2008 23:56:15 -0700 (PDT)
Message-ID: <m3d4o56vlv.fsf@localhost.localdomain>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org>
	<20080502054508.GA28506@sigill.intra.peff.net>
	<20080502060930.GA1079@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 08:57:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrpCl-00037k-Qo
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 08:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757963AbYEBG4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 02:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757776AbYEBG4T
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 02:56:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:9152 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757204AbYEBG4S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 02:56:18 -0400
Received: by nf-out-0910.google.com with SMTP id d3so621419nfc.21
        for <git@vger.kernel.org>; Thu, 01 May 2008 23:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=Fvuyoi1Xlr3TVt+0zAw1HNdcAU/5Ss+hdaSNTZzk5QM=;
        b=GRFC0DnRJ0Y4Lq2HpYIuPDEs7SQ1N0HKxWj0ZppizecsSGrD86uLkHI10Rhquj30YGxhTYTc45g6sM1xR5WmM26fBbkCSGkVNxbD7MWdOeN8PqNo45qvSSuqKlINaRVK30gtfU2KzwKyrAYXk01GD6/4J5UvguPLhNmKmylBd/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=T6ZNAIffyjBRPvOnB+BtNlWDvrvtE9As6l5K5qDuR+cD38FtDq0ynzX2eJQ4lQVKygXdsSnS8A/Up4yhDxe70lZ4h27W9Zh+J7xhDRLujq02SR0pC7LM70qt+8NnhrH323EaA49Eacb48ldWtZld4sRAFqrhsYAYEnlor096Z4w=
Received: by 10.210.52.15 with SMTP id z15mr2677685ebz.103.1209711376510;
        Thu, 01 May 2008 23:56:16 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.103])
        by mx.google.com with ESMTPS id y34sm4754783iky.10.2008.05.01.23.56.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 May 2008 23:56:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m426w97l016041;
	Fri, 2 May 2008 08:58:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m426w5ch016038;
	Fri, 2 May 2008 08:58:05 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080502060930.GA1079@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80965>

Jeff King <peff@peff.net> writes:

> On Fri, May 02, 2008 at 01:45:08AM -0400, Jeff King wrote:
> 
> > I agree with you; I don't like it at all. Probably whether or not to use
> > a pager for a given command should be controlled by a "pager.<cmd>"
> > config variable.
> 
> Here is a quick and dirty patch to do that. It should probably be split
> into two (there is a big code movement of the commands array), and it
> needs documentation and tests. But I'm going to sleep for now.

You should then accept pager.core (or pager.ui) as alias to existing
core.pager configuration variable... well, perhaps you did that...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
