From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to compare different files in different branches
Date: Fri, 06 Jun 2008 05:38:37 -0700 (PDT)
Message-ID: <m3od6eyc0s.fsf@localhost.localdomain>
References: <20080606122421.GA1521@denkbrett.schottelius.org>
	<m3skvqyc78.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-git-20080606@schottelius.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 14:39:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4bEG-00055r-Ej
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 14:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbYFFMil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 08:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbYFFMil
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 08:38:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:55416 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbYFFMik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 08:38:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so666218fgg.17
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Po2N5gK5+S+8grSWPKayZuK1CQpf1gzICFBOSkWtX2Y=;
        b=fT/XBRfsD3FM8P5BvFgeuH/WBNyiDNhHpNCurlgqWAV5gtuYZq8ygP/MP79kWBfAkW
         /a36iQEE7lSOTC+TT8QzaQR2Hs1iFaXA718jrcO/pLKu0wSfJw6ts4Lm6jkiwN40gywB
         g0CZ3H1qpddfwuduG3DcmnJTave7IezwixO5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=qPqCHODGbU5BXszDhS6vzjpHTU3H0/nO5ZkPeShr+Yel1eSzG3MsqGAlz+4VDPAa8d
         oHtfDfR1h0fgluFyDOL5ssQcoQLjZeYpRNX2BRgUeHd6kQn0DhEoFPdowgeqd3Q74J/F
         YOpfxAXLJCZUEUNuSZ2GsemCn2YyBO0u4BAC4=
Received: by 10.86.30.9 with SMTP id d9mr186812fgd.42.1212755919420;
        Fri, 06 Jun 2008 05:38:39 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.247.141])
        by mx.google.com with ESMTPS id d6sm5728252fga.2.2008.06.06.05.38.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 05:38:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m56CcAqk026327;
	Fri, 6 Jun 2008 14:38:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m56Cbtj4026323;
	Fri, 6 Jun 2008 14:37:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m3skvqyc78.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84061>

Jakub Narebski <jnareb@gmail.com> writes:

> Nico -telmich- Schottelius <nico-git-20080606@schottelius.org> writes:
> 
> > I want to compare 'configure.in' from the master branch with
> > 'configure.ac' from the gpm-2-dev branch.
> [...]
> > I really think git can do that, but currently I do not see the right
> > way. So any idea on how to do that?
> 
>  $ git diff master:configure.in gpm-2-dev:configure.ac

 $ git diff -M master gpm-2-dev -- configure.in configure.ac

should also work.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
