From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: git over https and http 1.1
Date: Thu, 19 May 2011 22:36:06 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1105192235380.25633@tvnag.unkk.fr>
References: <OF134A8B76.F0B9B9C0-ON85257894.00462851-85257894.00462862@greenhouse.lotus.com> <1305837109.25259.11.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nir.Friedman@greenhouse.lotus.com, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu May 19 22:36:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN9xM-0004LQ-AP
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 22:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934252Ab1ESUgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 16:36:23 -0400
Received: from giant.haxx.se ([80.67.6.50]:41387 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933968Ab1ESUgW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 16:36:22 -0400
Received: from giant.haxx.se (giant.haxx.se [80.67.6.50])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id p4JKa6E2013295;
	Thu, 19 May 2011 22:36:06 +0200
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <1305837109.25259.11.camel@drew-northup.unet.maine.edu>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
X-Greylist: Default is to whitelist mail, not delayed by milter-greylist-4.3.8 (giant.haxx.se [80.67.6.50]); Thu, 19 May 2011 22:36:06 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174001>

On Thu, 19 May 2011, Drew Northup wrote:

> Perhaps Git+libcurl isn't using keep-alive? I'd have to check the code.

They do. HTTP 1.1 even does "keep-alive" by default...

-- 

  / daniel.haxx.se
