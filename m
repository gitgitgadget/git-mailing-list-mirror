From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Tue, 16 Sep 2008 23:13:56 +0200
Message-ID: <200809162313.56444.robin.rosenberg.lists@dewire.com>
References: <loom.20080915T222909-709@post.gmane.org> <48CF630F.4090808@gmail.com> <32541b130809160904v7acc73cfm4856c33d40555e94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Sergio Callegari" <sergio.callegari@gmail.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 23:17:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfhvP-0000hq-NJ
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 23:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbYIPVQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 17:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbYIPVQX
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 17:16:23 -0400
Received: from av10-1-sn2.hy.skanova.net ([81.228.8.181]:44786 "EHLO
	av10-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbYIPVQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 17:16:23 -0400
Received: by av10-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 8AAED3A0BB; Tue, 16 Sep 2008 23:15:53 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av10-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id EF5D63A9EC; Tue, 16 Sep 2008 23:15:42 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 6B16637E4C;
	Tue, 16 Sep 2008 23:15:42 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <32541b130809160904v7acc73cfm4856c33d40555e94@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96035>

tisdagen den 16 september 2008 18.04.44 skrev Avery Pennarun:
> unzipping from /dev/stdin seems to work if stdin is seekable, otherwise not.
> 
>        unzip /dev/stdin <filename.zip    # works
>        cat filename.zip | unzip /dev/stdin    # doesn't work

Try a cousin of zip for extraction:

	cat filename.zip | jar x # works

> Have fun,
Always.

-- robin
