From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitosis-lite
Date: Mon, 24 Aug 2009 06:13:53 -0700 (PDT)
Message-ID: <m3ab1pmk1c.fsf@localhost.localdomain>
References: <2e24e5b90908240528v56fdf30cq4c046fca321a3b17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Tommi Virtanen <tv@eagain.net>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 15:14:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfZN7-0008Jv-Gv
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 15:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbZHXNNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 09:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752438AbZHXNNz
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 09:13:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:6880 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbZHXNNy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 09:13:54 -0400
Received: by fg-out-1718.google.com with SMTP id e21so492542fga.17
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=mWV7AXh62MfXclAcMDZwGEsrGrQJ72uS/fHxUNbDIy4=;
        b=wWmmJ+89Tqc9P7cA01caPB7Yg7VlFomyJVvwXK3v1f/RLHN0wJeR0aKKSybpoFRlBq
         i7sCFnjV61ialti7rieySy3Aa/mPiOhGCOgGhUbjnKLmCATtsNgpnhI+JDIUXNYGNEFz
         d2MnnEFSI/0B01XsiOIBRKJ3/VlueYdgR1pHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=rcgncZ6YQcg6b2lx+3bYiZl17Z5qFSNMUKh+HrvvaAhYCsw948Wt8RXVLNuIdaGkXm
         YdoI4U6GfbXZDTm7kFDQMBRqGZvMETgNwEiw6xXyYH5E8O/QS1rcORcqfoNm8HwwN+PY
         1GKxwzmgXG5N/mYtQZnxjJ8//tIGG5dIeNJUI=
Received: by 10.86.18.34 with SMTP id 34mr3309616fgr.2.1251119634300;
        Mon, 24 Aug 2009 06:13:54 -0700 (PDT)
Received: from localhost.localdomain (abwd173.neoplus.adsl.tpnet.pl [83.8.227.173])
        by mx.google.com with ESMTPS id 4sm2758041fge.22.2009.08.24.06.13.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 06:13:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7ODDqmj020107;
	Mon, 24 Aug 2009 15:13:53 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7ODDpVi020103;
	Mon, 24 Aug 2009 15:13:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2e24e5b90908240528v56fdf30cq4c046fca321a3b17@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126922>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Hello all,
> 
> I created a new project called gitosis-lite, which combines
> the essential pieces of gitosis with the per-branch
> permissions stuff in the example in the howto directory of
> git.git.
> 
> The config file is different, (there's an annotated example
> you can look at).
> 
> The "why" and the "what" are all at
> http://github.com/sitaramc/gitosis-lite

Could you add information about this tool (perhaps after confirmation
/ deciding on project name[1]) to Git Wiki page
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
somewhere below Gitosis?  Please do not forget to include that it is
written in Perl; see other entries for example.


You wrote in project's README.markdown that you were inspired by
Gitosis (which requires Python and python-setuptools) and
Documentation/howto/update-hook-example.txt (which uses bash).
Why not contrib/hooks/update-paranoid (which is written in Perl)?

Using Perl code for configuration is simple and fast, but not very
secure.  Why not use git config format (via "git config -l -z" like in
gitweb), or YAML or JSON (or Storable)?  Well, YAML might be overkill.

BTW. if you blog about gitosis-lite (http://sitaramc.blogspot.com/)
it could be picked up by Perl Iron Man Blogging challenge, and you
could get wider review.

[1]: gitosis-lite doesn't look like CPAN-y name.  Git::Admin perlhaps?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
