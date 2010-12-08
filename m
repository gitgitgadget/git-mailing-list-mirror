From: Leonid Podolny <leonidp.lists@gmail.com>
Subject: Vendor branches workflow
Date: Wed, 8 Dec 2010 10:57:35 +0200
Message-ID: <AANLkTi=s9p3RycRCrocHEzfc4L-pnU6S9xCKfEL7TP=i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 09:57:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQFqU-0004gA-92
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 09:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab0LHI5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 03:57:45 -0500
Received: from mail-iw0-f172.google.com ([209.85.214.172]:63102 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab0LHI5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 03:57:44 -0500
Received: by iwn40 with SMTP id 40so1286729iwn.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 00:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=hvrSppsiofnW8gDJiC6U66rLVXHN7ehkAoywcbZYujo=;
        b=wcF0Xi8isJJDCma51sXf4ZmuqJX8LtgvL0qtuch2wx2B1brZfode4kuhepsZqAY5xx
         nifru6u9KLluYafAd0pcrkIUY+kVPYO/ggbQhZspNsict91cWbScv6XEdDEf/40tOdC2
         bnCXVZR3WyivgUeydux/pJHFShfVBxZhDsOE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=aujhsKD3GVQSM33bzo8j51+fS+ImISZUJvAeh4LuVc0kDVTu1YFnA1QItCdEBRvJIm
         aNxWxSnFWz8FtEBbH3fEXrGaOX5Z0ru0uFx+xvlHT0RdYMYTjFHFcrwit/3zHbcnZ5R/
         QKRt7k7VfmTVqeaxNhFrQ7ZV2ChVPx9pYeu+4=
Received: by 10.231.34.13 with SMTP id j13mr8956946ibd.56.1291798655789; Wed,
 08 Dec 2010 00:57:35 -0800 (PST)
Received: by 10.231.17.193 with HTTP; Wed, 8 Dec 2010 00:57:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163178>

Hi, list,
I would like an advice on organizing a vendor branch workflow, to
minimize the risk of it biting me in the future.
In our project, we have two upstreams, which are rather massively
patched. One of the upstreams is an SF svn repository, the other
arrives in form of tgz's with sources. Now git is tracking the patched
version, and I want to add a vendor branch to simplify future vendor
drops.
Out of the SVN upstream, we use only specific directories.
So, two questions:
- How do I deal with unneeded directories? Do I filter them out before
commiting to the vendor branch or while merging the vendor branch into
the master?
- Do you think it would be a good idea to keep .svn directories around
at the vendor branch? (Kind of connected to the first question,
because if I keep the .svn's, I will also have to keep the unneeded
dirs).
