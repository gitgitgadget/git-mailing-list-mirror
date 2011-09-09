From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Fri, 09 Sep 2011 12:14:33 -0400
Message-ID: <1315584873.18331.103.camel@ddn-tmpdesk.its.maine.edu>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
	 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
	 <robbat2-20110907T234637-463765607Z@orbis-terrarum.net>
	 <20110908200343.GD16064@sigill.intra.peff.net>
	 <robbat2-20110909T004300-810527870Z@orbis-terrarum.net>
	 <20110909160301.GA9707@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 18:15:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23k0-0004M0-FM
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 18:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759349Ab1IIQOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 12:14:54 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:46469 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759367Ab1IIQOx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 12:14:53 -0400
Received: from [130.111.39.171] (ddn-tmpdesk.its.maine.edu [130.111.39.171])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p89GEX3N027570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 9 Sep 2011 12:14:33 -0400
In-Reply-To: <20110909160301.GA9707@gnu.kitenet.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=5 Fuz1=5
	Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p89GEX3N027570
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1316189675.31088@46gKs+j2vjfkB8IFFsGJ6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181091>


On Fri, 2011-09-09 at 12:03 -0400, Joey Hess wrote:

> It might be worth ameloriating that attack by making git log always
> show the full buffer. Or it would be easy to write a tool that finds
> any commits that have a NULL in their message.

Just be aware that fixing the problem by diallowing NULLs in the commit
message makes it impossible to include UTF-16 text in the commit message
(which isn't currently handled very well anyway). Granted, I'm not sure
what the most decent way of dealing with that otherwise might be as I've
not taken the time to think about it...

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
