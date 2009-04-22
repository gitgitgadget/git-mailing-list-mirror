From: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
Subject: Re: What's going on here? Bad repo, no error locally?
Date: Tue, 21 Apr 2009 23:37:05 -0500
Message-ID: <gsm6tr$or7$1@ger.gmane.org>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE053E@EXCHANGE.trad.tradestation.com> <3e8340490904212121q4bf2e25dsf5673bff764895c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 06:39:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwUEp-0000s3-F5
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 06:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbZDVEh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 00:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbZDVEh3
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 00:37:29 -0400
Received: from main.gmane.org ([80.91.229.2]:36237 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbZDVEh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 00:37:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LwUD8-0001W9-RB
	for git@vger.kernel.org; Wed, 22 Apr 2009 04:37:26 +0000
Received: from 76-204-212-71.lightspeed.allntx.sbcglobal.net ([76.204.212.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 04:37:26 +0000
Received: from ngnr63q02 by 76-204-212-71.lightspeed.allntx.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 04:37:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 76-204-212-71.lightspeed.allntx.sbcglobal.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.5.666
In-Reply-To: <3e8340490904212121q4bf2e25dsf5673bff764895c9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117168>

Bryan Donlan wrote:
> Extract the object on developer B's workstation:
> git cat-file blob <object ID>  > blob.dat
> 
> Copy it to upstream, then do:
> git hash-object -w blob.dat
> 
> If all goes well, hash-object will give you back the blob's ID, and
> the repository will fsck cleanly again.

Thanks, I was looking through the manual for that but wasn't sure how to put it together.

But, what could be wrong with B's repo that makes this happen repetetly?  I assumed it was 
network SNAFU, but after restoring the upstream repo, his push did it again.

--John
