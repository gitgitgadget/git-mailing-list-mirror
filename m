From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 01 Aug 2007 22:36:51 +0200
Message-ID: <87hcnj9el8.fsf@mid.deneb.enyo.de>
References: <200708010216.59750.jnareb@gmail.com>
	<alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	<7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
	<20070801092428.GB28106@thunk.org>
	<7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
	<87tzrjfe5h.wl%cworth@cworth.org>
	<alpine.LFD.0.999.0708010937050.3582@woody.linux-foundation.org>
	<85vebzrufc.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 07:40:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGTPl-0002Mf-Qu
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 07:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbXHBFjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 01:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXHBFjw
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 01:39:52 -0400
Received: from mail.enyo.de ([212.9.189.167]:3231 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbXHBFjw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 01:39:52 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1IGTPa-0007g8-40
	for git@vger.kernel.org; Thu, 02 Aug 2007 07:39:50 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1IGKw7-0006HD-A6
	for git@vger.kernel.org; Wed, 01 Aug 2007 22:36:51 +0200
In-Reply-To: <85vebzrufc.fsf@lola.goethe.zz> (David Kastrup's message of "Wed,
	01 Aug 2007 20:17:27 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54516>

* David Kastrup:

> Couldn't git clone http://host/directory/to/repo tell the proxy that
> it should enter off-line mode and stop updating?

Huh? I don't see how this is relevant to the current thread.

Anyway, I don't think the max-stale cache control mechanism is widely
implemented.  If you want effective expiry controls, you need to
implement them on the server side.
