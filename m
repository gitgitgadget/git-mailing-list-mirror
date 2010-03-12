From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH 1/5] General configuration portability (Resend)
Date: Fri, 12 Mar 2010 06:23:09 +0000
Message-ID: <20100312062308.GI7877@thor.il.thewrittenword.com>
References: <20100311162750.GA7877@thor.il.thewrittenword.com>
 <1268326882-sup-9149@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 07:23:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpyHE-0004UM-6B
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 07:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab0CLGXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 01:23:11 -0500
Received: from mail1.thewrittenword.com ([69.67.212.77]:56738 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab0CLGXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 01:23:09 -0500
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 2941B5C21
	for <git@vger.kernel.org>; Fri, 12 Mar 2010 06:42:21 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 2941B5C21
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 259E4D8A
	for <git@vger.kernel.org>; Fri, 12 Mar 2010 06:23:09 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 1EFB4BAB0; Fri, 12 Mar 2010 06:23:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1268326882-sup-9149@pinkfloyd.chass.utoronto.ca>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142021>

Hi Ben,

On Thu, Mar 11, 2010 at 12:01:51PM -0500, Ben Walton wrote:
> Excerpts from Gary V. Vaughan's message of Thu Mar 11 11:27:50 -0500 2010:
> > -gitexecdir = libexec/git-core
> > +gitexecdir = libexec
> 
> You're proposing to change the execdir?

>From the OP:

  This patch is in part to deal with peculiarities of our build                 
  environment [[...]] Probably, much of this patch is useful upstream.

We install each package in it's own directory, and remove redundant
directories as a local policy.  So /opt/fsw/git17/libexec/git-core
becomes /opt/fsw/git17/libexec.

My employer kindly agreed to donate a little of my paid time to push
the git patches we require to build on our supported hosts back
upstream.  There is certainly some good stuff in here that is useful
outside of our environment, but I have another 1600 packages to port
too...

Cheers,
    Gary
-- 
Gary V. Vaughan (gary@thewrittenword.com)
