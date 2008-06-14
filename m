From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mercurial to git converter.
Date: Sat, 14 Jun 2008 09:48:14 -0700 (PDT)
Message-ID: <m3wsksotdq.fsf@localhost.localdomain>
References: <1168537766.22649.19.camel@localhost.localdomain>
	<loom.20080614T101342-542@post.gmane.org>
	<alpine.DEB.1.00.0806141648020.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Andrew <nick@nick-andrew.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 14 18:49:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Ywg-0000ik-8X
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 18:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbYFNQsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 12:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbYFNQsV
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 12:48:21 -0400
Received: from ag-out-0708.google.com ([72.14.246.242]:8944 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbYFNQsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 12:48:20 -0400
Received: by ag-out-0708.google.com with SMTP id 31so7883829agc.10
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=lgrsVvFRq4O/tigd8f5BnVjwPYuJMZ0LLrPVgOsRcOo=;
        b=rSXfPwRnnGBxI2kO+HXwjc0gqFZsF7jh0v7TCnNZA8vsckoFh4Aaqx6m88dpkQMh+X
         CPlXJrICxykiSFsJ9kgfMGRAFWHLJXb6g0efrdJTgDl8MXd6bmfmwgLmJLrIWtlREc73
         vTaoyt+kn76sykMr7EAhtgwMx/ddO2EA8BXCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=vWgY8M4mpFIgAQ2ZZ9u21pqdyeYPdWHd4AMl58Q7duhjgSdtazSrKiMD06KN8E/0nn
         4A+gnMpgOJAiyIOFzoBj/MoN+AD6RdjfRXrEhajjTwDNQDVxzD41QL4iDwzbhsM+CM1S
         oKPZe5tltKWyau5H3HR1AteIm2/vomXrSj/Mw=
Received: by 10.100.111.5 with SMTP id j5mr6007346anc.3.1213462098218;
        Sat, 14 Jun 2008 09:48:18 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.239.84])
        by mx.google.com with ESMTPS id b19sm7145794ana.19.2008.06.14.09.48.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 09:48:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5EGm7BN024960;
	Sat, 14 Jun 2008 18:48:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5EGm2G8024956;
	Sat, 14 Jun 2008 18:48:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0806141648020.6439@racer>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85022>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Sat, 14 Jun 2008, Nick Andrew wrote: 
>> Stelian Pop <stelian <at> popies.net> writes:
>> 
>>> hg-to-git.py can probably be greatly improved (it's a rather crude 
>>> combination of shell and python) but it does already work quite well 
>>> for me. [...]
[...]
 
> FWIW I switched my local mercurial2git conversion to the hg-fast-export 
> solution from 
> 
> 	git://repo.or.cz/fast-export.git
>
[...] 
> Originally, I did not try it because I thought it cannot operate in 
> incremental mode, but it can.

It can, or it can recently thanks to --export-marks / --import-marks
work?


It is nice that SCM-to-SCM converters seems to standarize on using
fast-import language as intermediary.  

IIRC fast-import by Shawn O. Pearce started as fast backend for first
cvs2git (unfortunately fork and not extension of cvs2svn) by Jon Smirl
(?) around time when Mozilla looked for SCM to move to from CVS.  (In
the end they choose Mercurial, mainly because of better Windows
support, and I think also better Windows GUI; I wonder how it works
for them now?).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
