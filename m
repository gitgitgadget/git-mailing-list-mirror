From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Problems getting rid of large files using git-filter-branch
Date: Wed, 7 Jan 2009 18:18:32 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngm9sfo.hl9.sitaramc@sitaramc.homelinux.net>
References: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
 <alpine.DEB.1.00.0901062319070.30769@pacific.mpi-cbg.de>
 <c09652430901061436w36c013ep938e9cfba43140c9@mail.gmail.com>
 <alpine.DEB.1.00.0901071101480.7496@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 19:20:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKd0g-0007oD-Ti
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 19:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbZAGSSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 13:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbZAGSSm
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 13:18:42 -0500
Received: from main.gmane.org ([80.91.229.2]:56127 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbZAGSSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 13:18:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LKczJ-0005Tl-8h
	for git@vger.kernel.org; Wed, 07 Jan 2009 18:18:41 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 18:18:41 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 18:18:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104816>

On 2009-01-07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> $ git verify-pack -v
>> .git/objects/pack/pack-1e039b82d8ae53ef5ec3614a3021466663cc70a4
>> Terminated
>
> I did
>
> 	$ git grep Terminated
>
> and came up empty :-)

It comes from libc, afaik.
