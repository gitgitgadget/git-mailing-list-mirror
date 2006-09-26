From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Tue, 26 Sep 2006 13:52:59 +0200
Organization: At home
Message-ID: <efb4an$lg9$1@sea.gmane.org>
References: <200609212356.31806.jnareb@gmail.com> <200609231034.49545.jnareb@gmail.com> <20060923121134.GM13132@pasky.or.cz> <200609231533.02455.jnareb@gmail.com> <20060923140535.GK8259@pasky.or.cz> <ef95rk$o4q$1@sea.gmane.org> <20060925201500.GG20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 26 13:54:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSBVu-0006AB-Mh
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 13:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWIZLyL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 07:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWIZLyL
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 07:54:11 -0400
Received: from main.gmane.org ([80.91.229.2]:8935 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750770AbWIZLyK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 07:54:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GSBUx-0005tW-A1
	for git@vger.kernel.org; Tue, 26 Sep 2006 13:53:15 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 13:53:15 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 13:53:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27790>

Petr Baudis wrote:

> Dear diary, on Mon, Sep 25, 2006 at 08:06:44PM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> So when putting message if into commit message, just put the commit
>> message in separate line, perhaps even with some indentation, like
>> below:
>>   Msg-Id: <200609231533.02455.jnareb@gmail.com>
> 
> Oh please. :-) The tool should bend, not the user.

Still it is more (much more) readable to have Msg-Id "header" (or
equivalent), and message id itself in one line.

> Are you going to mandate that for bug references as well? Or should I
> proofread all of my commits (if they aren't actually just autoformatted
> by fmt without my further review) to verify that they don't actually end
> up wrapped, and manually reformat the whole paragraph?

O.K. that convinces me (although wrapped hyperlink is not a pretty thing).
Besides for tags we have natural multiline "tag", namely PGP signature,
which we wpuld (most probably) want to syntax highlight wrapping it in
<div class="GPG_signature">...</div> element.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
