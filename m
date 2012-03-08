From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Thu, 08 Mar 2012 02:42:49 -0800 (PST)
Message-ID: <m3wr6vs7a2.fsf@localhost.localdomain>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 11:43:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5aoD-0004P1-5S
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 11:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab2CHKmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 05:42:53 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40392 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab2CHKmw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 05:42:52 -0500
Received: by eaaq12 with SMTP id q12so96500eaa.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 02:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ML/Tiets0oY/aZI2mY7cho8lAQ5yJXoUI4Rg75pqW8Q=;
        b=Y0VVQpOI+6LEuduxlmRG7EehIlh5XEarLletH+wa8DpUfUFEyNmqRkAmdHL9mpMiNd
         2VnpOCtK6kjHJxIYRLNhPgVtMpIDJywWsSJ7OwPr+3NDoRpsrWhYbc0F6LhPxs4ztyC5
         /UpQMOhhwLnWT7yhajKBLhw7uJjHopJpg8pxhMuDqZ6nk272/R38lqpJO7VP8TtzQoxc
         FCB0caTcjx/sX29LmtmnRh1WJWsDjteUVbk0IYlBtgIaCWE1uytIDkbDSZzNe9I2XlBy
         ZVbLuBU1is/6/chaAgTEI5BvL9gUtctqEkwXlxvZEqFH7RLYwR/9Q4FN1vt5pKFyMjxi
         aEDQ==
Received: by 10.213.7.10 with SMTP id b10mr1157444ebb.81.1331203370935;
        Thu, 08 Mar 2012 02:42:50 -0800 (PST)
Received: from localhost.localdomain (abwr173.neoplus.adsl.tpnet.pl. [83.8.241.173])
        by mx.google.com with ESMTPS id d54sm4801844eei.9.2012.03.08.02.42.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 02:42:49 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q28AgkHd008560;
	Thu, 8 Mar 2012 11:42:47 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q28AgjtQ008557;
	Thu, 8 Mar 2012 11:42:45 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192555>

Junio C Hamano <gitster@pobox.com> writes:

> Updates since v1.7.9
> --------------------
> 
> UI, Workflows & Features
[...]
>  * "gitweb" allows intermediate entries in the directory hierarchy
>    that leads to a projects to be clicked, which in turn shows the
>    list of projects inside that directory.
> 
>  * "gitweb" learned to read various pieces of information for the
>    repositories lazily, instead of reading everything that could be
>    needed (including the ones that are not necessary for a specific
>    task).
> 
>  * Project search in "gitweb" shows the substring that matched in the
>    project name and description highlighted.


[...]
> Fixes since v1.7.9
> ------------------
> 
> Unless otherwise noted, all the fixes since v1.7.9 in the maintenance
> releases are contained in this release (see release notes to them for
> details).
[...]

>  * "gitweb" used to drop warnings in the log file when "heads" view is
>    accessed in a repository whose HEAD does not point at a valid
>    branch.

It looks like fix for fixed-string project search is missing.

Nb. I don't know if it is worth mentioning, and if it should be in
"Fixes" or "Updates", but gitweb now supports utf-8 search, anc checks
regular expression for validity before using it in search.

-- 
Jakub Narebski
