From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make Pthread link flags configurable
Date: Mon, 03 Nov 2008 01:44:54 -0800 (PST)
Message-ID: <m3hc6pf8k6.fsf@localhost.localdomain>
References: <1225669400-79505-1-git-send-email-david.syzdek@acsalaska.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David M. Syzdek" <david.syzdek@acsalaska.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 10:46:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kww0j-00067M-4y
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 10:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbYKCJo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 04:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754640AbYKCJo6
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 04:44:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:41490 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbYKCJo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 04:44:58 -0500
Received: by nf-out-0910.google.com with SMTP id d3so917229nfc.21
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 01:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=laxnk3438Plx/dVWVLVJVRYizjQf89jy6jQEp32UQ8Y=;
        b=o2AnoTofbWwQdnrW+tl6VFf3fseMAe5IhBIEno2R/UqtVXf0OJdMJYU00wGkR9gAuK
         cvBDfElts2BVkx5QmN4NQHpELCIADa/daU9gB+0jYrnYBFgBKdvloYuVhNChvvBB1Nto
         oowuTeOFXSSUCN3T1Jsvfi0iRzPZ+heKLNxvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=qzcJkdl26UvKjheerPdVGykwfQ/poO5E5I1Bi8w4H0vLnwZPGQGKwXKgzu6BNJEb6v
         CuYMe5vC/nQluuVkL3OZEShRUkU7eL/f/jZPFfpGlUTRzzXjphqTToBxyQh2FEfBVL+7
         WVUr/Ilwx/xIvlUbx5VEFY6VTczEMYqyrPvMI=
Received: by 10.210.125.7 with SMTP id x7mr16959249ebc.90.1225705496022;
        Mon, 03 Nov 2008 01:44:56 -0800 (PST)
Received: from localhost.localdomain (abvp247.neoplus.adsl.tpnet.pl [83.8.213.247])
        by mx.google.com with ESMTPS id 23sm9200245eya.7.2008.11.03.01.44.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 01:44:54 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mA39iLSn017172;
	Mon, 3 Nov 2008 10:44:31 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mA39i9Ur017168;
	Mon, 3 Nov 2008 10:44:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1225669400-79505-1-git-send-email-david.syzdek@acsalaska.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99922>

david.syzdek@acsalaska.net writes:

> From: David M. Syzdek <david.syzdek@acsalaska.net>
> 
> FreeBSD 4.x systems use the linker flags `-pthread' instead of the
> linker flags `-lpthread' when linking against the pthread library.
> 
> Signed-off-by: David M. Syzdek <david.syzdek@acsalaska.net>
> ---
>  Makefile |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Would it be possible to add support for this also to configure.ac
(and config.mak.in)?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
