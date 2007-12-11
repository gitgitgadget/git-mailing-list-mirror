From: Andreas Ericsson <ae@op5.se>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 08:34:30 +0100
Message-ID: <475E3D86.9030408@op5.se>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>	 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>	 <alpine.LFD.0.99999.0712102231570.555@xanadu.home>	 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>	 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com> <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	gcc@gcc.gnu.org, Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 08:35:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1zds-0004xc-Ij
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 08:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbXLKHef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 02:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXLKHef
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 02:34:35 -0500
Received: from mail.op5.se ([193.201.96.20]:34553 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbXLKHee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 02:34:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2DE9B1F0803A;
	Tue, 11 Dec 2007 08:34:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TPhLSj86fEpt; Tue, 11 Dec 2007 08:34:32 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id DDA561F08039;
	Tue, 11 Dec 2007 08:34:31 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67818>

Jon Smirl wrote:
> Switching to the Google perftools malloc
> http://goog-perftools.sourceforge.net/
> 
> Google allocator knocked 600MB off from memory use.
> Memory consumption did not fall during the write out phase like it did with gcc.
> 
> Since all of this is with the same code except for changing the
> threading split, those runs where memory consumption went to 4.5GB
> with the gcc allocator must have triggered an extreme problem with
> fragmentation.
> 
> Total CPU time 196 CPU minutes vs 190 for gcc. Google's claims of
> being faster are not true.
> 

Did you use the tcmalloc with heap checker/profiler, or tcmalloc_minimal?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
