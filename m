From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] autoconf: Add support for --infodir
Date: Fri, 27 Feb 2009 16:45:06 -0800 (PST)
Message-ID: <m3d4d3v195.fsf@localhost.localdomain>
References: <20090228002550.22597.53878.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Tim Visher <tim.visher@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 01:46:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdDLj-00086O-So
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 01:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbZB1ApN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 19:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754543AbZB1ApM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 19:45:12 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:39134 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbZB1ApK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 19:45:10 -0500
Received: by fxm24 with SMTP id 24so1294842fxm.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 16:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=DFjRMWdoy6Z97wU0oqrt7Ikl0H2HWBHdt29rV/83dF0=;
        b=PbGKKlWMQ+D+gupvHkrWd5qeNOdX+wUvk6xqBaJIxZMAXCbowAK23rr+MUEzAzmrTS
         1lmM2vtXaPq/GT3lG+/B7txhqD248vdCTxKyg7Xb61XMylU4prA6N5fEryfZx90hUXGv
         ERpZaeCnXgAC9rDzaye/Oh0YYKq7WEkLAb3tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Hdh6Vkc4SOAfC0Vf3t4lxxcyh6CT2+5/FTT+1zaTL51i1KDZKwE/ZAOLGDHfbLAeR6
         Fa6U1pJqFPnsLt7Nvm1gI0lcsheBsq2uHsBWtCoXNfrpYCAfVMf8UnBfjevEKxvbN4GM
         nEwmZ1/BhjJAzbKa52Ex2sceeXkkGxRoC7QKg=
Received: by 10.86.60.14 with SMTP id i14mr22323fga.69.1235781907600;
        Fri, 27 Feb 2009 16:45:07 -0800 (PST)
Received: from localhost.localdomain (abwe96.neoplus.adsl.tpnet.pl [83.8.228.96])
        by mx.google.com with ESMTPS id l19sm6155996fgb.37.2009.02.27.16.45.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Feb 2009 16:45:06 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1S0ichN022780;
	Sat, 28 Feb 2009 01:44:48 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1S0iMQp022775;
	Sat, 28 Feb 2009 01:44:22 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090228002550.22597.53878.stgit@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111729>

Gaah, this was meant to be reply to message by Peff
Message-ID: <20090226150013.GA9785@coredump.intra.peff.net>
in the "`./configure --XXdir=` ignored?" thread, but I mis-pasted
reply-to id.

Jakub Narebski <jnareb@gmail.com> writes:
> -- >8 --
> Now that we actually (can) install some info files, and that $infodir
> is set and used in Makefile(s), let add support for --infodir=DIR
> [PREFIX/info] ./configure option in config.mak.in.
> 
> Half of patch by Jeff King <peff@peff.net>m adding --XXdir support 

That was of course meant to be s/>m/>,/

Half of patch by Jeff King <peff@peff.net>, adding --XXdir support 

[...]
-- 
Jakub Narebski
Poland
ShadeHawk on #git
