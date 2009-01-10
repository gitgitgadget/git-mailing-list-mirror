From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: support the rel=vcs microformat
Date: Fri, 09 Jan 2009 16:03:20 -0800 (PST)
Message-ID: <m3fxjs10zb.fsf@localhost.localdomain>
References: <20090107042518.GB24735@gnu.kitenet.net>
	<gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net>
	<cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com>
	<20090107184515.GB31795@gnu.kitenet.net>
	<20090107190238.GA3909@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jan 10 01:04:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLRLM-0000rF-7n
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 01:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbZAJADY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 19:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbZAJADY
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 19:03:24 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:4003 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbZAJADX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 19:03:23 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1162182eye.37
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 16:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=VRkUBqA08Ywgu0j4eL9IBR170iUrp1m3l+Kou+nnTqw=;
        b=enq84AkfYpG9kcnTqwKYOLfKpB5pS321rp/IURN3rSebLbRmO2PSjQLtNVY07g0eSf
         UKKpxV3FkSMkkMqObpTcX9RK7guIj4692QrfEyrRQ1FC1PQTQVKaXCVbmeEUoPn6IxHx
         77xOrmnTLOPYx7CByC0TNmYntzxH1Ac4onfHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Jpn0lNRSXiOFCLPIFniu0AGb5wcJeulydqAs+axHdybkVJuHODI6C76YnWnzDzwXRI
         CiwoBVTLFfqnb1an1rrsuCAwDONGa8lZo0i5nRtd/CCUP95P/h2SHcUICqT8+9aMtzze
         icW4GKDJzHQ34mdfFtfFGNpIj8wdT1YTPhkEk=
Received: by 10.210.57.5 with SMTP id f5mr5404050eba.14.1231545801056;
        Fri, 09 Jan 2009 16:03:21 -0800 (PST)
Received: from localhost.localdomain (abwp34.neoplus.adsl.tpnet.pl [83.8.239.34])
        by mx.google.com with ESMTPS id 10sm2070856eyz.49.2009.01.09.16.03.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 16:03:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0A03L7g028279;
	Sat, 10 Jan 2009 01:03:21 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0A03KZr028276;
	Sat, 10 Jan 2009 01:03:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090107190238.GA3909@gnu.kitenet.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105049>

Joey Hess <joey@kitenet.net> writes:
> Joey Hess wrote:

> > Another approach would be to just memoize git_get_project_description
> > and git_get_project_url_list.
> 
> Especially since git_get_project_description is already called more than
> once for some pages.

Hmmm... this is an idea worth checking.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
