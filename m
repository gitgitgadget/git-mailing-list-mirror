From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] Use SSH key from `GIT_SSH_KEY` variable if supplied
Date: Tue, 20 Mar 2012 02:07:11 +0000
Message-ID: <robbat2-20120320T020552-803311730Z@orbis-terrarum.net>
References: <1332207557-10965-1-git-send-email-me@mmalecki.com>
 <7vhaxk829x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 03:07:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9oUE-0000aI-LT
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 03:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759241Ab2CTCHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 22:07:13 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:46503 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756745Ab2CTCHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 22:07:12 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id CD7431B403E
	for <git@vger.kernel.org>; Tue, 20 Mar 2012 02:07:11 +0000 (UTC)
Received: (qmail 7758 invoked by uid 10000); 20 Mar 2012 02:07:11 -0000
Content-Disposition: inline
In-Reply-To: <7vhaxk829x.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193478>

On Mon, Mar 19, 2012 at 06:55:06PM -0700,  Junio C Hamano wrote:
> Hmm. I am somewhat torn.
> 
> The minimalist in me finds this extraneous and unnecessary noise.  Why
> should the user always set GIT_SSH_KEY environment variable that only
> applies to git and does not help his other ssh sessions?  Why isn't having
> an entry in .ssh/config to name IdentityFile sufficient?
> 
> Would GIT_SSH_ARGS='-i /home/me/.ssh/there.pub -l me' be more appropriate?
I'd strongly prefer a generic args support, for making it easier to use
in deployment code.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
