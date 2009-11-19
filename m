From: Marcus Better <marcus@better.se>
Subject: Re: git-svn not fetching all revisions
Date: Thu, 19 Nov 2009 13:07:27 +0100
Message-ID: <4B0534FF.5040001@better.se>
References: <4AF9AC1A.5000100@better.se> <4AFA36F0.6070501@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Nov 19 13:09:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB5nU-0007N3-U6
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 13:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbZKSMHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 07:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbZKSMHZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 07:07:25 -0500
Received: from vips.better.se ([79.99.3.21]:50125 "EHLO vips.better.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbZKSMHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 07:07:24 -0500
Received: from [192.168.1.20] (unknown [80.169.182.16])
	by vips.better.se (Postfix) with ESMTPSA id 5F00620EC0D4;
	Thu, 19 Nov 2009 13:07:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=better.se; s=mail;
	t=1258632449; bh=ls4BqO4Fhk5/+ISqi9YG9D3YnqK3Mjs+z/e9GcSZt0U=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=NIjCmvjIh78G2/uhnxfSMCmG9Lltb1wjTeICjsB9k6fdfEC8jd+kZxZrHDviWBZrF
	 emORFdBqTCzLN6v2/o1Q6c0QaPYrWKHzGwFOs8dXgf4JzGvuJFDzC8FHY/omDT5L4h
	 uIsYAvK2Ndvao7Ln4Q/2aCZe8z2nRbc85cuD7U6U=
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20091109)
In-Reply-To: <4AFA36F0.6070501@vilain.net>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133226>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sam Vilain wrote:
> Marcus Better wrote:
>> The problem is that the trunk was replaced by a branch at some point.

> Yeah.  Try doing it in parts - fetch the two stages of the history
> explicitly using the revision range arguments to 'git svn fetch' - and
> then graft the histories together and fix up with git filter-branch.

Ok, that works, but how can I now sync with the svn repository with git
svn rebase/dcommit? I think the filter-branch rewriting confuses git-svn.

Cheers,

Marcus
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAksFNPsACgkQXjXn6TzcAQkr+QCgxQ1r68v2O1Ux7YFoS5IQS1GT
/cgAoLoTgRcIK7vMTJWfmN2XAhcy0eOa
=dnet
-----END PGP SIGNATURE-----
