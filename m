From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [RFC/PATCH] Force using Tcl/Tk 8.4 on Mac OS X
Date: Tue, 14 Sep 2010 07:42:34 +0200
Message-ID: <1jossvu.zf5a2u1xnuow0M%lists@haller-berlin.de>
References: <CB6C69E6-7943-49B7-96E7-4C00831C3C9D@users.sourceforge.net>
Cc: git@vger.kernel.org, dsteffen@apple.com (Daniel A Steffen)
To: das@users.sourceforge.net (Daniel A. Steffen)
X-From: git-owner@vger.kernel.org Tue Sep 14 07:42:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvOIB-0002RW-9I
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 07:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab0INFmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 01:42:39 -0400
Received: from mail.ableton.net ([62.96.12.115]:53785 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab0INFmi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 01:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=dCmG6i6Kzda7RVjqw7m/L4QhTEWrDRCa53DLZIaUD+o=;
	b=fiACTr3Z4Upq0/frrTRlhdLwtpa8WHF1t9EAVoDte28Pci1qej2ZbOyQIhGNiHlUSBrHl1ADS1s6k74LoXBqz7KH0hK2N4ba7+Z9LR5YYmljokUn5UqGn/+ltvcXPXB+g+3us490UG6sl/gheMe9Lb3u1lPLmsvLxzHXNG71KdU=;
Received: from dslb-088-073-104-214.pools.arcor-ip.net ([88.73.104.214] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OvODe-0004ST-KZ; Tue, 14 Sep 2010 07:38:14 +0200
In-Reply-To: <CB6C69E6-7943-49B7-96E7-4C00831C3C9D@users.sourceforge.net>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156162>

Daniel A. Steffen <das@users.sourceforge.net> wrote:

> Ultimately the right way to address this issue is to fix it in Tk, please
> report this in the Tk bug tracker if you haven't already, a quick glance
> in the debugger shows a hang in recursive event loop invocation such as
> used by tk_dialog when called from a menu accelerator callback.

I finally got around to this now.  It was already reported as issue
3044863; I added a comment to the existing ticket.

<http://sourceforge.net/tracker/?func=detail&aid=3044863&group_id=12997&atid=112997>

I still think we need a work-around in git gui (and maybe gitk) until a
fixed Tk version is widely available. Yesterday I showed git to a
co-worker, and after 20 minutes of randomly playing around with it he
ran into the problem (without me pointing him to it).

-Stefan


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
