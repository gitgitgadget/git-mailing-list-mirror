From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH 1/2] cvsexportcommit: chomp only removes trailing whitespace
Date: Wed, 14 May 2008 22:06:53 +0200
Message-ID: <200805142206.53242.robin.rosenberg@dewire.com>
References: <alpine.DEB.1.00.0805141526160.30431@racer> <7vskwkojhy.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805141936410.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 14 22:10:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwNHc-000770-K6
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 22:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758739AbYENUIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 16:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759209AbYENUIL
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 16:08:11 -0400
Received: from [83.140.172.130] ([83.140.172.130]:15898 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755530AbYENUII (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 16:08:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AA4D81434D1B;
	Wed, 14 May 2008 22:08:04 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hdEoUjfLBMHH; Wed, 14 May 2008 22:08:02 +0200 (CEST)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id C0F77802809;
	Wed, 14 May 2008 22:08:02 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0805141936410.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82143>

> Yes, that is the idea.  The point is: there are at least two different 
> implementations of cvs, and I do not want to rely on a particular one.

Does CVSNT add extra spaces?

A question arises. Can we use cvs update instead? It can be used to retrieve the
latest version (as the -u flag to cvsexportcommit does) and it will tell you what
status each affected file has. cvs  update -n will just give us the status with unambigous
file names.

-- robin
