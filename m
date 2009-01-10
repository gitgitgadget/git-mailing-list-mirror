From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH EGIT Allow for git config to not error when lines have '/r' in them.]
Date: Sat, 10 Jan 2009 21:34:05 +0100
Message-ID: <200901102134.05652.robin.rosenberg@dewire.com>
References: <142772020901071910ha95d53fo2454f8685908338c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: "Ryan Alberts" <ralberts@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 21:35:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLkYT-0000En-P0
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 21:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbZAJUeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 15:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbZAJUeL
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 15:34:11 -0500
Received: from mail.dewire.com ([83.140.172.130]:11523 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbZAJUeK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 15:34:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 175061484F7B;
	Sat, 10 Jan 2009 21:34:07 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JAIm2SW9daOt; Sat, 10 Jan 2009 21:34:07 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 140801484F7A;
	Sat, 10 Jan 2009 21:34:06 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <142772020901071910ha95d53fo2454f8685908338c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105142>

torsdag 08 januari 2009 04:10:05 skrev Ryan Alberts:
> I have attached a small fix for when a git config has /r lines in the file.
> I have to admit that I do not usually submit patches to the open source
> community and I am not very familiar with the process :-)  Please, please,
> let me know if I can do something different next time!

1) Inline the patch
No, need for such a large sign-off. It's good you declare that you have
understand the SOB-line.

You can add "extra" comments that should not go into the cBommit after the
comment like this:

From:.. etc

"This" goes into the commit

Signed-off-by: Whom Ever  <whom.ever@example.com>
--- 

The three dashes ends the comment. Anything after it and the actual patch
will be ignored by git am, but might be useful to the maintainer.

Back to the patch. I think we should only ignore \r (not /r, but could say CR in
a comment) before an LF. 

-- robin
