From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: applying and committing patches in a single git command
Date: Tue, 15 Jul 2008 10:52:28 +0200
Message-ID: <20080715085228.GA6244@leksak.fem-net>
References: <ce513bcc0807150150l783e9ff1kd7780dc59f4b5a3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 10:53:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIgHr-0006j6-7Q
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 10:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbYGOIwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 04:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755456AbYGOIwb
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 04:52:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:48306 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755416AbYGOIwa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 04:52:30 -0400
Received: (qmail invoked by alias); 15 Jul 2008 08:52:28 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp058) with SMTP; 15 Jul 2008 10:52:28 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX193p8cJm5Z3t5ISLivoxoo+i0CcaZXZEufXxQ4462
	jo6LJIplCIe3r6
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KIgGq-0001dI-AM; Tue, 15 Jul 2008 10:52:28 +0200
Content-Disposition: inline
In-Reply-To: <ce513bcc0807150150l783e9ff1kd7780dc59f4b5a3d@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88541>

Hi,

Erez Zilber wrote:
> Hi,
> 
> Someone created a patch with git-format-patch and sent it to me. I
> would like to apply & commit the patch. If I use git-apply, it only
> patches my tree without committing it. Now, I need to copy the commit
> log, run git-commit and paste the commit log there. Is there a more
> intelligent way to do that?

git-am is exactly what you want.

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
