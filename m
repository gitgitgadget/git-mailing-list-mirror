From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Tue, 1 Nov 2011 20:18:47 +0000 (UTC)
Message-ID: <loom.20111101T211624-511@post.gmane.org>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org> <4EAEAE13.50101@atlas-elektronik.com> <4EAFC18A.1070502@atlas-elektronik.com> <7vmxcfn23i.fsf@alter.siamese.dyndns.org> <loom.20111101T205618-231@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 21:20:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLKog-0003Yn-SK
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 21:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851Ab1KAUUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 16:20:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:55531 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699Ab1KAUUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 16:20:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RLKoX-0003VH-Gw
	for git@vger.kernel.org; Tue, 01 Nov 2011 21:20:05 +0100
Received: from dslc-082-083-197-091.pools.arcor-ip.net ([82.83.197.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 21:20:05 +0100
Received: from stefan.naewe by dslc-082-083-197-091.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 21:20:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.83.197.91 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.106 Safari/535.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184586>

Stefan Naewe <stefan.naewe <at> gmail.com> writes:

> Push with https works, if the URL looks e.g. like this:
> 
>   https://github.com/user/repo.git
> 
> rather than this
> 
>   https://user <at> github.com/user/repo.git
> 
> and having a ~/.netrc like this
> 
>   machine github.com login user password YouDontWantToKnow
> 
> If the URL contains 'user@' I get the 'need ENTER' behaviour.
> 

Another update:

If I revert deba493 the 'need ENTER' is gone and everything works as above.


Stefan
