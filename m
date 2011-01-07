From: Yaroslav Halchenko <debian@onerussian.com>
Subject: Re: problem with cherry-picking a commit which comes before
 introducing a new submodule
Date: Fri, 7 Jan 2011 18:48:42 -0500
Message-ID: <20110107234841.GQ6040@onerussian.com>
References: <20110107172432.GA6040@onerussian.com>
 <20110107181501.GA28980@burratino>
 <20110107183226.GG6040@onerussian.com>
 <20110107230017.GA15495@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 00:48:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbM37-0007Tt-Pd
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 00:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab1AGXso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 18:48:44 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:43875 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab1AGXsn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 18:48:43 -0500
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PbM30-0006mU-8u; Fri, 07 Jan 2011 18:48:42 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PbM30-0006mR-26; Fri, 07 Jan 2011 18:48:42 -0500
Content-Disposition: inline
In-Reply-To: <20110107230017.GA15495@burratino>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org, jrnieder@gmail.com, newren@gmail.com
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164789>

sorry -- lame me... 1.7.2.3 ... I will check with current version as soon as
kids permit ;-)

% apt-cache policy git
git:
  Installed: 1:1.7.2.3-2.2
  Candidate: 1:1.7.2.3-2.2
  Version table:
 *** 1:1.7.2.3-2.2 0
        900 http://debian.lcs.mit.edu/debian/ squeeze/main amd64 Packages
        800 http://debian.lcs.mit.edu/debian/ sid/main amd64 Packages
        100 /var/lib/dpkg/status
% git --version
git version 1.7.2.3


On Fri, 07 Jan 2011, Jonathan Nieder wrote:
> One more piece of protocol: what git version are you using?  The
> release notes mention a fix in this area in v1.7.3[1]:

>  * "git merge -s recursive" (which is the default) did not handle cases
>    where a directory becomes a file (or vice versa) very well.

> Hopefully this is that.  In any case, sounds like a bug.

> (Hopefully someone else can comment on why cherry-pick uses the
> merge machinery to notice conflicts that would not be clear from
> the patch alone.)

> Thanks again.
> Jonathan

> [1] There is an updated Debian source package at [2].  Or, probably
> faster: one can use the build result in bin-wrappers/ from a git.git
> clone in place.
> [2] http://mentors.debian.net/debian/pool/main/g/git/git_1.7.4~rc1-0.1.dsc


-- 
=------------------------------------------------------------------=
Keep in touch                                     www.onerussian.com
Yaroslav Halchenko                 www.ohloh.net/accounts/yarikoptic
