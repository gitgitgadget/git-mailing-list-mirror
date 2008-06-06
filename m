From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v3 09/23] Added a Rules interface implementation and a factory for it.
Date: Fri, 6 Jun 2008 02:23:00 +0200
Message-ID: <200806060223.01120.robin.rosenberg.lists@dewire.com>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de> <1211574872-23676-10-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 02:27:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4PnT-0001g6-6N
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 02:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbYFFA0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 20:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754394AbYFFAZ7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 20:25:59 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18863 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754256AbYFFAZu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 20:25:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 76E671434DD0;
	Fri,  6 Jun 2008 02:25:49 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qUqP0nOuYRmG; Fri,  6 Jun 2008 02:25:49 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id EF6A31434DCE;
	Fri,  6 Jun 2008 02:25:48 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1211574872-23676-10-git-send-email-florianskarten@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84007>

fredagen den 23 maj 2008 22.34.18 skrev Florian Koeberle:
> +	/**
> +	 * @see Rules#toIgnore(java.lang.String, boolean)
> +	 */
> +	public boolean toIgnore(String fileName, boolean fileIsDirectory) {

(Applies to many places)
Don't make javadoc style comments for overrides. Rather just omit it
or use a plain comment. Also use the @Override annotation if you
override an implementation. We use Java 5, so we may as well use
all bells and whistles that make sense.

I'm not sure about other IDE's, but Eclipse will automaticall picks up then
javadoc for the superclass or interface that declare the methos being 
overridden if the overriding method does not hava a javadoc comment.
The javadoc tool also does this so I assume any descent IDE
does too (if not it's a bug).

-- robin
