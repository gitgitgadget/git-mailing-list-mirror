From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH] format-patch: use current date in mbox 'From COMMIT
 DATE' header line
Date: Thu, 15 Apr 2010 16:55:23 +0100
Message-ID: <20100415155523.GL12365@arachsys.com>
References: <9946ffbdf26e7b08b9b00b87d4b575fea774be4c.1271342450.git.chris@arachsys.com>
 <20100415151619.GK12365@arachsys.com>
 <201004151735.31415.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 15 17:55:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2RPk-0007tb-MT
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 17:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab0DOPza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 11:55:30 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:53896 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab0DOPz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 11:55:29 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O2RPZ-0004A8-A8; Thu, 15 Apr 2010 16:55:25 +0100
Content-Disposition: inline
In-Reply-To: <201004151735.31415.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144995>

Thomas Rast <trast@student.ethz.ch> writes:

> Have you read
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/124082/focus=124092

I hadn't but have now. I don't buy the idea that this date is an unused
placeholder in mbox files, and therefore can be sensibly set to an arbitary
constant date in the distant past.

RFC4155 appendix A defines this date as the date a message was received.
This isn't directly applicable to the context of format-patch, but other
users of mbox format (e.g. MUAs doing an fcc) tend to fill it with the date
the message was generated, and might reasonably expect to be able to
sort on this date, e.g. when displaying a drafts folder.

If nothing else, it's extremely surprising to run format-patch, see a
ridiculous date and wonder how your system time has become corrupted while
you've been working!

Cheers,

Chris.
