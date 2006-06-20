From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Tue, 20 Jun 2006 21:56:34 +0200
Organization: At home
Message-ID: <e79jtd$51j$1@sea.gmane.org>
References: <e79921$u0e$1@sea.gmane.org> <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jun 20 21:57:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsmLR-0007Ek-Ur
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 21:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWFTT5B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 15:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWFTT5B
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 15:57:01 -0400
Received: from main.gmane.org ([80.91.229.2]:55729 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750842AbWFTT5A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 15:57:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FsmLA-0007BI-LW
	for git@vger.kernel.org; Tue, 20 Jun 2006 21:56:48 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 21:56:48 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 21:56:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22222>

Martin Langhoff wrote:

> On 6/21/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> 
>> * Add (of course optional, like blame support) snapshot support. There are
>>   at least two different implementations. I'd prefer to do without second
>>   CGI script, but perhaps this is better from the performance point of view.
>>   gitweb-xmms2 has snapshot.cgi in Python: should it be rewritten in Perl?
> 
> I intend to post a patch that adds snapshot support in Perl, in the
> main code. Just need to make it optional ;-)

Check http://marc.theaimsgroup.com/?l=git&m=111909432415478&w=2 for 
in the main code snapshot implementation.

http://www.liacs.nl/~sverdool/gitweb.cgi?p=gitweb.git;a=summary
http://www.liacs.nl/~sverdool/gitweb.git

Would separate snapshot CGI script make it work faster?

>> Any further ideas for other useful features?
> 
> Now what I think would rock too is something similar to gitk's "nearby
> tags" feature. When reading a commit, it lists the heads and tags that
> this commit is part of. It's very useful. Now I'll have to read up on
> how gitk does it.

If I remember correctly, it was done in the background, and it was done 
at least partially _in_ gitk (Tcl/Tk).
 
> And, as you mention in your other post, mod_perl support. And a bit of
> speed. Gitweb right now is really really slow.

Perhaps mod_cache would help. Especially if cache can be configured to 
look only at the hash part, plus formatting (normal, plain/raw, blame,
search match highlighting).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
