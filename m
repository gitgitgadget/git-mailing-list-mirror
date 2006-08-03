From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-annotate bug report
Date: Thu, 3 Aug 2006 14:10:25 -0700
Message-ID: <20060803211024.GA29529@h4x0r5.com>
References: <20060803203848.GA15121@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ryan@michonline.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 23:11:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8kTg-0003gc-CY
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 23:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWHCVLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 17:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWHCVLc
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 17:11:32 -0400
Received: from h4x0r5.com ([70.85.31.202]:32775 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932193AbWHCVLc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 17:11:32 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1G8kSX-0002xy-5B; Thu, 03 Aug 2006 14:10:25 -0700
To: Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <20060803203848.GA15121@coredump.intra.peff.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24757>

On Thu, Aug 03, 2006 at 04:38:48PM -0400, Jeff King wrote:
> git-annotate on the tip of master seems to be broken for some files (but
> not for others):
> 
> $ git-describe
> v1.4.2-rc2-gfba0cbd
> $ make && ./git-annotate builtin-read-tree.c
> parent eff97e3faeb28f6521851c1b3be1a54a2138f12a is on line 852
> Line 852, does not match:
> ||
> |                       cnt++;|
> 021b6e454944a4fba878651ebf9bfe0a3f6c3077


Sweet, that might be exactly the test case I need to figure out where it
loses track of some lines during merges.

I'll see about looking at this over the weekend.

-- 

Ryan Anderson
  sometimes Pug Majere
