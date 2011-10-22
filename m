From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2011, #08; Fri, 21)
Date: Sat, 22 Oct 2011 06:32:49 -0700 (PDT)
Message-ID: <m3mxct5f01.fsf@localhost.localdomain>
References: <7vzkgu6jrf.fsf@alter.siamese.dyndns.org>
	<m3r5256h76.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 22 15:32:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHbh3-0006X9-3q
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 15:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab1JVNcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 09:32:52 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33839 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab1JVNcw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 09:32:52 -0400
Received: by eye27 with SMTP id 27so4530917eye.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=gUWeofxtKB4+v34ZmLvna2bX7oyNgfObEIAgGfcDM7s=;
        b=myjzIF1zu04If5G9dnOid6OjqEh8mzzfUUHXRD9Dj1F/qDbFpLrU6szUuz2CHItJfb
         G4Z99iQxL6eUoPIYsJSZeNDaCzA2Cl9XNJ0J/4ng8qww9CdprlANwkZBz4to7eZUqDwk
         IRcBepzU34PObf7NFS21SJ493PGiu/+vJilvg=
Received: by 10.223.77.69 with SMTP id f5mr31533001fak.3.1319290370763;
        Sat, 22 Oct 2011 06:32:50 -0700 (PDT)
Received: from localhost.localdomain (abws220.neoplus.adsl.tpnet.pl. [83.8.242.220])
        by mx.google.com with ESMTPS id a8sm19288080faa.11.2011.10.22.06.32.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Oct 2011 06:32:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9MDWFFT012046;
	Sat, 22 Oct 2011 15:32:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9MDVxn9012042;
	Sat, 22 Oct 2011 15:31:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m3r5256h76.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184100>

Jakub Narebski <jnareb@gmail.com> writes:
> Junio C Hamano <gitster@pobox.com> writes:

> > * kk/gitweb-side-by-side-diff (2011-10-17) 2 commits
> >  - gitweb: add a feature to show side-by-side diff
> >  - gitweb: change format_diff_line() to remove leading SP from $diff_class
> > 
> > Fun.
> > Will keep in 'pu' until the planned re-roll comes.
> 
> I think this needs some more work, not only re-roll...
> 
> 
> BTW. the bottom commit could be I think replaced by mine
> 
>    - gitweb: Refactor diff body line classification

Nb. that needs a easy but non-trivial merge conflict resolution,
see e.g.

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
The following changes since commit 8963314c77af9a4eda5dcbdbab3d4001af83ad81:

  Sync with maint (2011-10-21 11:24:34 -0700)

are available in the git repository at:

  git://repo.or.cz/git/jnareb-git.git gitweb/side-by-side-diff

Jakub Narebski (1):
      gitweb: Refactor diff body line classification

Kato Kazuyoshi (1):
      gitweb: add a feature to show side-by-side diff

 gitweb/gitweb.perl       |  144 ++++++++++++++++++++++++++++++++++------------
 gitweb/static/gitweb.css |   15 +++++
 2 files changed, 123 insertions(+), 36 deletions(-)

-- 
Jakub Narebski
