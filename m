From: "Chris.Cheney" <chris.cheney.nospam@tesco.net>
Subject: Re: git checkout branch puzzle
Date: Thu, 6 May 2010 20:30:11 +0000 (UTC)
Message-ID: <Xns9D70DAFB1423DChrisCheneytesconet@80.91.229.10>
References: <Xns9D6BC0C4C8784ChrisCheneytesconet@80.91.229.10> <20100502045901.GD14776@coredump.intra.peff.net> <Xns9D6C65C2DB06EChrisCheneytesconet@80.91.229.10> <Xns9D6CD773D97E5ChrisCheneytesconet@80.91.229.10> <20100503064053.GA20002@coredump.intra.peff.net> <Xns9D6D5CD466CE2ChrisCheneytesconet@80.91.229.10>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 06 22:31:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA7iq-0004gM-0y
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 22:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075Ab0EFUaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 16:30:24 -0400
Received: from lo.gmane.org ([80.91.229.12]:43909 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759019Ab0EFUaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 16:30:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OA7i8-0004Ir-OR
	for git@vger.kernel.org; Thu, 06 May 2010 22:30:20 +0200
Received: from 213.81.122.167 ([213.81.122.167])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 May 2010 22:30:20 +0200
Received: from chris.cheney.nospam by 213.81.122.167 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 May 2010 22:30:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 213.81.122.167
User-Agent: Xnews/5.04.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146494>

"Chris.Cheney" <chris.cheney.nospam@tesco.net> wrote in
news:Xns9D6D5CD466CE2ChrisCheneytesconet@80.91.229.10: 

> Jeff King <peff@peff.net> wrote in
> news:20100503064053.GA20002@coredump.intra.peff.net: 
> 
>> On Sun, May 02, 2010 at 08:09:32PM +0000, Chris.Cheney wrote:
>> 
>>> Neither of our config files contain autocrlf settings, but it's
>>> something that I'll look further into. Neither of us had made recent
>>> config changes. 
>> 
>> I believe autocrlf is on by default for msysgit. But if there is
>> nothing in your config, then probably nothing changed. If you can
>> reproduce the situation, it might be worth narrowing down a simple
>> test case and posting the exact commands and output.
> 
> Thanks. Indeed, after asking here, that was to be my next step - I
> need to restock up on round tuits :-)
> 
> FWIW My money is on a rm/git-rm or a mv/git-mv "user" error.

I would have lost my money.

You were almost spot-on. It turned out that my remote collaborator was 
using a version of msysgit prior to the default of autocrlf being true.

We'll be recloning from a freshly built repository r.s.n.

Thanks for your help

Chris
