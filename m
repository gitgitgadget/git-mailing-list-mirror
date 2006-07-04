From: Elrond <elrond@samba-tng.org>
Subject: Re: git-cvsimport gets parents wrong for branches
Date: Tue, 4 Jul 2006 12:46:31 +0200
Message-ID: <20060704104631.GB24572@memak.tu-darmstadt.de>
References: <20060703215303.GA24572@memak.tu-darmstadt.de> <46a038f90607031615m2cafbf05q5922fb04eae72362@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 12:46:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxiQP-0006Z4-Go
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 12:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWGDKqe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 06:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWGDKqe
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 06:46:34 -0400
Received: from baerbel.mug.maschinenbau.tu-darmstadt.de ([130.83.48.97]:63694
	"EHLO baerbel.mug.maschinenbau.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S932203AbWGDKqe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 06:46:34 -0400
Received: from baerbel.mug.maschinenbau.tu-darmstadt.de (localhost [127.0.0.1])
	by baerbel.mug.maschinenbau.tu-darmstadt.de (8.13.4/8.13.4) with ESMTP id k64AkVIP010840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Jul 2006 12:46:32 +0200
Received: (from tacke@localhost)
	by baerbel.mug.maschinenbau.tu-darmstadt.de (8.13.4/8.13.4/Submit) id k64AkVPu010838;
	Tue, 4 Jul 2006 12:46:31 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Mail-Followup-To: Elrond <elrond@samba-tng.org>,
	Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90607031615m2cafbf05q5922fb04eae72362@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: ClamAV 0.88.2/1582/Mon Jul  3 23:23:18 2006 on baerbel.mug.maschinenbau.tu-darmstadt.de
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23279>

On Tue, Jul 04, 2006 at 11:15:47AM +1200, Martin Langhoff wrote:
> Elrond,
> 
> you are right, the current git-cvsimport takes a very naive approach
> to determine where branches open from. It uses cvsps internally, which
> only reports on the ancestor branch, so we take the latest commit from
> the ancestor.

If there is no fix visible, it probably should be
documented, that git-cvsimport isn't the perfect solution,
so people aren't surprised.


> Parsecvs probably has a more sophisticated approach, have you tried it?

After finding the current correct git:-url [1] for it, I
noticed, that I need libgit for it (I use git from my
distribution), so I've postponed this.
Of course, you can use my script and try parsecvs yourself.


> If the cvs2svn documentation is not lying, it probably has the
> smartest/correctest implementation. For small-medium repos, you may be
> able to run cvs2svn and then import with git-svnimport.

I'll try that soon.


    Elrond

[1] git://anongit.freedesktop.org/git/users/keithp/parsecvs
