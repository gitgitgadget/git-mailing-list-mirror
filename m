From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log --stat FILE
Date: Sun, 08 Aug 2010 04:54:48 -0700 (PDT)
Message-ID: <m339up48vz.fsf@localhost.localdomain>
References: <yf9wrs1fili.fsf@chiyo.mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Sun Aug 08 13:55:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi4Sx-0001yN-Fi
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 13:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650Ab0HHLyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 07:54:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47796 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab0HHLyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 07:54:52 -0400
Received: by fxm14 with SMTP id 14so4556359fxm.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=jHRBInIWzr0p+9N00mU+T30yMkPWYoAb6OY6AKL2JpQ=;
        b=CIis/70YlKNPs3KtcCN9uRUg6AyA7Yifhtfk3mvmUmZxX7J1Q7aQlWBkeMAbgP9CXx
         0BDTM+T0PrEy57vZBhgYHsu58bzMmaYUsZfWJaS0E8zuI5wZHnlBk3uPKbaf4uAPfC9N
         F91NTWJfYtX5vF6YoJFjXueZQSZ80tCp6J8cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=L5Hr17uwZOspSihCccZ1B3p+dfHUAGOxivaD4byGO6RkMHAa3zVuqVjJHyN/wYaoRX
         t9XrjW/LzZHPHAGF3ZbepDgy38yvlvt+bEP+STiztr6m749gAP41UwT2W9qIQ29E1Zno
         uFRPtM8ug/mrc+c8HXGDz25kM8f8Q1r+dpUbY=
Received: by 10.223.121.133 with SMTP id h5mr15201771far.74.1281268490501;
        Sun, 08 Aug 2010 04:54:50 -0700 (PDT)
Received: from localhost.localdomain (abwa128.neoplus.adsl.tpnet.pl [83.8.224.128])
        by mx.google.com with ESMTPS id r8sm1405997faq.10.2010.08.08.04.54.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 04:54:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o78BspXc006068;
	Sun, 8 Aug 2010 13:55:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o78BsetK006062;
	Sun, 8 Aug 2010 13:54:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <yf9wrs1fili.fsf@chiyo.mc.pp.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152900>

Marcus Comstedt <marcus@mc.pp.se> writes:

> Hi guys.
> 
> I'm probably just missing something here, but I've run across a rather
> annoying behavior of log.
> 
> When I do "git log --stat FILE", then only commits which touch FILE
> are displayed, as expected.  However, contrary to expectation (well,
> my expectation at least), the stat shows that only one file (FILE) is
> modified by the commits, even if they actually modified multiple files.
> That's not what I wanted; I used FILE to select commits, not to
> control how they are presented.  In fact, the information which is
> hidden is exactly that which I wanted to see; the whole reason for the
> --stat was that I wanted to know what _other_ files were modified
> together with FILE.
> 
> What's worse, I could not find how to circumvent this behavior, [...]

See --full-diff option to git-log.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
