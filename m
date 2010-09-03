From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Checking out a branch in another directory
Date: Fri, 3 Sep 2010 15:10:52 -0700 (PDT)
Message-ID: <800379.5243.qm@web31805.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 00:11:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OreTR-0002XM-Fl
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 00:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757782Ab0ICWK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 18:10:56 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:47451 "HELO
	web31805.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757739Ab0ICWKx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 18:10:53 -0400
Received: (qmail 5392 invoked by uid 60001); 3 Sep 2010 22:10:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1283551852; bh=YRv+bxcvXmtG48IXcL93ff+2hPSmPd2CcNtnNb7ndec=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type; b=dcJJNaxK8mYGMugfs/ytutKd1PhkNyv2Kqfs7niIu4c9sbhux2onKdFl0YXYR6LRIYR8BbsD3Rkhdn/TLhV6QnRjK2+IZVT3f4vpuZammaO1NvS4cfKyKJW1J4UTFW/S36QQskuwmzBsPWtWQJJKBYbUYTMvL3syqcpDk68Gv+E=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=rzIhsKgPhUoufm3/KQ90JF7kTgPf4r/qq/ZOBpY07tPLBsmM1lTns4IXmqPwU+LHwm6ufjXpg6gXeGd5P380Jj3Qh8ATQ/V2LEra0rqM0P0qG2MqfzTfl3wllEhMeCvEoOprfnGK7e6VlVY5nshsK3GdxLBIeUfG8G6qFkGvTK8=;
X-YMail-OSG: L5E73YkVM1mkwZVCLWMEhUcaqihgGDuW3ZrKeSAe308eNc.
 X76wXDGU8Hie0Qqeb2ewGhDX5qF23VxC6ZeZC.4Imt1rUU.PWqKHT7QE1VQm
 4LL1DtsOI3GSZCHQ0SxMAYj9X7MAqMTXArHLaSEZa22dI5nAYM2x.KbXGd8z
 GQ84vKOujwFB2J50RqSU_gYzVIfWDSmKlvbBwTFrQxRHLlnHuCworOKuDsvu
 Ynf4V8bYWDJkw68F5CkWnEa0VApqq3sK9brFS78_QV_YW3LrW9YIcatFSFq2
 erZ2kEbXx6mk8CbN.gnXcyaaVF6glx2ofzhkJhXBP8aDbvC5ZedbgSkfjyQB
 rmq2Pbclfdi4OwLSRhPNhnn4.apuS9ETx4YEkX1TO0Wi97hugOLF7
Received: from [71.132.223.28] by web31805.mail.mud.yahoo.com via HTTP; Fri, 03 Sep 2010 15:10:52 PDT
X-Mailer: YahooMailClassic/11.4.7 YahooMailWebService/0.8.106.282862
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155279>

I'd like to checkout a branch and work on it and so on, but *in another directory*.  I wasn't able to accomplish this with git clone, as I can see that refs/heads were NOT shared as also indicated by .git/config, local and/or shared.

Is there official tools to do this in master?

I basically want to eliminate having to do git-checkout <branch> and instead simply do a cd ../<branch>, but really have just a single history.

For the last 4 years, I've been using a home-brewed git-mkdir-of-branch.sh from a local branch, which basically creates a bunch of symlinks and then runs git-read-tree HEAD; git-checkout-index -u -q -f -a.

   Luben
