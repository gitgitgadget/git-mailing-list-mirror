From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] Fixed a bug that caused tabs in ~/.ssh/config to break parsing
Date: Sun, 21 Sep 2008 00:18:29 +0200
Message-ID: <200809210018.29724.robin.rosenberg.lists@dewire.com>
References: <12219428213749-git-send-email-ggoudsmit@shebang.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org
To: Gilion Goudsmit <ggoudsmit@shebang.nl>
X-From: git-owner@vger.kernel.org Sun Sep 21 00:20:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhAoq-0003Nl-PC
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 00:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbYITWT2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 18:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbYITWT2
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 18:19:28 -0400
Received: from av9-1-sn2.hy.skanova.net ([81.228.8.179]:37318 "EHLO
	av9-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYITWT1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Sep 2008 18:19:27 -0400
Received: by av9-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 82E5638DD2; Sun, 21 Sep 2008 00:19:25 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av9-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id 4DF923854A; Sun, 21 Sep 2008 00:19:25 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id BD5AB37E44;
	Sun, 21 Sep 2008 00:19:24 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <12219428213749-git-send-email-ggoudsmit@shebang.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96371>

l=F6rdagen den 20 september 2008 22.33.41 skrev Gilion Goudsmit:
> Having only tab-characters separating a key and value in the
> users ~/.ssh/config would cause the config-parser to fail with
> a "String index out of range: -1" exception. Also simplified
> the line parsing code my using a two argument split.

Thank you and welcome to the club!

-- robin
