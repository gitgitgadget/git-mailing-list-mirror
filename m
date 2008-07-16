From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 00:09:46 +0200
Message-ID: <20080716220946.GC18558@leksak.fem-net>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 00:11:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJFDF-0002fy-8y
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 00:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758153AbYGPWJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 18:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758176AbYGPWJ5
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 18:09:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:56136 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757735AbYGPWJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 18:09:56 -0400
Received: (qmail invoked by alias); 16 Jul 2008 22:09:55 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp002) with SMTP; 17 Jul 2008 00:09:55 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19QkNV+bv9QyAmXDStrtqho840cRO2qX5WZq30gVe
	Zt4r+gs3f0RCrH
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJFBy-0002Yy-Rt; Thu, 17 Jul 2008 00:09:46 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807161804400.8950@racer>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88769>

Hi,

Johannes Schindelin wrote:
[...]
> 
> I had the pleasure of introducing Git to a few users in the last months 
> and in my opinion, restricting myself to teaching them these commands 
> first helped tremendously:
> 
> - clone, pull, status, add, commit, push, log
> 
> All of these were presented without options, to keep things simple.

Basically I agree, but depending on the user's foreign SCM knowledge
it could be useful to talk about some basic "low-level" concepts of git
(without talking about the plumbing).

I mean:
 - objects (commits, trees, blobs ... in very short)
 - index
and perhaps
 - refs (at least branches)

I was told that before I've seen a first git command and I still think
that was very useful.

Hmm, just recalling, my first git commands were:
 1. init
 2. add
 3. status
 4. commit
 5. diff
 6. log
 7. branch
 8. checkout
in this order, approximately. :)

(And I've used rebase before merge and I haven't used clone/pull/push for
a long time.)

It seems I haven't touched any plumbing before I've started with GSoC :)

I also think that for a user it is totally irrelevant if it is plumbing or
porcelain she is using, as long as it works. I mean, if I tought someone
using git, I'd never use the words "porcelain" or "plumbing".

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
