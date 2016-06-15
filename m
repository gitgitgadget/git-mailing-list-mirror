From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH 2/3] Use File::Find rather than find and xargs in  git-archimport
Date: 10 Feb 2006 15:47:49 -0800
Message-ID: <86k6c2ojx6.fsf@blue.stonehenge.com>
References: <1103.1139614557@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 00:48:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7hza-00019f-Mg
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 00:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWBJXr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 18:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWBJXr4
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 18:47:56 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:26416 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751398AbWBJXrz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 18:47:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 9F1BC8F69C;
	Fri, 10 Feb 2006 15:47:50 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 17838-03-21; Fri, 10 Feb 2006 15:47:50 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 2C1708F744; Fri, 10 Feb 2006 15:47:50 -0800 (PST)
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
x-mayan-date: Long count = 12.19.13.0.14; tzolkin = 7 Ix; haab = 12 Pax
In-Reply-To: <1103.1139614557@lotus.CS.Berkeley.EDU>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15906>

>>>>> "Jason" == Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

Jason> +	if (-f && !-z && /^.*\.patch$/ && !/{arch}/) {

If that works, it's only accidentally.  Perhaps you wanted !/\{arch\}/ because
curlies are special to regex.  Dunno, because I don't know what you're
excluding.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
