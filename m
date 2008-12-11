From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 4/3] gitweb: Incremental blame (proof of concept)
Date: Thu, 11 Dec 2008 14:34:06 -0800 (PST)
Message-ID: <m3fxkugx5m.fsf@localhost.localdomain>
References: <20081209223703.28106.29198.stgit@localhost.localdomain>
	<20081210200908.16899.36727.stgit@localhost.localdomain>
	<m3r64ehba7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 23:35:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAu86-0006J9-Tw
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 23:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756950AbYLKWeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 17:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756918AbYLKWeK
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 17:34:10 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:42156 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756863AbYLKWeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 17:34:09 -0500
Received: by ewy10 with SMTP id 10so1503460ewy.13
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 14:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=9S/EgahEKIXjvISP5uFD+Rbe3eOleFotJF0xBj1Nczo=;
        b=oRvy7/o6652D9cdYc0Az5sjtrGlrt9FLhsOlVxIncTfWKjieh8SZHYl26ITFhx4VZc
         4dwU93RN9kVr//XdckA8G0UZ+rG9ib8DEvAMx9MBy4V+9PeOALul96F5pMjczNy9RdFu
         jj86NSqzeo8VBLjqS8Txb7UbL51QDgGBt+nnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=cF/eWes51F9ZQpNwnWKXfZxNIl853hCZprkBEmZO/1qFZQf0NRJxxMiRGwzKrGNB8O
         e0kTzuX/ySgWkEsK3kP5v+fwpFQEHNjIvja/kBI3veAoKxVsw9l7fAq1AKWEBufpmH7K
         hKtL38iENv2A9VpCkqTluungaJRTAxeukU/+0=
Received: by 10.210.136.10 with SMTP id j10mr3281020ebd.188.1229034847380;
        Thu, 11 Dec 2008 14:34:07 -0800 (PST)
Received: from localhost.localdomain (abvq79.neoplus.adsl.tpnet.pl [83.8.214.79])
        by mx.google.com with ESMTPS id 7sm5798237nfv.14.2008.12.11.14.34.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Dec 2008 14:34:06 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBBMXP11026738;
	Thu, 11 Dec 2008 23:33:41 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBBMX9SS026731;
	Thu, 11 Dec 2008 23:33:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m3r64ehba7.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102832>

Jakub Narebski <jnareb@gmail.com> writes:

> New features (in short):
>  * 3-coloring of lines with blame data during incremental blaming
>  * Adding author initials below shortened SHA-1 of a commit
>    (if there is place for it, i.e. if group has more than 1 row)
>  * progress indicator: progress info and progress bar
>  * information about how long it took to run 'blame_data',
>    and how long it took to run JavaScript script

 * handling server ('blame_data') errors, i.e. status != 200.
   (I needed that to debug blame.js when I entered URL incorrectly).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
