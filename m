From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: repo.or.cz: broken links
Date: Sun, 17 Feb 2008 10:16:53 -0800 (PST)
Message-ID: <m34pc7bg8n.fsf@localhost.localdomain>
References: <20080217175337.GA27741@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Wincent Colaiuta <win@wincent.com>,
	Peter Oberndorfer <kumbayo84@arcor.de>
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Sun Feb 17 19:17:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQo4x-0007zW-Oj
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbYBQSQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbYBQSQ4
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:16:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:12872 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbYBQSQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:16:56 -0500
Received: by ug-out-1314.google.com with SMTP id z38so203673ugc.16
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 10:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=fXrsFm+OPhZQB2fn6T7lc7OEY2EuUVXkNMiGpYVM6RQ=;
        b=lZ99vjaJ6ZsVHaFu34agyjvgjVHbebQLvT7n+vbryUo4fRRFTHhH1bfB2tcFh0W6Iaaq/5VQ7p3IDMXikBjzMhTqYrQ1Ql5iv6nhBIVmqm02Bi8RZmrNllJtR5taxEFGJJPFfoxBy2ace/lSNMcbw3MBQvo3lQepVoyXMaL8I0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=UKgP5kOxSk+GrHApcjpksY0P7kjtIz+/VIALEknET6slUwVi71Ktw+6KqfYMF+Ry/+ppLrVaOfeEqElxxC8zisVP3SMwmGmPt3j2S3JYHwhych2RW7Pw8pummJsJx2qM7OsLatt9nhw8YUDDWnRIQ3wKGQvOBXu6ytpu3UHbJ0k=
Received: by 10.67.95.4 with SMTP id x4mr2172596ugl.26.1203272214620;
        Sun, 17 Feb 2008 10:16:54 -0800 (PST)
Received: from localhost.localdomain ( [83.8.248.52])
        by mx.google.com with ESMTPS id i30sm1084335ugd.38.2008.02.17.10.16.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Feb 2008 10:16:53 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1HIGlXu030671;
	Sun, 17 Feb 2008 19:16:48 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1HIGeIt030668;
	Sun, 17 Feb 2008 19:16:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080217175337.GA27741@auto.tuwien.ac.at>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74152>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> If I click in http://repo.or.cz/w/alt-git.git?a=shortlog
> on the next page link, which display a 403 page:
> 
> http://repo.or.cz/w/ARRAY(0x85e1bd8)?a=shortlog;pg=1

Thanks. This is being worked on. It was reported independently also by
Peter Oberndorfer and Wincent Colaiuta.

It is caused by/in href(..., -replay). The problem is that the patch
fixing it fixes it on my machine, while Wincent Colaiuta reports that
it is still broken for _some_ links (although not for the pagination
links above)
  Message-Id: <C8D96592-DD9C-47D3-93AB-3F74719F4D46@wincent.com>
I have got no response from Petr "Pasky" Baudis, admin of repo.or.cz

I'm of half of a mind to just revert the whole href(..., -replay)
series... 
-- 
Jakub Narebski
Poland
ShadeHawk on #git
