From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Port to 12 other Platforms.
Date: Sun, 08 Jun 2008 08:46:43 -0700 (PDT)
Message-ID: <m3prqsvsiq.fsf@localhost.localdomain>
References: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 17:47:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5N7O-0007ji-Sf
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 17:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbYFHPqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 11:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754671AbYFHPqt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 11:46:49 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:51177 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbYFHPqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 11:46:48 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1240792mue.1
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=EXe0Nn5htUPUQc9/O724B72A0TjkWrVVe8lL/IOVVKw=;
        b=GqNCZhsera8wQ7RETHwZOM0+F7d6v0m8vIgooDjxJDivVBxgYH++qYy/JX2iyphjhI
         fjrP4OrV0Efv3r1zirweV5gjcdlP+pXscgfFkiJM3KgPAgHCjO2sYZsTWlpnlg0oXp2A
         fbe6A9Xcf9LGge44zyQvsFcy12NhULuh1aL5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=KpsEh0dJX7TnvB7gDDOxKiCvVyGDbZ6Mr6LzY7tSIOhA2C0wXa3FxJH7+DN3QTR8pM
         4jLC9u9xhuNaDqeaakuxZ3AWzfq80qOt86QXXSVjikfpYWPEhdHzLsBkDmJNyXByxg3t
         xX8gG7hTrKeIf5CtfM3OM2VCmt93D6/eFFLh0=
Received: by 10.103.16.14 with SMTP id t14mr1596921mui.130.1212940006998;
        Sun, 08 Jun 2008 08:46:46 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.161])
        by mx.google.com with ESMTPS id y37sm13814498mug.9.2008.06.08.08.46.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 08:46:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m58FkehA008632;
	Sun, 8 Jun 2008 17:46:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m58FkbHU008629;
	Sun, 8 Jun 2008 17:46:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84283>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> This patch adds support to compile git on 12 additional platforms.
> They are based on UNIX Systems Labs (USL)/Novell and SYS V
> based OS's, SCO OpenServer 5.0.X, SCO UnixWare 7.1.4, OpenServer 6.0.X and
> SCO pre OSR 5 OS's to build and run git.
> 
> Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com> 
> ---
[...]
> git-compat-util.h
> 
> __USLC__ indicates UNIX System Labs Corperation (USLC), or a Novell-derived
> compiler and/or some SysV based OS's.
> 
> __M_UNIX indicates XENIX/SCO UNIX/OpenServer 5.0.7 and prior releases
> of the SCO OS's.  It is used just like Apple and BSD, both of these
> shouldn't have _XOPEN_SOURCE defined.

Above info is neither in commit message, not in comment in some file.
It would be nice to have it in somewhere, and not only in mailing list
archives.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
