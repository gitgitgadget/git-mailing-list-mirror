From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v3 0/23] Implementation of a file tree iteration using ignore rules.
Date: Fri, 6 Jun 2008 02:22:40 +0200
Message-ID: <200806060222.40654.robin.rosenberg.lists@dewire.com>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 02:26:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Pn4-0001Wu-Fl
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 02:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbYFFAZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 20:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754000AbYFFAZf
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 20:25:35 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18845 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754104AbYFFAZb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 20:25:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5B5681434DD0;
	Fri,  6 Jun 2008 02:25:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ax8cF+V3Crbi; Fri,  6 Jun 2008 02:25:28 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id BF6251434DCE;
	Fri,  6 Jun 2008 02:25:28 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84005>

fredagen den 23 maj 2008 22.34.09 skrev Florian Koeberle:
> 
> Hi
> 
> This patch set contains a new fnmatch implementation.

Looks ok, with me. Only minor comments in separate mail.

> Unsupported are colon expressions like ":alpha:". I didn't expect git-add to support it, but as I just noticed git does.
Maybe we should anticipate it and throw an exception if one tries the pattern and not treat it as [alph:] .

Well we noted they were broken in Git so (separate thread) so we may as well try something sane. 

-- robin
