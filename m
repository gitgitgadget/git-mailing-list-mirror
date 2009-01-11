From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2009, #02; Sun, 11)
Date: Sun, 11 Jan 2009 06:33:33 -0800 (PST)
Message-ID: <m3ljthzzdq.fsf@localhost.localdomain>
References: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 15:35:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM1P2-0004sr-0g
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 15:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbZAKOdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 09:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbZAKOdh
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 09:33:37 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:49045 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbZAKOdh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 09:33:37 -0500
Received: by ewy10 with SMTP id 10so11072524ewy.13
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 06:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=l57eYfVKGS2dMEQyTv3+M0Rct2Oap3M6uYuqPm4tU2Q=;
        b=BkqSZiUKtT1QJ0nelF7VadBDLh8q0cbthQExTK4ZsbSL+n9mOiYha9AXscprZz/GeS
         1Vvea5MX1WRDU81if2F/pAWchna7vx0uREEi5UTlLM1T/MdQjVkGYrS2Ykm0fF1arNY3
         fSk0JzekjqPI96iK7TExUVS73f0TNs29D4488=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=qA+e9vE/ODgCPfJ+R5obWeqIEPRBvx2rwcigvfJiO973ROuQJBDTMFkU3D7PCuejm3
         5HDQQ5uDU4sE11mIB4OMbrfO7CiDkfBouB3MB8jTRWNk0EYlYXNG9OGlPgXbqkZWlcey
         z1pqQo/ptwMr6+AJTDJE3RvG52nWHa3GLnrkM=
Received: by 10.210.137.17 with SMTP id k17mr445320ebd.138.1231684414811;
        Sun, 11 Jan 2009 06:33:34 -0800 (PST)
Received: from localhost.localdomain (abwj90.neoplus.adsl.tpnet.pl [83.8.233.90])
        by mx.google.com with ESMTPS id 7sm1230315eyg.42.2009.01.11.06.33.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jan 2009 06:33:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0BEXAqG008822;
	Sun, 11 Jan 2009 15:33:11 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0BEX656008819;
	Sun, 11 Jan 2009 15:33:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105183>

Junio C Hamano <gitster@pobox.com> writes:

> ----------------------------------------------------------------
> [Actively cooking]
>
> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
>  - gitweb: Optional grouping of projects by category
>  - gitweb: Split git_project_list_body in two functions
>  - gitweb: Modularized git_get_project_description to be more generic

This I think needs some further cooking.  I guess with addition of one
more patch to series categories could be sorted together with projects
they contain, and not always have to be in fixed ordering.
 
> * gb/gitweb-patch (Thu Dec 18 08:13:19 2008 +0100) 4 commits
>  - gitweb: link to patch(es) view in commit(diff) and (short)log view
>  - gitweb: add patches view
>  - gitweb: change call pattern for git_commitdiff
>  - gitweb: add patch view

If I remember correctly the only point of discussion is calling
convention for git_commitdiff, and whether 'patches' view should
(re)use git_commitdiff or use its own subroutine.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
