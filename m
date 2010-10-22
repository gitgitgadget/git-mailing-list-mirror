From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] add support for the SUA layer (interix; windows)
Date: Fri, 22 Oct 2010 10:01:15 -0700 (PDT)
Message-ID: <m362wukvs5.fsf@localhost.localdomain>
References: <1287741401-17941-1-git-send-email-mduft@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Duft <mduft@gentoo.org>
To: mduft@s01en22.salomon.at
X-From: git-owner@vger.kernel.org Fri Oct 22 19:01:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Kzz-00083W-7m
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 19:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757986Ab0JVRBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 13:01:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44421 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab0JVRBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 13:01:19 -0400
Received: by wyf28 with SMTP id 28so1062325wyf.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=fh/6MaT2mqQnpIkSW25OOkegftzMnoizy5xSs9tuXLk=;
        b=phRjQSlfLULXGITQR5NHd0dQtQZ/5AGS9kqMTFtk00h3ttD0mGBgdnf0y8jkBbZ7s+
         HqXjRl/2yKcuhsmcwiLwLO0YXoLMxwTjZHOyNBHkzQg36G6tF2Mmz+AXFhjOrpvAOLwH
         tHIO0TryhVlV/DPWxDD/R7TtMTatKaxBCjL4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=N2xILbLp6Iml0JojxrLOk5VX9TiLL0mzgXy/pO8RJLejcpXlpla5wycrIg5xUSTvww
         CBTYUxkfFnwYZeiTsARTPVqezlmoSm/qYnpkZ5Y8EbYTvecq4KThWtEhI6lFjMh/qLI4
         LM0WgMhy28qo3Prrh345YZHRpbigPteukj6DM=
Received: by 10.227.128.202 with SMTP id l10mr3018919wbs.178.1287766876996;
        Fri, 22 Oct 2010 10:01:16 -0700 (PDT)
Received: from localhost.localdomain (abwn200.neoplus.adsl.tpnet.pl [83.8.237.200])
        by mx.google.com with ESMTPS id h29sm2670207wbc.21.2010.10.22.10.01.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 10:01:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9MH0Zb1003915;
	Fri, 22 Oct 2010 19:00:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9MH0BTq003907;
	Fri, 22 Oct 2010 19:00:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1287741401-17941-1-git-send-email-mduft@gentoo.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159711>

mduft@s01en22.salomon.at writes:

> * add required build options to Makefile.
> * introduce new NO_INTTYPES_H for systems lacking inttypes; code
>   includes stdint.h instead, if this is set.
> * introduce new NO_SYS_POLL_H for systems lacking sys/poll.h; code
>   includes poll.h instead, if this is set.
> * introduce NO_INITGROUPS. initgroups() call is simply omitted.
> 
> Signed-off-by: Markus Duft <mduft@gentoo.org>
> ---
>  Makefile          |   28 ++++++++++++++++++++++++++++
>  daemon.c          |    6 +++++-
>  git-compat-util.h |    8 ++++++++
>  3 files changed, 41 insertions(+), 1 deletions(-)

Could you also add appropriate detection to configure.ac?
Thanks in advance.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
