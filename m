From: Robin Rosenberg <robin.rosenberg@gmail.com>
Subject: Re: [msysGit] Re: Weird filename encoding issue
Date: Sat, 18 Oct 2008 11:35:52 +0200
Message-ID: <200810181135.52270.robin.rosenberg@gmail.com>
References: <c6c947f60810170059s3859d906r9935b5e80d8a41c6@mail.gmail.com> <48F852FC.2070506@viscovery.net> <c6c947f60810172322o12beeb80xfd39b551b0db7c99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org
To: msysgit@googlegroups.com, agladysh@gmail.com
X-From: git-owner@vger.kernel.org Sat Oct 18 11:37:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr8F9-0004gS-Lw
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 11:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbYJRJf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Oct 2008 05:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbYJRJfz
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 05:35:55 -0400
Received: from av12-2-sn2.hy.skanova.net ([81.228.8.186]:38818 "EHLO
	av12-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbYJRJfz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Oct 2008 05:35:55 -0400
Received: by av12-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 9770338C75; Sat, 18 Oct 2008 11:35:53 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av12-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 82F7B38B88; Sat, 18 Oct 2008 11:35:53 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 6DE8137E4A;
	Sat, 18 Oct 2008 11:35:53 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <c6c947f60810172322o12beeb80xfd39b551b0db7c99@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98534>

l=F6rdagen den 18 oktober 2008 08.22.24 skrev Alexander Gladysh:
> 2. Now I have one such file. I'm managing my repo on OS X, and have n=
o
> access to other machines right now. How can I create commit that
> renames the file? Git GUI manages to create commit that adds the
> renamed file, but does not delete old one.

Rename the file and add it. Then git add -u to remove the old name and =
commit.

-- tobin
