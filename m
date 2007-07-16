From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 16:06:12 -0500
Message-ID: <20070716210612.GI19073@lavos.net>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <alpine.LFD.0.999.0707161252330.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 23:06:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAXlx-0005jJ-22
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 23:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651AbXGPVGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 17:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756411AbXGPVGX
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 17:06:23 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:32106 "EHLO
	asav07.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049AbXGPVGW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 17:06:22 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav07.insightbb.com with ESMTP; 16 Jul 2007 17:06:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqMwAOB5m0ZKhvbzRmdsb2JhbACBSIVkiAYBAQE1
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 5AEC7309F31; Mon, 16 Jul 2007 16:06:12 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707161252330.20061@woody.linux-foundation.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52721>

On Mon, Jul 16, 2007 at 12:58:14PM -0700, Linus Torvalds wrote:
> I have to say that I'm still a bit shocked that Solaris would have that 
> kind of behaviour. And they call that pile of sh*t "enterprise class"..

Apparently "enterprise class" in this case really means "fully
compatibility with all those wonderful userland implementations of
rmdir."  :-)

-bcd
