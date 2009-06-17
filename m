From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: git diff looping?
Date: Wed, 17 Jun 2009 15:08:29 +0200
Message-ID: <4A38EACD.3050602@gmail.com>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com> <20090616114726.GA4343@coredump.intra.peff.net> <7v3aa0dsvn.fsf@alter.siamese.dyndns.org> <20090616171531.GA17538@coredump.intra.peff.net> <4A38AD5D.6010404@gmail.com> <20090617102332.GA32353@coredump.intra.peff.net> <4A38D408.7000302@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	John Bito <jwbito@gmail.com>, git <git@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 15:09:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGutM-0004nT-QC
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 15:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761475AbZFQNI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 09:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761391AbZFQNI5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 09:08:57 -0400
Received: from main.gmane.org ([80.91.229.2]:44305 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762926AbZFQNI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 09:08:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MGuso-0002ex-NB
	for git@vger.kernel.org; Wed, 17 Jun 2009 13:08:54 +0000
Received: from nat-pool-brq.redhat.com ([62.40.79.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 13:08:54 +0000
Received: from paolo.bonzini by nat-pool-brq.redhat.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 13:08:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat-pool-brq.redhat.com
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <4A38D408.7000302@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121741>


> The glibc implementation is quite large. Cutting the library-specific
> cruft it still sits at about 10k LOC.
> 
> Using PCRE is a no-go, as it uses perl-compatible regexes even for the
> posix-compatible API, as per pcreposix(3):

I have a PCRE fork that has POSIX semantics (except the braindead 
leftmost-longest *sub*expressions).  It weighs 8kLOC, you can find it in 
branch ssed of GNU sed's git repository.

Paolo
