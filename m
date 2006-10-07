From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Sat, 07 Oct 2006 23:27:08 +0200
Organization: At home
Message-ID: <eg961o$2v7$2@sea.gmane.org>
References: <20061007141043.16912.73982.stgit@rover> <20061007184418.64881.qmail@web31812.mail.mud.yahoo.com> <eg8tpu$drj$1@sea.gmane.org> <20061007191246.GF20017@pasky.or.cz> <eg9378$rln$1@sea.gmane.org> <20061007211531.GH20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Oct 07 23:27:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWJhP-0007Uf-Jl
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 23:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWJGV0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 17:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932867AbWJGV0j
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 17:26:39 -0400
Received: from main.gmane.org ([80.91.229.2]:52971 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932618AbWJGV0i (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 17:26:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWJgf-0007ML-Js
	for git@vger.kernel.org; Sat, 07 Oct 2006 23:26:25 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 23:26:25 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 23:26:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28509>

Petr Baudis wrote:

> Dear diary, on Sat, Oct 07, 2006 at 10:38:51PM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> Petr Baudis wrote:
>> 
>> > So, I'd like to either have the view links or the filenames in classical
>> > link style so that it's apparent they are clickable; I didn't post a
>> > patch since I didn't have time/energy to fight for it yet. ;-)
>> 
>> There is a tradeout. Either have easily distinguishable directories and
>> files, by using both different color and decoration (underline), or we have
>> filename/directory name clearly marked as link. One or the other.
>> 
>> That is why I'd rather have this "redundant" blob/tree link (perhaps in
>> separate column).
> 
> As I suggested in another mail, perhaps the whole problem is wrong and
> you shouldn't have to dug for trees in a bunch of blobs in the first
> place - let's group all the trees at the top, as all the well-behaved
> directory listings do.

It is a good idea, although we would wither to have to read the directory
(tree) listing first into some array, then sort it directories first
(contrary to current output while reading, which reduces latency provided
that browser can properly display partial contents), or add some option
to git-ls-tree command to output tree entries (directories) first, instead
of sorting by filename.

>> But this is a matter of policy, unless we want to add theme support to
>> gitweb ;-))
> 
> We _do_ have that - you can supply your own gitweb.css. But the defaults
> should be sensible.

Theme support, as to be able to choose theme, like style selectable from
web browser, and for example choosing if the tree/blob links are present
or not. Some of which might be done via CSS (display:none).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
