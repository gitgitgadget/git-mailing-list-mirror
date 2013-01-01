From: stefan@haller-berlin.de (Stefan Haller)
Subject: Re: Bug in latest gitk - can't click lines connecting commits
Date: Tue, 1 Jan 2013 18:54:23 +0100
Message-ID: <1kw18d3.5sftkl125qdz4M%stefan@haller-berlin.de>
References: <20130101172156.GA22450@gmail.com>
Cc: paulus@samba.org
To: jason.k.holden.swdev@gmail.com (Jason Holden), git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 19:07:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq6F9-0000mE-Cr
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 19:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab3AASDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 13:03:08 -0500
Received: from server90.greatnet.de ([83.133.96.186]:51414 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab3AASDH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 13:03:07 -0500
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jan 2013 13:03:07 EST
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 757062C4069;
	Tue,  1 Jan 2013 18:54:22 +0100 (CET)
In-Reply-To: <20130101172156.GA22450@gmail.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.8.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212430>

Jason Holden <jason.k.holden.swdev@gmail.com> wrote:

> I was testing some patches against the latest gitk, and noticed that when I
> click the mouse on the lines that connect the commits in the history graph,
> I get an error popup with:
>  Error: can't read "cflist_top": no such variable
> 
> Looks like this was introduced in gitk commit b967135d89e8d8461d059
>  gitk: Synchronize highlighting in file view when scrolling diff

A patch that fixes this was proposed over two months ago, and Paul said
he had applied it:

  <http://permalink.gmane.org/gmane.comp.version-control.git/208162>

However, looking at git://ozlabs.org/~paulus/gitk.git it's not there.
Paul?


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
