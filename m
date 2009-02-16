From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [RFC - draft] List of proposed future changes that are backward
 incompatible
Date: Mon, 16 Feb 2009 01:27:51 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngphg8n.hul.sitaramc@sitaramc.homelinux.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 02:30:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYsJO-0002By-Tf
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 02:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455AbZBPB2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 20:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753650AbZBPB2D
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 20:28:03 -0500
Received: from main.gmane.org ([80.91.229.2]:39532 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509AbZBPB2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 20:28:02 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LYsHB-0005XC-R0
	for git@vger.kernel.org; Mon, 16 Feb 2009 01:28:01 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 01:28:01 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 01:28:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110108>

On 2009-02-15, david@lang.hm <david@lang.hm> wrote:
> On Sun, 15 Feb 2009, Junio C Hamano wrote:
>> * git-push to update the checked out branch will be refused by default
>>
>>  Make "git push" into a repository to update the branch that is checked
>>  out fail by default.
>>
>>  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
>
> If I understand this one, it will cause grief for quite a few people.
>
> I have a public repository that I push to and then have a trigger that 
> checks out the current version, compiles it, publishes the compiled 
> version, sends an announcement, etc
>
> if I am understanding the purpose of this change, you would prohibit the 
> update from taking place.

I didn't read the *entire* thread but I do believe prohibit
is too strong.  It's only the default behaviour that is
being changed -- in your situation you'd just set
receive.denyCurrentBranch to either 'warn' (the current
default) or 'ignore'.
