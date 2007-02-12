From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Sun, 11 Feb 2007 21:37:24 -0500
Message-ID: <45CFD2E4.5030806@verizon.net>
References: <45CFA30C.6030202@verizon.net>
 <200702120114.21477.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 03:37:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGR4N-0002Kn-K8
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 03:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939AbXBLCh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 21:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932941AbXBLCh2
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 21:37:28 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:52504 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932939AbXBLCh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 21:37:28 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDB00D9ZWM942A8@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 11 Feb 2007 20:37:23 -0600 (CST)
In-reply-to: <200702120114.21477.robin.rosenberg.lists@dewire.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39352>

Robin Rosenberg wrote:
> As of today git is a posix tool simply because it's not fully ported to
> other enviromnents. I brought this up quite a time ago, and didn't face heavy artillery
> then, and wouldn't today either. The code is still missing though. I didn't 
> write it then, because it's my #1 priority and nobody else did. Linus even did a 
> rough scetch, but that's it.
So, the basic design for this feature exists where? I would assume this 
would include a file mode indicator set in the blob or tree designating 
the blob is "text", along with mechanism to specify for a project what 
files are "text", along with some safety valve to check and not do 
transformation when the file does not look text-ish.

Mark
