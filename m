From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 5/6] run test suite without dashed git-commands in PATH
Date: Tue, 01 Dec 2009 09:24:46 -0800 (PST)
Message-ID: <m3fx7un7vb.fsf@localhost.localdomain>
References: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
	<1259561971-25730-2-git-send-email-mmogilvi_git@miniinfo.net>
	<1259561971-25730-3-git-send-email-mmogilvi_git@miniinfo.net>
	<1259561971-25730-4-git-send-email-mmogilvi_git@miniinfo.net>
	<1259561971-25730-5-git-send-email-mmogilvi_git@miniinfo.net>
	<1259561971-25730-6-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 18:24:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFWT7-0000rZ-PE
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 18:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbZLARYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 12:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbZLARYm
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 12:24:42 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:52924 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbZLARYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 12:24:41 -0500
Received: by bwz27 with SMTP id 27so3659203bwz.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 09:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Hv5aFQ2tsxjt/dCKATCCD4qQ0Zplgms8pGchPurRWFo=;
        b=AVpayuaVRAzuVn6nc4KtGJ7PEeCGLzhx96WLPxjTtjkhHSMTUJAiRF7FTghZr8XB7z
         ST5vluhtqAbZcS4bsce4SOzTUPgkXJNV2UsRVZKfHJfe2JtX5ro3C+ukS2i0S2hlMNEX
         1py5msPI1nQ/WHiEEAk0RKCawEIeIKICw4rDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Gcfrejk5l4RmFPnUDwX73bqf0rgxU7o2jZT0r4T09R+Ewt9B3lMssdyl+ZjKZBbFl1
         MDGqnxD/1NgWTKvff2QDC0kvpb6E+mcOTj94CDER0SP68JcdXkOqlPnI2ms1gK8NRoJl
         uJp8HZP3+Yrkfu4XVY7eRMTt4y/o2QRt3clMs=
Received: by 10.204.34.3 with SMTP id j3mr6377258bkd.23.1259688286906;
        Tue, 01 Dec 2009 09:24:46 -0800 (PST)
Received: from localhost.localdomain (abwm69.neoplus.adsl.tpnet.pl [83.8.236.69])
        by mx.google.com with ESMTPS id 13sm129271fxm.9.2009.12.01.09.24.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 09:24:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nB1DQRwP022975;
	Tue, 1 Dec 2009 14:26:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nB1DQ0jE022970;
	Tue, 1 Dec 2009 14:26:00 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1259561971-25730-6-git-send-email-mmogilvi_git@miniinfo.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134234>

Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:

> diff --git a/t/README b/t/README
> index 4e1d7dd..8c5d892 100644
> --- a/t/README
> +++ b/t/README
> @@ -75,6 +75,14 @@ appropriately before running "make".
>  	As the names depend on the tests' file names, it is safe to
>  	run the tests with this option in parallel.
>  
> +--with-dashes::
> +	By default tests are run without dashed forms of
> +	commands (like git-commit) in the PATH (it only uses
> +	wrappers from TOP/git-bin).  Use this option to include TOP
> +	in the PATH, which conains all the dashed forms of commands.
> +	This option is currently implied by other options like --valgrind
> +	and GIT_TEST_INSTALLED.
> +

Shouldn't it be 'TOP/bin-wrappers' and not 'TOP/git-bin'?  
Shouldn't TOP be explained somewhere, or is it obvious in the context?

s/conains/contains/.

> +else # normal case, use ../bin-wrappers only unless $with_dashes:

-- 
Jakub Narebski
Poland
ShadeHawk on #git
