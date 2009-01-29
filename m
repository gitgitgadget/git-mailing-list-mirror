From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 11:40:42 +0000
Message-ID: <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129035138.GC11836@coredump.intra.peff.net> <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com> <20090129113735.GA6505@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 12:42:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSVHp-0004KS-5k
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 12:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbZA2Lk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 06:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbZA2Lk4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 06:40:56 -0500
Received: from frim.nl ([87.230.85.232]:50864 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524AbZA2Lkz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jan 2009 06:40:55 -0500
Received: from 82-41-227-224.cable.ubr11.sgyl.blueyonder.co.uk ([82.41.227.224] helo=[192.168.50.101])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1LSVGL-0002xv-Do; Thu, 29 Jan 2009 12:40:49 +0100
In-Reply-To: <20090129113735.GA6505@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107659>


On 29 jan 2009, at 11:37, Jeff King wrote:

>  git push origin master ;# note we have to explicitly mention the  
> branch
>
>  ... time passes ...
>
>  git pull
>
> produces the "you haven't asked me which branch to merge" message.
>
> Which does make some sense, given how tracking configuration is set  
> up.
> It's just that it's a little sad that cloning an empty repository and
> then later getting commits out of it (whether commits you put in or
> somebody else) does not behave the same as cloning a repository with
> commits.

This is true in all cases. If you create a new branch in any repository,
push that, and later do a 'git pull', you get that message. I agree it's
not the nicest way to handle things, but this is not an issue with the  
clone,
it's an issue of pushing new branches in general.
