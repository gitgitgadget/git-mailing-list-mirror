From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Add 'sane' mode to 'git reset'
Date: Mon, 01 Dec 2008 19:04:57 +0100
Organization: At home
Message-ID: <gh1907$vu5$1@ger.gmane.org>
References: <alpine.LFD.2.00.0812010908120.3256@nehalem.linux-foundation.org> <32541b130812010944k3dd825e4pfa8c270ecc75d539@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 19:06:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7DAD-0005lI-LX
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 19:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbYLASFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 13:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbYLASFL
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 13:05:11 -0500
Received: from main.gmane.org ([80.91.229.2]:43717 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbYLASFK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 13:05:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L7D8r-0007m1-EK
	for git@vger.kernel.org; Mon, 01 Dec 2008 18:05:05 +0000
Received: from abvo94.neoplus.adsl.tpnet.pl ([83.8.212.94])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 18:05:05 +0000
Received: from jnareb by abvo94.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 18:05:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvo94.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102073>

Avery Pennarun wrote:
> On Mon, Dec 1, 2008 at 12:30 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:

>> So add this kind of mode to "git reset", and since it's probably the
>> sanest form of reset (it will not throw any state away), just call it
>> that: "git reset --sane". It should probably be the default, but we likely
>> cannot change the semantics of a regular "git reset", even though it is
>> unlikely that very many people really use the current (insane) default
>> mode of "--mixed" that only resets the index.
[...]

> How about calling it --merge instead?  That's really what it does:
> merges the diffs from (your current index) to (the requested index)
> into (your working tree and your index).

I like it, because it is similar to how "git checkout --merge" works.
 
> Or --keep, because it keeps your working tree changes.

That is also better than --sane...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
