From: Andreas Krey <a.krey@gmx.de>
Subject: Re: How to limit bandwidth used by git over SSH ?
Date: Wed, 20 Jul 2011 22:20:26 +0200
Message-ID: <20110720202026.GA30927@inner.h.iocl.org>
References: <4E22B7F7.4020701@seichter.de> <1311064940.3945.11.camel@bee.lab.cmartin.tk> <4E272A20.8080904@seichter.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Ralph Seichter <git-ml@seichter.de>
X-From: git-owner@vger.kernel.org Wed Jul 20 22:27:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjdN4-0001qN-Q6
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 22:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab1GTU1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 16:27:49 -0400
Received: from continuum.iocl.org ([217.140.74.2]:50711 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab1GTU1s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 16:27:48 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jul 2011 16:27:48 EDT
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id p6KKKR731264;
	Wed, 20 Jul 2011 22:20:27 +0200
Content-Disposition: inline
In-Reply-To: <4E272A20.8080904@seichter.de>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177546>

On Wed, 20 Jul 2011 21:18:56 +0000, Ralph Seichter wrote:
...
> The general idea to use a tool besides git or SSH to shape the bandwidth
> usage seems valid, though.

There are ways to integrate such a tool easier than the way trickle
does; by using the 'ProxyCommand' configuration option of ssh, like
'ProxyCommand netcat $yourhost 22' or similar. Unfortunately, I don't
know a suitable program offhand, netcat does not seem to have a bandwidth
limiting option. But then such a beast is relatively easy to write.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
