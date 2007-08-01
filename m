From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-sh-setup.sh: make GIT_EDITOR/core.editor/VISUAL/EDITOR accept commands
Date: Thu, 02 Aug 2007 00:17:37 +0200
Message-ID: <85ejimrjb2.fsf@lola.goethe.zz>
References: <7v7iof3uc5.fsf@assigned-by-dhcp.cox.net>
	<S1752294AbXHAWCj/20070801220239Z+281@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 00:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMWe-0002WY-Ho
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbXHAWS3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269AbXHAWS3
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:18:29 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:59463 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752236AbXHAWS2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 18:18:28 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id ACDC818B422
	for <git@vger.kernel.org>; Thu,  2 Aug 2007 00:18:27 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 9EDA62C6B72
	for <git@vger.kernel.org>; Thu,  2 Aug 2007 00:18:27 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-034-066.pools.arcor-ip.net [84.61.34.66])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 8A1DA3425E2
	for <git@vger.kernel.org>; Thu,  2 Aug 2007 00:18:27 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id DD0651C3E076; Thu,  2 Aug 2007 00:17:37 +0200 (CEST)
In-Reply-To: <S1752294AbXHAWCj/20070801220239Z+281@vger.kernel.org> (David Kastrup's message of "Wed\, 1 Aug 2007 23\:47\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.91.1, clamav-milter version 0.91.1 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54486>

David Kastrup <dak@gnu.org> writes:

> The previous code only allowed specifying a single executable rather
> than a complete command like "emacsclient --alternate-editor vi" in

Oops, won't apply cleanly.  I found that I had already made a
different (trivial) patch previously.  Let me try again and fold that
patch in manually.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
