From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: small merge tool for temporary merges
Date: Sun, 10 Aug 2008 03:46:08 -0700 (PDT)
Message-ID: <m3ej4xtafq.fsf@localhost.localdomain>
References: <20080803163415.GB14513@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 10 12:47:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS8SA-0001RA-GT
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 12:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbYHJKqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 06:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbYHJKqM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 06:46:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:4986 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbYHJKqK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 06:46:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so837880fgg.17
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 03:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=SGYb4mPtrnb68yNpsOGxMX/RS/Yxo5yTKyZ2HegKHUs=;
        b=bEHN+jGRYEyQBJ76AEGDsnTo6PUrdJcUI4TxIB2jA6ZB2sF+qpCihBV8p+0m3rfQKU
         Tege8VM+mHPZ0iFAjjry3GWlIZc02u3HENsX4CqVaWzQegwHu7jb1FrTOLiwo8plV8Nh
         jFpMD8Ce3N6hEkrIP4IHgGtzt15/c9EVe2ceM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=DA31kopGccK3P4+Vz+h2HUGjoXdLKpI6MpgwbXa6xPu4UJbGdTj62t/frYkVSySm0A
         t8bAbGejUQZLVLXSdELQ4NMAmdHZ6YK+6goaMsFwLoJ7oPHRz87O7RtzxeGDMVtzHaUA
         Fv101XzWa1BRCcotedA79JrqWaKdChVaUMGs8=
Received: by 10.86.73.7 with SMTP id v7mr492634fga.53.1218365169305;
        Sun, 10 Aug 2008 03:46:09 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.213.251])
        by mx.google.com with ESMTPS id d4sm207494fga.8.2008.08.10.03.46.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Aug 2008 03:46:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7AAk2CL030470;
	Sun, 10 Aug 2008 12:46:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7AAk1OQ030467;
	Sun, 10 Aug 2008 12:46:01 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080803163415.GB14513@gmx.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91827>

Marc Weber <marco-oweber@gmx.de> writes:

> I'd like to announce the exisntance of my small git test merge tool.
> 
> After reading 
>  Linux kernel mailing list may remember that Linus complained about such
>  too frequent test merges when a subsystem maintainer asked to pull from
>  a branch full of "useless merges"
> in the man page of git-rerere I had to start it..

Could you add it to http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
when you feel it is ready (for example using '/bin/bash' or something
like that in the she-bang (#!) line)?  TIA.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
