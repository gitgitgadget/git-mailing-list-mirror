From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: git push tags
Date: Mon, 29 Oct 2012 11:10:53 +0100
Message-ID: <20121029101053.GB8359@camk.edu.pl>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
 <508D7628.10509@kdbg.org>
 <CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
 <4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
 <CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com>
 <CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 11:11:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSmJR-0000BR-Ny
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 11:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757196Ab2J2KLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 06:11:05 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:44998 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab2J2KLE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 06:11:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 3F7D35F0049;
	Mon, 29 Oct 2012 11:11:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id in8smxuhIxA5; Mon, 29 Oct 2012 11:10:54 +0100 (CET)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id B97785F0047;
	Mon, 29 Oct 2012 11:10:54 +0100 (CET)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 05EE343CFD; Mon, 29 Oct 2012 11:10:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208610>

On Mon, Oct 29, 2012 at 09:12:52AM +0100, Angelo Borsotti wrote:
> Hi,

> to let the owner of a remote repository (one on which git-push
> deposits objects) disallow
> others to change tags, a key on its config file could be used.
> An option on git-push, or environment variable, or key in config file
> of the repo from which git-push takes objects do not help in enforcing
> the policy not to update tags in the remote repo.

It think these are two separate issues:

1. Enforcing policy that the server should not accept changes in
existing tags. This can be easily done with hooks.

2. Perform operation: push my tag if and only if it doesn't overwrite
tag which already exists on the server. I think currently it is not possible
with git.

-- 
  Kacper
