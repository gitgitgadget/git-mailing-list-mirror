From: Uwe Storbeck <uwe@ibr.ch>
Subject: Re: [PATCH] test-lib.sh: use printf instead of echo
Date: Mon, 17 Mar 2014 19:38:08 +0100
Message-ID: <20140317183807.GB1971@ibr.ch>
References: <20140314235735.GA6959@ibr.ch>
 <53241688.2050604@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 19:38:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPcQU-0006Jd-CY
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 19:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972AbaCQSiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 14:38:12 -0400
Received: from gate.ibr.ch ([83.150.36.130]:56114 "EHLO gate.ibr.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756873AbaCQSiK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 14:38:10 -0400
Received: from bacardi.ibr.ch (bacardi.ibr.ch [172.16.1.1])
	by gate.ibr.ch (Postfix) with ESMTP id 0345A17F5F;
	Mon, 17 Mar 2014 19:38:09 +0100 (CET)
Received: from grappa.ibr.ch (grappa [172.16.8.20])
	by bacardi.ibr.ch (Postfix) with ESMTP
	id 13B88153F5; Mon, 17 Mar 2014 19:38:07 +0100 (CET)
Received: by grappa.ibr.ch (Postfix, from userid 1111)
	id 6E3A9D0C98; Mon, 17 Mar 2014 19:38:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <53241688.2050604@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244262>

On Mar 15, Johannes Sixt wrote:
> > -	echo "$@" | sed -e 's/^/#	/'
> > +	printf '%s\n' "$@" | sed -e 's/^/#	/'
> 
> This should be
> 
> 	printf '%s\n' "$*" | sed -e 's/^/#	/'

Right, that should be $* to always be one argument for the format
pattern.

Thanks

Uwe
