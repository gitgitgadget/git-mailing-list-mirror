From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2012, #10; Wed, 28)
Date: Thu, 29 Mar 2012 16:51:01 -0700 (PDT)
Message-ID: <m3fwcrarwo.fsf@localhost.localdomain>
References: <7vsjgss6ua.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 01:51:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDP7V-0005ZV-Hx
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 01:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933191Ab2C2XvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 19:51:05 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:39867 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511Ab2C2XvC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 19:51:02 -0400
Received: by wejx9 with SMTP id x9so42320wej.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=FVB8F5TmM/iLcMgQ5kTKqeOM4vLB4Xa909wYMDnAv2Y=;
        b=ZLZXi5irkMHq6+w7zqQN1WFQfOvaW4PMtW6EC6muj/eoUZmJ7ICWX0rQD7J1VruyPi
         J9jnNf8hcAYl2FygKYVZRPoF/OKvKk3WYpsMNxPoZEOIkg5ryuXYMZLLANY1wd8ZNDcE
         6Lnpi5FIxFeENpYH9iMfCDvn6tBtSkUnSafS+rCfQ+14smDAeFvIVc7GBTcdeIp5TEHg
         jyiOWUjkkgO8k/lEzy9AlLPML7VC0NuSlGbdjBEseq9/uaIZuUmB2n+UJ2GIS3uxrVLm
         UXdkV+lJvvHJXSEy17LRE3BHK+KG/DVvy25iItrRIEQ3TlRopc+MO9Tc+jpEMcYjQF2+
         gG5Q==
Received: by 10.180.82.132 with SMTP id i4mr194441wiy.12.1333065061439;
        Thu, 29 Mar 2012 16:51:01 -0700 (PDT)
Received: from localhost.localdomain (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id n15sm1317899wiw.6.2012.03.29.16.51.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 16:51:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2TNoWXV012234;
	Fri, 30 Mar 2012 01:50:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2TNoGcS012230;
	Fri, 30 Mar 2012 01:50:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vsjgss6ua.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194305>

Junio C Hamano <gitster@pobox.com> writes:

> --------------------------------------------------
> [Cooking]

> * wk/gitweb-snapshot-use-if-modified-since (2012-03-26) 3 commits
>  - gitweb: add If-Modified-Since handling to git_snapshot().
>  - gitweb: refactor If-Modified-Since handling
>  - gitweb: add `status` headers to git_feed() responses.
>=20
> Makes 'snapshot' request to "gitweb" honor If-Modified-Since: header,
> based on the commit date.

What about "[PATCH v2 0/8] gitweb: Highlight interesting parts of diff"
series by Micha=B3 Kiedrowicz:

  Message-ID: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmai=
l.com>
  http://thread.gmane.org/gmane.comp.version-control.git/193804

I have copy of them in 'gitweb/diff-hl' branch:

-- >8 --
The following changes since commit 455cf268dbaf227bdbd5e9fbf96525452bcf=
e44f:

  Git 1.7.10-rc3 (2012-03-28 11:18:42 -0700)

are available in the git repository at:

  git://repo.or.cz/git/jnareb-git.git gitweb/diff-hl

for you to fetch changes up to 60b06478f0349729dc9a4ddeb1abf5e28986fb7e=
:

  gitweb: Refinement highlightning in combined diffs (2012-03-29 21:26:=
36 +0200)

----------------------------------------------------------------
Micha=B3 Kiedrowicz (8):
      gitweb: esc_html_hl_regions(): Don't create empty <span> elements
      gitweb: Pass esc_html_hl_regions() options to esc_html()
      gitweb: Extract print_sidebyside_diff_lines()
      gitweb: Use print_diff_chunk() for both side-by-side and inline d=
iffs
      gitweb: Move HTML-formatting diff line back to process_diff_line(=
)
      gitweb: Push formatting diff lines to print_diff_chunk()
      gitweb: Highlight interesting parts of diff
      gitweb: Refinement highlightning in combined diffs

 gitweb/gitweb.perl       |  299 +++++++++++++++++++++++++++++++++-----=
--------
 gitweb/static/gitweb.css |    8 ++
 2 files changed, 225 insertions(+), 82 deletions(-)

--=20
Jakub Narebski
