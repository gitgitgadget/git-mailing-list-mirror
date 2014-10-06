From: David Lang <david@lang.hm>
Subject: Re: Can I fetch an arbitrary commit by sha1?
Date: Mon, 6 Oct 2014 11:28:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1410061127080.26324@nftneq.ynat.uz>
References: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com> <CAPBPrnsA4KxNximtKXcC37kuwBHK0Esytdm4nsgLHkrJSg3Ufw@mail.gmail.com> <20141002161006.GB2505@peff.net> <CACh33FpWPuyJRryf6hzbAkqWJMwzz1mLLDDRxEQ0niT2CznTRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, Dan Johnson <computerdruid@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Git <git@vger.kernel.org>
To: Patrick Donnelly <batrick@batbytes.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 20:37:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbDAU-0003jo-Pv
	for gcvg-git-2@plane.gmane.org; Mon, 06 Oct 2014 20:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbaJFShy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2014 14:37:54 -0400
Received: from mail.lang.hm ([64.81.33.126]:47206 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbaJFShx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2014 14:37:53 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Oct 2014 14:37:53 EDT
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s96ISff7009060;
	Mon, 6 Oct 2014 11:28:41 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CACh33FpWPuyJRryf6hzbAkqWJMwzz1mLLDDRxEQ0niT2CznTRg@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257913>

On Mon, 6 Oct 2014, Patrick Donnelly wrote:

> There are efforts in the scientific communities at preserving
> experimental software and results. One of the things we'd like to do
> is shallow clone a specific sha1 commit from e.g. GitHub. [I think
> GitHub has this disabled though? I haven't been able to get it to
> work.] I guess this feature was a step in the right direction but it's
> not usable AFAIK. Tags are not really suitable as they could change
> and there are possible namespace issues.

remember that git != github and it's not hard to run your own git server.

if you sign tags, they should be very stable. You do have the namespace issue, 
but unless you have a lot of different people tagging in the same repository, 
that shouldn't be an issue (and if you do, can't you use the person's name as 
part of the tag?)

David Lang
