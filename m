From: "=?ISO-8859-1?Q?Eirik_Bj=F8rsn=F8s?=" <eirbjo@gmail.com>
Subject: Re: Invalid dates in git log
Date: Wed, 12 Dec 2007 15:19:49 +0100
Message-ID: <34660cca0712120619r708ee7a8ta20a5458ca11a5ac@mail.gmail.com>
References: <34660cca0712120111k3f11769fk1a8cefda3b82683e@mail.gmail.com>
	 <20071212092304.GA20799@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 15:30:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2SbJ-0000LP-Mt
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 15:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXLLO3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 09:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbXLLO3v
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 09:29:51 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:17746 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbXLLO3u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 09:29:50 -0500
Received: by rv-out-0910.google.com with SMTP id k20so222968rvb.1
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 06:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XCRXBANLUdWxq6vznOJ+PpUxOBGoq+tWPbgOtNmqKac=;
        b=FvRC5bFG8dnnzqbqUsTdBJHep2joJhtSrrfzkJ1mXqIROv6DedQQRfspvgu147+SHCj500Dw9hlTNwnXp1teVmuaM/YZNaRdE8dmDBWEIGZnVlNwsJ55ITZ9Y2S2d0tz53DYl6przggzqZ5FL54BcJKm+TyxzPoV9hVrLe6FoMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k9qVKpYtS+j0ArSHDouG3MHtNbhJd/iWZl+W5T0Xo/fY9aGXvg+ecygDJ/lrjUtLTZNVfwMpIFT0CIFkBSn6CEeHe+5jdFpUWEH0SUeZ6hrKEg0AyM4gY9q5Gj2vqaN5Q/6eA1aB5zQhv+r6XFDLjVOgdxYS88EDDwkev8FV6ts=
Received: by 10.141.167.5 with SMTP id u5mr353662rvo.189.1197469189425;
        Wed, 12 Dec 2007 06:19:49 -0800 (PST)
Received: by 10.140.207.1 with HTTP; Wed, 12 Dec 2007 06:19:49 -0800 (PST)
In-Reply-To: <20071212092304.GA20799@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68038>

> Your best guess is probably the committer information. Try this:

Thanks Jeff, Junio,

I'll just use the committer date instead.

Being a Git newbie (only started looking at it yesterday) I'm not sure
my understanding of "author" and "committer" and how they releate to
dates is correct:

* author: Original source of the change. This person may typically
have sent a committer an email with a patch. It's the commiter's
responsibility to supply this information.
* author date: The commiter is free to specify a date for the contribution.

* committer: First committer to actually add this change to a repository
* committer date: Date of the actual commit, added by the git client
during the commit. Typically the system clock at the time of the
commit.

* A transfer of a commit across repositories (pull, push) will not
change the author, commit or date information

If I got some of this wrong, I'd be happy if someone would correct me.

Thanks,

Eirik.
