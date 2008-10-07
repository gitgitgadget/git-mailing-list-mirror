From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH RFC] rebase--interactive: if preserving merges, use
	first-parent to limit what is shown.
Date: Tue, 7 Oct 2008 14:07:00 +0200
Message-ID: <20081007120700.GC7209@leksak.fem-net>
References: <48E8DD7E.9040706@redhat.com> <20081006102118.3e817a0f.stephen@exigencecorp.com> <20081006212021.04ba9214.stephen@exigencecorp.com> <48EB32A4.80809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Haberman <stephen@exigencecorp.com>, git@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 14:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnBMQ-0004XU-H0
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 14:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbYJGMHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 08:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbYJGMHH
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 08:07:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:54804 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752718AbYJGMHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 08:07:05 -0400
Received: (qmail invoked by alias); 07 Oct 2008 12:07:01 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp041) with SMTP; 07 Oct 2008 14:07:01 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+d0FdPyIWdBBBGj5ttSA5EHWPABSKzTxKVOXEo/Y
	7rVHntey5wgRwg
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KnBLA-0003vJ-8N; Tue, 07 Oct 2008 14:07:00 +0200
Content-Disposition: inline
In-Reply-To: <48EB32A4.80809@redhat.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97699>

Hi,

Avi Kivity wrote:
> If git rebase is to handle nonlinear history, it needs much more
> expressive commands; not only saying which commit to pick, but also what  
> the commit's parents shall be.

git-sequencer has a "merge" command for that. I'm really sorry that this has
not been sent to the list yet. Nevertheless I'm always glad to find testers
for sequencer, so if you like, fetch
	git://repo.or.cz/git/sbeyer.git seq-builtin-dev

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
