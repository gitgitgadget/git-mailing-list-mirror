From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] commit: quote the user name in the example
Date: Wed, 24 Feb 2010 06:19:35 -0800
Message-ID: <20100224141935.GC2709@ftbfs.org>
References: <1266980049-5835-1-git-send-email-kraai@ftbfs.org>
 <4B84DA03.1040809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 15:22:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkI88-0001BY-Tu
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 15:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170Ab0BXOWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 09:22:20 -0500
Received: from zoom.lafn.ORG ([206.117.18.8]:45926 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab0BXOWU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 09:22:20 -0500
Received: from macbookpro (pool-71-254-176-161.lsanca.fios.verizon.net [71.254.176.161])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id o1OEJfhc059997
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Feb 2010 06:19:41 -0800 (PST)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by macbookpro with local (Exim 4.71)
	(envelope-from <kraai@ftbfs.org>)
	id 1NkI5P-0006hI-PX; Wed, 24 Feb 2010 06:19:35 -0800
Content-Disposition: inline
In-Reply-To: <4B84DA03.1040809@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140944>

On Wed, Feb 24, 2010 at 08:49:23AM +0100, Johannes Sixt wrote:
> Actually, I would prefer that the suggested command is
> 
>   git config --global user.name "Your Name"
> 
> i.e., with double-quotes, because then the suggestion is also correct for
> Windows users who run git from CMD: in this environment, single-quotes do
> not quote, but double-quotes do.

I've justed submitted a modified version of the patch that uses
double-quotes.  Thanks for the suggestion.

-- 
Matt                                            http://ftbfs.org/kraai
