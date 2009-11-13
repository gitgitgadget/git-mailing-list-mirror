From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Update 'git remote' usage and man page to match.
Date: Sat, 14 Nov 2009 07:19:48 +0900
Message-ID: <20091114071948.6117@nanako3.lavabit.com>
References: <32c343770911121715l7507b2d5j8c6cf8cccd1f1a61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 23:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N94VK-0004io-O6
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 23:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570AbZKMWUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 17:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756448AbZKMWUR
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 17:20:17 -0500
Received: from karen.lavabit.com ([72.249.41.33]:55649 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755430AbZKMWUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 17:20:16 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id BF3DD11B788;
	Fri, 13 Nov 2009 16:20:22 -0600 (CST)
Received: from 1172.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 6068ZPC1D8U9; Fri, 13 Nov 2009 16:20:22 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Yr5ncQz/cZqAmap2cvXLCifJRPqjzZfsnoJNdNWmSOd+fFbiuq3aBD/obGpemoOX4tpSoP2ZZjt7t1rBTUhL0APcNKhnStwQni5KBi3EXM2iMlT5yQBfuWjjHRlgOCDtvhzp90wN81ziaPY6T1v+zCSq4irloxNu/PaPgdXVfu8=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <32c343770911121715l7507b2d5j8c6cf8cccd1f1a61@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132846>

Quoting Tim Henigan <tim.henigan@gmail.com> writes:

> This commit:
>
> 1) Removes documentation of '--verbose' from the synopsis portion
> of the usage string since it is a general option.
>
> 2) Removes the 'remote' option from 'git remote update' in the
> man page.  This option had already been removed from the usage
> string in the code, but the man page was not updated to match.
>
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---

The second change is good but why do you remove -v from the 
synopsis section? Why is it a good idea? Manual pages for 
many other commands list --verbose in their synopsis section.
