From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: First round of UGFWIINI results
Date: Fri, 06 Mar 2009 16:56:25 -0800 (PST)
Message-ID: <m3eixai1xv.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
	<m3myc2ucfb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 07 01:57:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfkrV-0002m4-5y
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 01:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbZCGA43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 19:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbZCGA43
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 19:56:29 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:6677 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbZCGA42 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 19:56:28 -0500
Received: by fg-out-1718.google.com with SMTP id 16so609078fgg.17
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 16:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=amICAxkNV0W7+wEsrll4pFWcN31Ov8/dKahvQjINuM4=;
        b=vLn8bdLdeXObvocsMcH9jDiWRPEm3xDikXfMukjAHDcZwhYuIbSNqP8J46XJ9BNCTX
         2QWXdFEN6A1IC/omWbbRHQ3t9itKiiONmMNIBseKevJywW0HwNLQwFY7edUMXNe1ygvi
         AES9JZTJsVLgeMf0fPbLL81ifm6VZUpipCFhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=GQcvFNq1z0f6xuB2vfBhb7JI6+6bPOrTprX3gjAmOgPKRRPKhEwjECbAj0vlWQXkqz
         3AdAlMT5nFkclqWvjMNei1td1YNJHm2fky4T43CnHnJl1R0V1NEa59Ys75pUOzylwpT3
         4vn6xdq+kSWFC+UZFePZgjMSC7RksKWtURHiU=
Received: by 10.86.82.16 with SMTP id f16mr2363469fgb.32.1236387385804;
        Fri, 06 Mar 2009 16:56:25 -0800 (PST)
Received: from localhost.localdomain (abvg205.neoplus.adsl.tpnet.pl [83.8.204.205])
        by mx.google.com with ESMTPS id e11sm430796fga.40.2009.03.06.16.56.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 16:56:25 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n270wMpG025009;
	Sat, 7 Mar 2009 01:58:22 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n270wLFv025006;
	Sat, 7 Mar 2009 01:58:21 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m3myc2ucfb.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112499>

Jakub Narebski <jnareb@gmail.com> writes:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Dear fans of Git,
> > 
> > a while ago I announced the UGFWIINI contest, a glorious battle of ideas
> > how to
> > 
> > 	Use Git For What It Is Not Indended
> > 
> > As most of you probably did not find my blog yet, this may come as a
> > surprise to you, but it will not be the only surprise in this email.
[...]
 
> Another candidate for UGFWIINI contest: Gitorial. Here is explanation

> And similar thing: Homoiconic. Here is explanation

And here is yet another UGFWINII candidate: Flashbake. 
Here is explanation:

  Flashbake is a set of Python scripts that check your hot files for
  changes every 15 minutes, and checks in any changed files to a local
  git repository.  Flashbake records any changes made since the last
  check, annotating them with the current timezone on the
  system-clock, the weather in that timezone as fetched from Google,
  and the last three headlines with your by-line under them in your
  blog's RSS feed (I've been characterizing this as "Where am I,
  what's it like there, and what am I thinking about?"). It also
  records your computer's uptime.

  It is intendend illuminate the creative process in a way that often
  reveals the hidden stories behind the books we care about.

References:
===========
[1] "Flashbake: Free version-control for writers using git"
    by Cory Doctorow describes insporation for Flashbake
    http://www.boingboing.net/2009/02/13/flashbake-free-versi.html
    http://craphound.com/?p=2171
[2] "Cory Doctorow on Lifestreaming Contextual Snapshots Using New
    Tool Flashbake" by Mark Krynsky
    http://lifestreamblog.com/cory-doctorow-on-lifestreaming-contextual-snapshots-using-new-tool-flashbake/
[3] Flashbake announcement on its author blog
    http://thecommandline.net/2009/02/13/flashbake/
[3] Flashbake home page
    http://bitbucketlabs.net/flashbake/

-- 
Jakub Narebski
Poland
ShadeHawk on #git
