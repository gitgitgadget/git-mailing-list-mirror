From: david@lang.hm
Subject: Re: how to make a commit only contain existing files
Date: Tue, 7 Dec 2010 16:52:48 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1012071652160.662@asgard.lang.hm>
References: <alpine.DEB.2.00.1012071203190.662@asgard.lang.hm> <20101207211126.GA29453@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 08 01:53:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ8Hj-0000Qn-8h
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 01:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637Ab0LHAww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 19:52:52 -0500
Received: from mail.lang.hm ([64.81.33.126]:53702 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304Ab0LHAwv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 19:52:51 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id oB80qmvn016714;
	Tue, 7 Dec 2010 16:52:48 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20101207211126.GA29453@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163157>

On Tue, 7 Dec 2010, Jeff King wrote:

> On Tue, Dec 07, 2010 at 01:00:18PM -0800, david@lang.hm wrote:
>
>> I know that I can do a git rm to explictly remove files, but is there
>> an easy way to just say that this commit should contain all the files
>> that exist at this point in time, without carrying over any files
>> that were in a prior commit but that don't exist now?
>
> Won't "git add -A; git commit" do what you want?

it very well may, I'll have to upgrade git on that box to a version that 
supports it.

Thanks.

David Lang
