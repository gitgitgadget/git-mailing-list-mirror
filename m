From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: How to change merge message ("weenie commits")
Date: Sat, 27 Jan 2007 00:24:45 +0100
Organization: Dewire
Message-ID: <200701270024.46116.robin.rosenberg.lists@dewire.com>
References: <17848.54065.631799.755255@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 00:24:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAaQc-0006Gr-6K
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 00:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbXAZXYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 18:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbXAZXYP
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 18:24:15 -0500
Received: from [83.140.172.130] ([83.140.172.130]:15853 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbXAZXYO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 18:24:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 90235803392;
	Sat, 27 Jan 2007 00:19:37 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04747-04; Sat, 27 Jan 2007 00:19:37 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 4D293803391;
	Sat, 27 Jan 2007 00:19:37 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <17848.54065.631799.755255@lisa.zopyra.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37897>

torsdag 25 januari 2007 16:56 skrev Bill Lear:
> So, when I merge my topic branch onto master, for example, I'd like
> the commit message to be something more thoughtful than the
> "checkpoint 1", "checkpoint 2", "fix typo", "redo sort algorithm",
> etc., etc., and be more like a short set of release notes, a summary
> of what all has been accomplished.
>
> Do others run into this and perhaps have a good solution?

I agree with Karl. Stacked Git is the tool. It doesn't help in splitting 
muliple changes to one file so you have to do that manually with e.g. emacs.

-- robin
