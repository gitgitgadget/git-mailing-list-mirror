From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v3 06/23] Added the class FileNamePattern.
Date: Fri, 6 Jun 2008 02:22:57 +0200
Message-ID: <200806060222.57591.robin.rosenberg.lists@dewire.com>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de> <1211574872-23676-7-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 02:27:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4PnS-0001g6-Gw
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 02:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387AbYFFAZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 20:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbYFFAZ5
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 20:25:57 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18859 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754215AbYFFAZr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 20:25:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 081B31434DD0;
	Fri,  6 Jun 2008 02:25:46 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3FQ5UbAf58zK; Fri,  6 Jun 2008 02:25:45 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6D68C1434DCE;
	Fri,  6 Jun 2008 02:25:45 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1211574872-23676-7-git-send-email-florianskarten@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84011>

> +	public boolean match(String fileName, boolean fileIsDirectory) {
> +		if (matchDirectoriesOnly && !fileIsDirectory) {
> +			return false;
> +		}
> +		fileNameMatcher.resetStringToMatch();

Partially discusses before, but here is another aspect. One advantage
with bracketless code is that you get an extra blank line for free.

	if (matchDirectoriesOnly && !fileIsDirectory)
		return false;

	fileNameMatcher.resetStringToMatch();

-- robin
