From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 15:14:49 +0100
Message-ID: <16cee31f0911040614p2d58c418m29e66ac825b12986@mail.gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
	 <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
	 <4AF175E8.7020400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 15:23:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5gdU-0004eQ-U3
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 15:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756469AbZKDOOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 09:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756462AbZKDOOp
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 09:14:45 -0500
Received: from gv-out-0910.google.com ([216.239.58.186]:22157 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756431AbZKDOOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 09:14:45 -0500
Received: by gv-out-0910.google.com with SMTP id r4so877263gve.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 06:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=bEBg6OgGLwtUsBz9+feVk4GGvxpGSN8XXmZwVFXIK08=;
        b=KxzaK2lyWZwv9xvJ4z0LAs79XQgV4ZbTHOIRNduMNgQJ2obF8elWs/SFB/z5YTMQBS
         79HYgzn3wcEFASw7K6aoUNVWAAMTpGGuX5sgZvycWk84xe2X72YUaxEIbpCoioG+q1qQ
         dj76vkeAU7Y7LAlvueMXgF8b23ZMmnx6W4Xtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=M6iGk3V7OGNu0uFENDdOEJtpJAE4ICaI4LXqTaDhFnUypKdDDDnqDHvCbaB5zU8gTs
         Sf/nWfn8aa8yWhKGhjfn32bWvNkNn59wwlW25p25J/m+w9+0Dbuu8i2FUcaEPKiTWs7M
         EpCEoYui33JGOM/QD3Eswg1HD0lDyLgn3BTO0=
Received: by 10.239.161.69 with SMTP id g5mr152801hbd.161.1257344089180; Wed, 
	04 Nov 2009 06:14:49 -0800 (PST)
In-Reply-To: <4AF175E8.7020400@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132086>

2009/11/4 Johannes Sixt <j.sixt@viscovery.net>:

>> +static __inline int pthread_cond_init(pthread_cond_t *cond, const void *unused)
>
> What's wrong with 'static inline int ...' (without the underscores)?
>

Forgot to answer. 'inline' is avaliable in C++ only (on MSVC at
least), while '__inline' is MS extension for C and C++.

--
Andrew
