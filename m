From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2012, #08; Tue, 31)
Date: Wed, 01 Feb 2012 04:07:14 -0800 (PST)
Message-ID: <m3fweudaf6.fsf@localhost.localdomain>
References: <7vlion3tr5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Bernhard R. Link" <brl+git@mail.brlink.eu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 13:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsYyC-0002ce-La
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 13:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498Ab2BAMHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 07:07:18 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65136 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab2BAMHR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 07:07:17 -0500
Received: by eekc14 with SMTP id c14so303976eek.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 04:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=jq1uy0UbSx3xZ+qX8wKYtxnF24Xs4/Z6g0rwPjZoxLE=;
        b=IRx6s76C271dlJUELnh/sAMJrn/9P7ogLJ0jDu1rIcw6W07BJZbK0jJgzVxy6Eu4+Y
         KMgSfG7pkUbIYJaT/RihGabysBg6raNG7n0WuspDodCGM1nzwvLhc0kuU0m7WpQsNC1g
         s3WfAX0MV4sDFoxfcPS8xERGspzP/PTtWGkEo=
Received: by 10.14.122.208 with SMTP id t56mr2278945eeh.31.1328098035643;
        Wed, 01 Feb 2012 04:07:15 -0800 (PST)
Received: from localhost.localdomain (abvm46.neoplus.adsl.tpnet.pl. [83.8.210.46])
        by mx.google.com with ESMTPS id n17sm98380209eei.3.2012.02.01.04.07.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 04:07:14 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q11C7lIB020402;
	Wed, 1 Feb 2012 13:07:53 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q11C7PjH020395;
	Wed, 1 Feb 2012 13:07:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vlion3tr5.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189507>

Junio C Hamano <gitster@pobox.com> writes:

> --------------------------------------------------
> [Cooking]
> 
> * bl/gitweb-project-filter (2012-01-31) 8 commits
>  - gitweb: Make project search respect project_filter
>  - gitweb: improve usability of projects search form
>  - gitweb: place links to parent directories in page header
>  - gitweb: show active project_filter in project_list page header
>  - gitweb: limit links to alternate forms of project_list to active project_filter
>  - gitweb: add project_filter to limit project list to a subdirectory
>  - gitweb: prepare git_get_projects_list for use outside 'forks'.
>  - gitweb: move hard coded .git suffix out of git_get_projects_list
> 
> Seems to break test 9502.

Hmmm... strange.  I have applied my patches on top of earlier version
of project_filter commits:

   - gitweb: Make project search respect project_filter
   - gitweb: Improve projects search form
   - gitweb: place links to parent directories in page header
   - gitweb: add project_filter to limit project list to a subdirectory

and all gitweb tests passes.

I will investigate.

-- 
Jakub Narebski
