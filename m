From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Extra pair of double quotes in "git commit" output?
Date: Wed, 26 Nov 2008 06:49:06 +0900
Message-ID: <20081126064906.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 22:59:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L55vk-0005GD-Ub
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 22:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbYKYV5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 16:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbYKYV5e
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 16:57:34 -0500
Received: from karen.lavabit.com ([72.249.41.33]:46326 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240AbYKYV5e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 16:57:34 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id C7821C8428
	for <git@vger.kernel.org>; Tue, 25 Nov 2008 15:57:32 -0600 (CST)
Received: from 4283.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id W1INKHZV4J5V
	for <git@vger.kernel.org>; Tue, 25 Nov 2008 15:57:32 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=WFCdw4GHUDHDzEC3nrzEL9fkCSkvYGd1sO/BFnbIbXkuhf8yBb/EgVRehMBdRDT9dcaqF3Xel/g4QXRoBkmzQEfaiYJacefWc7dOz1ECNfxSJPD4gwrTVUNqWKroFQwkNUxHK/2r/ucaSTvXmu/PKsqO5uQm3Yf+en2Do1YR2+0=;
  h=From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101687>

While I think the way recent "git commit" displays the commit you just created is very helpful, I often find the double quotes around the message unnecessary and sometimes even confusing.  I just made a commit and saw this message:

    [master]: created d9a5491: "Show "standard deviation" column in table 3"

The colon after the shortened commit SHA1 is enough to signal that it will talk about a different piece of information on the rest of the line.  I think the extra double quotes can be dropped safely:

    [master]: created d9a5491: Show "standard deviation" column in table 3

and it will make the output shorter by two columns, more pretty, and does not lose the clarity.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
