From: Alex Chiang <achiang@hp.com>
Subject: Re: [StGit PATCH v2 0/6] add support for git send-email
Date: Thu, 3 Dec 2009 12:27:31 -0700
Message-ID: <20091203192731.GD23258@ldl.fc.hp.com>
References: <20091202003503.7737.51579.stgit@bob.kio> <b8197bcb0912012246n3b83866cjb93654effc000242@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git <git@vger.kernel.org>
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 20:27:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGHL0-0004oE-2p
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 20:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756743AbZLCT10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 14:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756734AbZLCT10
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 14:27:26 -0500
Received: from g4t0017.houston.hp.com ([15.201.24.20]:17162 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756732AbZLCT1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 14:27:25 -0500
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id 3582238310;
	Thu,  3 Dec 2009 19:27:32 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g4t0009.houston.hp.com (Postfix) with ESMTP id DCE58C119;
	Thu,  3 Dec 2009 19:27:31 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id B9B28CF0017;
	Thu,  3 Dec 2009 12:27:31 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fWvooDezyWsr; Thu,  3 Dec 2009 12:27:31 -0700 (MST)
Received: by ldl (Postfix, from userid 17609)
	id A3547CF0007; Thu,  3 Dec 2009 12:27:31 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <b8197bcb0912012246n3b83866cjb93654effc000242@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134467>

* Karl Wiberg <kha@treskal.com>:
> On Wed, Dec 2, 2009 at 1:46 AM, Alex Chiang <achiang@hp.com> wrote:
> > The upshot is that in stg mail, --git and --mbox don't interact
> > well, and the resulting mbox file will lack the recipients. This
> > might be fixed in the future if we teach git send-email how to
> > generate mbox files, but then we introduce a versioning problem.
> 
> One wild idea: git send-email's --smtp-server flag will accept the
> (full) path of a sendmail program; writing such a program, just
> capable enough to receive the outgoing emails and dumping them to a
> file, should be easy. Another option would be a program that speaks
> just enough SMTP to accept the mails. (Incidentally, these two would
> be useful in testing stg mail even without the --git option.)
 
Hm, I think this is getting to be a bit of overkill. I could see
adding --mbox support to git send-email as being a better use of
time (IMO).

> I fully understand if you'd rather get on with scratching your actual
> itch, though ...
 
:)

> > So let's just accept this wart for now, and say, if you want an mbox
> > file generated, don't use --git. That seems reasonable to me.
> 
> Sure.

Thanks,
/ac
