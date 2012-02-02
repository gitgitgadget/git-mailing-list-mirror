From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How best to handle multiple-authorship commits in GIT?
Date: Thu, 02 Feb 2012 11:57:18 -0800 (PST)
Message-ID: <m3bophc8je.fsf@localhost.localdomain>
References: <21056.1328185509@redhat.com>
	<9B990DDC-858D-43BA-BF9E-E0C3435354AF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Howells <dhowells@redhat.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Valerie Aurora <valerie.aurora@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 20:57:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2md-0001uQ-Un
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933529Ab2BBT5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:57:22 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44039 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933526Ab2BBT5V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:57:21 -0500
Received: by eekc14 with SMTP id c14so896721eek.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 11:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=PJDsDt/911+brf/L0hjbMgNrA3HfEXgBobkCinirIRk=;
        b=wS+SSi1tzvFgOWa8q4ArfQcAlle5BGgKZGzXLcwpKCS8aiECDl/x6xq0E378C9Gu73
         1xTtfHfmqCfUb3FKtb+UxKRcgRhw7sgUCUqzpPZun718XmFI8lD6FZy7Dxzy2QhKCCDB
         3bgDSqk0xR8FKygNitSmBDgAkKcTKMvH9iePY=
Received: by 10.14.185.144 with SMTP id u16mr1335232eem.112.1328212640568;
        Thu, 02 Feb 2012 11:57:20 -0800 (PST)
Received: from localhost.localdomain (abwd54.neoplus.adsl.tpnet.pl. [83.8.227.54])
        by mx.google.com with ESMTPS id t11sm12728342eea.10.2012.02.02.11.57.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 11:57:18 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q12JvwSp017295;
	Thu, 2 Feb 2012 20:57:59 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q12Jvvrj017292;
	Thu, 2 Feb 2012 20:57:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <9B990DDC-858D-43BA-BF9E-E0C3435354AF@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189686>

Valerie Aurora <valerie.aurora@gmail.com> writes:

> [...]  I had the same trouble with my set: while I entirely
> rewrote some patches, I still felt Jan Blunck deserved primary
> credit.  I don't recall my solution, but I'm fine with mentioning my
> name in the commit message (and I think Jan should get credit too).

That's what various *-by headers are for.  Signed-off-by is for
provenance.

Nb. you can search the whole commit message in gitweb, not only author
or committer.
 
> In general, this is a big problem for motivating contributors in
> other cases.  Some maintainers have a habit of trivially rewriting
> patches so that, technically, no line is the same, then taking
> authorship and giving the actual author an ambiguous Signed-off-by.

Maybe it was cause by tools accidentally stealing authorship?  With
"git commit --amend --author=..." it is now easy to add authorship
back.

> David hasn't done this here, of course - these are major rewrites -
> but when someone does all the hard work of finding and fixing a
> problem, the credit shouldn't go to the person who prettied it up.
> There is a line in the kernel doc saying how this should be handled,
> suggested by Rusty, but it's not being followed.

Link?
 
> First class support for multiple authorship would be a big way to
> motivate contributors.

Well, multi-line commit headers were only recently added to git (when
adding signed pull / singed commit stuff), but I think in many places
git assumes single authorship, and it would be hard to change...

There was some workaround that people doing pair programming invented,
IIRC...

-- 
Jakub Narebski
