From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: [PATCH 1/3] Make read_index_data() public
Date: Sat, 13 Apr 2013 10:23:17 +0200
Message-ID: <20130413082317.GA31894@blizzard>
References: <1365787573-597-1-git-send-email-git@cryptocrack.de>
 <1365787573-597-2-git-send-email-git@cryptocrack.de>
 <20130412194012.GA5154@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 13 10:23:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQvkM-0000HR-5H
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 10:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab3DMIXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 04:23:22 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:29093 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab3DMIXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 04:23:20 -0400
Received: from localhost (p57B40B0C.dip.t-dialin.net [87.180.11.12])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 853f89a2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128);
	Sat, 13 Apr 2013 10:23:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130412194012.GA5154@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221055>

On Fri, Apr 12, 2013 at 03:40:12PM -0400, Jeff King wrote:
> On Fri, Apr 12, 2013 at 07:26:11PM +0200, Lukas Fleischer wrote:
> 
> > This allows for reusing the function in convert.c later.
> > 
> > Also, move it from attr.c to read-cache.c and add a use_index parameter
> > to specify a custom index_state since we are no longer enable to access
> > the static use_index variable from attr.c.
> 
> I'm all for removing duplicated code, but, but I think the name
> "read_index_data" is a bit misleading for a global function. I would
> expect it to read data from the index (and the argument "path" does not
> help clarify that at all).
> 
> Can we rename it read_blob_data_from_index_path() or something?

Pretty long function name... I agree that it is better to have a verbose
function name instead of something short that gives a wrong impression
of what the function does and I can't think of a shorter, yet
descriptive way to name the function.

If nobody comes up with an alternative suggestion, I will change it to
read_blob_data_from_index_path() and resubmit.

> 
> -Peff
