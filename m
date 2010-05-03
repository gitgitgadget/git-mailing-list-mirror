From: "Chris.Cheney" <chris.cheney.nospam@tesco.net>
Subject: Re: git checkout branch puzzle
Date: Mon, 3 May 2010 08:06:15 +0000 (UTC)
Message-ID: <Xns9D6D5CD466CE2ChrisCheneytesconet@80.91.229.10>
References: <Xns9D6BC0C4C8784ChrisCheneytesconet@80.91.229.10> <20100502045901.GD14776@coredump.intra.peff.net> <Xns9D6C65C2DB06EChrisCheneytesconet@80.91.229.10> <Xns9D6CD773D97E5ChrisCheneytesconet@80.91.229.10> <20100503064053.GA20002@coredump.intra.peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 03 10:06:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8qfi-00075t-5C
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 10:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376Ab0ECIGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 04:06:30 -0400
Received: from lo.gmane.org ([80.91.229.12]:45063 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932241Ab0ECIG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 04:06:27 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O8qfZ-000721-BU
	for git@vger.kernel.org; Mon, 03 May 2010 10:06:25 +0200
Received: from 81.100.117.68 ([81.100.117.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 May 2010 10:06:25 +0200
Received: from chris.cheney.nospam by 81.100.117.68 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 May 2010 10:06:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 81.100.117.68
User-Agent: Xnews/5.04.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146222>

Jeff King <peff@peff.net> wrote in
news:20100503064053.GA20002@coredump.intra.peff.net: 

> On Sun, May 02, 2010 at 08:09:32PM +0000, Chris.Cheney wrote:
> 
>> Neither of our config files contain autocrlf settings, but it's
>> something that I'll look further into. Neither of us had made recent
>> config changes. 
> 
> I believe autocrlf is on by default for msysgit. But if there is
> nothing in your config, then probably nothing changed. If you can
> reproduce the situation, it might be worth narrowing down a simple
> test case and posting the exact commands and output.

Thanks. Indeed, after asking here, that was to be my next step - I need to 
restock up on round tuits :-)

FWIW My money is on a rm/git-rm or a mv/git-mv "user" error.

Chris
