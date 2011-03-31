From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: compare log of two different repos
Date: Thu, 31 Mar 2011 12:34:32 -0700 (PDT)
Message-ID: <m3r59n3x0d.fsf@localhost.localdomain>
References: <1301514556812-6224714.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sri <nkf364@motorola.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:34:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Ndh-0002Ey-Hu
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 21:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759073Ab1CaTeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 15:34:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33802 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758969Ab1CaTef (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 15:34:35 -0400
Received: by wwa36 with SMTP id 36so3221166wwa.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 12:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=nBnym4KXjyQmKn0OZavdlujoE0WNQyth5jlcHuN0tXY=;
        b=rkN+xHGvVf7lQRHU1P+JnApGwCxFcsV9I6+XVI31atoyRgTQ9RtddlU/7fjVFzaA6H
         2iRPeMpUX6yqnLQOFw/zHM5y5c/jrg29ToxRXns+LbI0Hbw9SXcfk2qo064y3kBgmOdM
         F4Y7oPScH2ItOX5zKXk1YOR2UhEOSm1hfxqnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=hIqmemb3BtnL176fLEzXDyRzbsoCVpnyka16B4tZ4Zp48tCPXIRy3sUPL+je20WEa4
         fqM4uoEij1zkSxaw8K0neegdHuPQ6XeTlpZk52yHICp1y2BlZwvnVK8BI11do9TvcLXP
         HDqxN8miQ8C2AnomfvKut5wwEOaF+mr6wzoYA=
Received: by 10.216.67.1 with SMTP id i1mr2927261wed.62.1301600073898;
        Thu, 31 Mar 2011 12:34:33 -0700 (PDT)
Received: from localhost.localdomain (abwa39.neoplus.adsl.tpnet.pl [83.8.224.39])
        by mx.google.com with ESMTPS id g32sm675503wej.27.2011.03.31.12.34.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 12:34:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2VJYBmF032690;
	Thu, 31 Mar 2011 21:34:22 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2VJXtZC032684;
	Thu, 31 Mar 2011 21:33:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1301514556812-6224714.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170525>

Sri <nkf364@motorola.com> writes:

> Hi
> This is my scenario:
> - Server has 2 different repos say x & y
> - I created a branch out of x ( say xx) and a branch out of y (say yy)
> - Now I made changes to xx/folder1/file1- change 1and commit it ;then I made
> changes to to yy/folder1/file1 -change 1 and yy/folder1/file 1 -change 2 and
> commit it ( Folder 1,file 1, change 1 are same in both xx and yy)
> - Now I want the log of unique commits between both branches ( which will be
> change 2 commit in yy)
> 
> How do I get this using GIT? Right now am doing it manually which is very
> tedious...

Besides adding one repository as remote in other repository, using
"git remote add", you might also use the trick described here:

  https://git.wiki.kernel.org/index.php/GitTips#How_to_compare_two_local_repositories

-- 
Jakub Narebski
Poland
ShadeHawk on #git
