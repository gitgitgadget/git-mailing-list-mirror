From: David =?utf-8?b?Um9kcsOtZ3Vleg==?= <deivid.rodriguez@gmail.com>
Subject: Re: PATH modifications for git-hook processes
Date: Wed, 22 Apr 2015 00:39:21 +0000 (UTC)
Message-ID: <loom.20150422T023408-102@post.gmane.org>
References: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com> <xmqqk2xe39zt.fsf@gitster.dls.corp.google.com> <CAKuTQSGapeUeZptdX1=Uv441Moo6X19RNR0oySU--F+Kj6Xz=w@mail.gmail.com> <20150416061732.GA5612@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 03:35:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkjZL-0002NF-9P
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 03:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417AbbDVBfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 21:35:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:34185 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798AbbDVBfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 21:35:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YkjZA-0002Hz-4Q
	for git@vger.kernel.org; Wed, 22 Apr 2015 03:35:05 +0200
Received: from 30.38.237.186.in-addr.arpa ([30.38.237.186.in-addr.arpa])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 03:35:04 +0200
Received: from deivid.rodriguez by 30.38.237.186.in-addr.arpa with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 03:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 186.237.38.30 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267576>

Jeff King <peff <at> peff.net> writes:
> 
> If we can get away with just dropping this element from the PATH, I'd
> much rather do that than try to implement a complicated path-precedence
> scheme.
> 
> -Peff
> 

I agree, GIT_EXEC_DIR should be enough and this surprising behavior would be
avoided.
