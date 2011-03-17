From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Gitweb: Source configuration from file separate from the CGI script
Date: Thu, 17 Mar 2011 16:41:26 +0100
Message-ID: <201103171641.29021.jnareb@gmail.com>
References: <1300285582.28805.25.camel@drew-northup.unet.maine.edu> <m3lj0e59ps.fsf@localhost.localdomain> <1300361067.3010.1.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Mar 17 16:42:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0FL1-0004CQ-Ix
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 16:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393Ab1CQPmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 11:42:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55788 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab1CQPmF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 11:42:05 -0400
Received: by fxm17 with SMTP id 17so2820013fxm.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=A4Z9tphpYUHY0N21sXUyMXp6px9OY0k9/NXdTzTj4Ek=;
        b=gZwQ/T6DIFuB98GIr8jb/8/RmH41hw3UFze5kphHf5qY5mdNEtFAPMtm9KjGhZOo+w
         4TSVQM8ZoKEEWTf5f4ocZtD/Lxvb4cbLxIYV9ibDSM/NSQBWAxUnkdSTM53E7GImE10c
         WqjIbXFMIWzd6BVUl1wrzYWZQLgsvPOwZ1HNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dtmAGv7hjBKKIPiF6V3EtLGm1BPDM1AI5ajXdPwDysJDvF1k1ZMYIzUhCw1Z/lZL2Z
         223PCRZ52TW4tFbazgliPvtirlWGgoc3p0g9WqOfgbRA4nY07YWrANDOhCPxGTB1UgS3
         V5xDqmBAHb5UFY7fYNZAMHIX1MBhdM+aozLJo=
Received: by 10.223.1.76 with SMTP id 12mr1631082fae.118.1300376501586;
        Thu, 17 Mar 2011 08:41:41 -0700 (PDT)
Received: from [192.168.1.13] (aeho51.neoplus.adsl.tpnet.pl [79.186.196.51])
        by mx.google.com with ESMTPS id e17sm74902fak.24.2011.03.17.08.41.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 08:41:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1300361067.3010.1.camel@drew-northup.unet.maine.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169247>

Drew Northup wrote:

> I'm obviously a moron because I didn't to bother to scroll through the
> whole thing first. I'm just not going to fight with you.
> I'm going to crawl back under my rock now.

I came to strong; I am very, very sorry about that.  We are really
interested how we can make existence and use of gitweb config file
more obvious.

The "Build time configuration" section in gitweb/INSTALL is 
unfortunately after the one-page fold, so that's probably why
you didn't notice that.  It was probably pushed out by changes
in previous section.

What were your changes to gitweb.cgi script, i.e. where in gitweb
sources we should add notification about build time and runtime
gitweb configuration?

-- 
Jakub Narebski
Poland
