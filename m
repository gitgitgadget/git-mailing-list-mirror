From: "Pelle Svensson" <pelle2004@gmail.com>
Subject: git-pull can't be used without URL - Has worked before
Date: Fri, 16 Mar 2007 11:24:58 +0100
Message-ID: <6bb9c1030703160324u17d49b85s754ac8358f633bde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 11:25:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS9cR-0005Cx-Lr
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 11:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbXCPKZD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 06:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753452AbXCPKZD
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 06:25:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:63128 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbXCPKZB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 06:25:01 -0400
Received: by ug-out-1314.google.com with SMTP id 44so644197uga
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 03:24:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TBn7oKlHgD1UvvpzvAX4iVwIHvfXrP8ep+3i7wMShkV+9wDP8P0/FKBFcH7tIf2ticNZwCdcYOfPfIqhHwe4JzKjFzGNe8bLnM+4kPnqFNaK1qc++5mxf5JVKXoqzGHzZEKak83jsN2mUkdxo7UytxyKytCktfxy8U/sc+I/X5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Zzb8/YQNA39UVkUe8EKfoKo6vDbMgLE1Eici2RM66vTLwlviB74LZ6eiVl4igQwfJ3Z6at8NZbwo3v/XJk6u2MPjiRnQiyglnFqpHaoEVv1tSebSx+gdvCcN9zCzk4jT9nkQHOJ3S7AQ8Bveeew5rmSugdzzS8GKcr+wtdZCSkI=
Received: by 10.114.124.1 with SMTP id w1mr658510wac.1174040698846;
        Fri, 16 Mar 2007 03:24:58 -0700 (PDT)
Received: by 10.114.37.15 with HTTP; Fri, 16 Mar 2007 03:24:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42345>

Hi,

Did a setup of a new git-kernel, but this time git-pull can't be used without
full URL. What should I do.

Setup done this time
=================
[]$ git-clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
[]$ git-checkout -b my-brach v2.6.21-rc3;
...
[]$ git-pull
Warning: No merge candidate found because value of config option
              "branch.my-project.merge" dose not match any remote
branch fetched.

Tried with success
==============
[]$ git-pull git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Then again
=========
[]$ git-pull
Warning: No merge candidate found because value of config option
              "branch.my-project.merge" dose not match any remote
branch fetched.

I don't have .../.git/remotes directory in this setup??

/Pelle
