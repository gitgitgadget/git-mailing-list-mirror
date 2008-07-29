From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Hackontest ideas?
Date: Tue, 29 Jul 2008 02:24:43 -0700 (PDT)
Message-ID: <m3myk1t54c.fsf@localhost.localdomain>
References: <20080729000103.GH32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Jul 29 11:25:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNlSo-00068N-Ut
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 11:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbYG2JYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 05:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755077AbYG2JYt
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 05:24:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:13591 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbYG2JYr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 05:24:47 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1637880nfc.21
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=+jF5b4CNfEskHF4iY2QTuWM40A1UZQxGobi8QBoHFl4=;
        b=sVN+jMvepMdz8Bm+zIBdXm3p6C6xb5jgadNL0hIbbLSXv7/2tm8gY/I62CTNtTMhlt
         gcCE8h12Va34UHsXvqNcWI+k8bg24AlNXqiI0NZP0O7pYvtjowmf70omFTIy71B2ZEK1
         NP64w8g4WqiGS+6o8m41fhNpneiHHhnRqVJNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=HbvurbdI9ZOwTq7MRKElX2Nfg2l8KK1Y4FZs/ZQx4s2DTl3tcTLqBkx3S5zzGoK7oJ
         vcL0nLe8E6VUpiuGjzbG6Hvc6b77rtamlS/pakKVMhEtBFZQ9Jiz+ZRbL3BZLx+CYjsq
         Bs6MRoMEoAV7TDZewBedNq3JKJEUiLje6DaL0=
Received: by 10.210.71.13 with SMTP id t13mr7312563eba.42.1217323485486;
        Tue, 29 Jul 2008 02:24:45 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.244.7])
        by mx.google.com with ESMTPS id y34sm21525266iky.10.2008.07.29.02.24.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jul 2008 02:24:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6T9Obdr009374;
	Tue, 29 Jul 2008 11:24:37 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6T9OaKD009371;
	Tue, 29 Jul 2008 11:24:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080729000103.GH32184@machine.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90608>

Petr Baudis <pasky@ucw.cz> writes:

>   Hi,
> 
>   participating in this might be fun, even if there is not much time
> left to sign up:
> 
> 	http://www.hackontest.org/index.php?action=Root-projectDetail(120)
> 
> (What feature in Git or a Git-related tool would you implement, given 24
> hours staight and unlimited pizza supply?)

A few ideas (some might be repeated)
 * resumable clone
 * git-push implemented as CGI
 * support for ftp, ftps, sftp fetch
 * support for gits (git over SSL/TLS) fetch
 * relative blame, i.e. if you have blame data for some revision
   (for example in "git gui blame") you want to have data for some
   revision which is either direct ancestor or direct descendant
   of the revision you have blame data for, aka "git blame --relative"
 * "tree" blame, i.e. something like VievVC or GitHub shows:
   for exach entry in a tree commit which brought it to current version
 * graph log for gitweb, either generating images on the fly, or using
   a few pre-defined images ('|', '-', '\', '/', etc.) and CSS.
 * "MediaWiki history"-like or "MoinMoin info"-like view for gitweb
 * improvements to "git log --follow" so it works also for nonlinear
   history (for example "git log --follow gitweb/gitweb.perl" following
   to the very first version of gitweb, then as gitweb.cgi)
 * graphical history viewer for Git mode in Emacs.
 * context sensitive searching in gitweb, for example searching
   commits on given branch, or grepping files in given directory
 * handling of svn:externals using submodules
 * custom merge strategy for ChangeLog, for .po files

Blame merge strategy would take probably much more that 24h solely
in the initial design phase...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
