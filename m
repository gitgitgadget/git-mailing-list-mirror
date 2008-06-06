From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v3 05/23] Added the iterface Rules.
Date: Fri, 6 Jun 2008 02:22:51 +0200
Message-ID: <200806060222.51928.robin.rosenberg.lists@dewire.com>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de> <1211574872-23676-6-git-send-email-florianskarten@web.de>
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
	id 1K4Pn5-0001Wu-Fk
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 02:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbYFFAZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 20:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbYFFAZz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 20:25:55 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18854 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754000AbYFFAZp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 20:25:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EA0FF1434DD0;
	Fri,  6 Jun 2008 02:25:43 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id laCaEuhwCEci; Fri,  6 Jun 2008 02:25:40 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id C12C81434DCE;
	Fri,  6 Jun 2008 02:25:39 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1211574872-23676-6-git-send-email-florianskarten@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84006>


s/Iterface/Interface/

fredagen den 23 maj 2008 22.34.14 skrev Florian Koeberle:
> Signed-off-by: Florian Koeberle <florianskarten@web.de>
> ---
>  .../src/org/spearce/jgit/treewalk/rules/Rules.java |   99 ++++++++++++++++++++
>  1 files changed, 99 insertions(+), 0 deletions(-)
>  create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rules.java
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rules.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rules.java
> +	public abstract boolean toIgnore(String fileName, boolean fileIsDirectory);

Shouldn't this be shouldIgnore instead? toXXXX is a name of a converter as e.g. toString

> +		@Override
> +		public String toString() {
> +			return "ignore all rules";
Probably better with something like "Rules[IGNOREALL]" to distinguish it
from other strings. The bracketed toString is common for method intended
for debugging.
