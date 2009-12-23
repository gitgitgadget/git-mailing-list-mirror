From: Sam Vilain <sam@vilain.net>
Subject: Re: Regression: git-svn clone failure
Date: Wed, 23 Dec 2009 13:09:14 +1300
Message-ID: <4B315FAA.2090708@vilain.net>
References: <8BD646EB-3F47-41F8-918C-19133CCCA89C@apple.com> <20091222192115.GA10313@dcvr.yhbt.net> <B82A784D-C8D7-4DDF-AE63-390C7AE1CC2D@apple.com> <1261516416.23944.44.camel@denix> <7vbphqzo2y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Andrew Myrick <amyrick@apple.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 01:09:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNEnD-0002vK-Qm
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 01:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbZLWAJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 19:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbZLWAJS
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 19:09:18 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:44005 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbZLWAJR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 19:09:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 7063E31D4E;
	Wed, 23 Dec 2009 13:09:15 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZZ4FdIinPQzR; Wed, 23 Dec 2009 13:09:14 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id D874731C7A;
	Wed, 23 Dec 2009 13:09:14 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <7vbphqzo2y.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135609>

Junio C Hamano wrote:
> Sam Vilain <sam@vilain.net> writes:
>   
>> With git, merge parent relationships imply (conceptually, anyway) that all of the changes reachable from that branch are included in the commit.  If someone is doing cherry-picking, then they are specifically excluding some commits, so adding a merge parent to that branch isn't right.
>> ...
>> Subject: [PATCH] git-svn: consider 90% of a branch cherry picked to be a merge
>>
>> Be slightly fuzzy when deciding if a branch is a merge or a cherry pick; ... might ... if ...
>>
>> Signed-off-by: Sam Vilain <sam@vilain.net>
>>     
>
> If I were _using_ git-svn (or any other tool), I would rather be forced to ... sort out the conflict myself ... rather than an automated but unreliable operation that drops changes randomly, ... and reports "everything is peachy".
>
> That sounds horrible, as you cannot trust your merges anymore.  I hope I
> am mis-interpreting what you wrote above.
>   

Welcome to the world of SVN, Junio. It's a world of sunshine and
happiness, pain and despair.

Sam.
