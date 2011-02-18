From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool--lib: add support for beyond compare
Date: Fri, 18 Feb 2011 09:36:51 +0000
Message-ID: <20110218093651.GA8700@hashpling.org>
References: <1298016553-2308-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 10:46:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqMv8-0007SV-Ot
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 10:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab1BRJqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 04:46:31 -0500
Received: from relay.pcl-ipout01.plus.net ([212.159.7.99]:56203 "EHLO
	relay.pcl-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754065Ab1BRJq3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 04:46:29 -0500
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Feb 2011 04:46:28 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEANfLXU3Unw4T/2dsb2JhbACmIHO8FIVeBJJa
Received: from outmx04.plus.net ([212.159.14.19])
  by relay.pcl-ipout01.plus.net with ESMTP; 18 Feb 2011 09:36:53 +0000
Received: from hashpling.plus.com ([212.159.69.125])
	 by outmx04.plus.net with esmtp (Exim) id 1PqMlh-00058Z-1t; Fri, 18 Feb 2011 09:36:53 +0000
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1PqMlf-0002Tj-RQ; Fri, 18 Feb 2011 09:36:51 +0000
Content-Disposition: inline
In-Reply-To: <1298016553-2308-1-git-send-email-judge.packham@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167190>

On Fri, Feb 18, 2011 at 09:09:13PM +1300, Chris Packham wrote:
> Add support for Beyond Compare as a diff/merge tool.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
> 
> I wasn't sure about whether git should have support for non-free external
> tools.  Then I saw that support for Araxis had been added in b6f0621a, which
> I've used as a guide for this patch.
 
You right, there is no specific reason not to support non-free merge
tools in mergetool; the major issue is testing. The patch looks
reasonable but I would prefer to see independent confirmation -
especially on windows, Beyond Compares' most popular supported platform
- before this patch is merged.

Charles.
