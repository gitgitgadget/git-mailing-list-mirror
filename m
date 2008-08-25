From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: [PATCH] git-p4: Fix one-liner in p4_write_pipe function.
Date: Mon, 25 Aug 2008 20:41:11 +0000 (UTC)
Message-ID: <g8v5d7$apj$1@ger.gmane.org>
References: <1219353100-1692-1-git-send-email-torarvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 25 22:42:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXitR-0006tX-Qr
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 22:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbYHYUl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 16:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbYHYUl0
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 16:41:26 -0400
Received: from main.gmane.org ([80.91.229.2]:60486 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078AbYHYUlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 16:41:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KXisM-0002nl-G9
	for git@vger.kernel.org; Mon, 25 Aug 2008 20:41:22 +0000
Received: from 62-31-42-82.cable.ubr03.dals.blueyonder.co.uk ([62.31.42.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 20:41:22 +0000
Received: from wildfire by 62-31-42-82.cable.ubr03.dals.blueyonder.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 20:41:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 62-31-42-82.cable.ubr03.dals.blueyonder.co.uk
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93672>

On Thu, 21 Aug 2008 23:11:40 +0200, Tor Arvid Lund wrote:

> The function built a p4 command string via the p4_build_cmd function,
> but ignored the result.

Opps - thanks for catching this.

Anand
