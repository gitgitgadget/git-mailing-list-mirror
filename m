From: Drew Northup <drew.northup@maine.edu>
Subject: Re: CRLF, LF ... CR ?
Date: Thu, 13 Sep 2012 11:34:50 -0400
Message-ID: <1347550490.24469.54.camel@drew-northup.unet.maine.edu>
References: <20120913170943725232.01d717ef@gpio.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Bauer <jens-lists@gpio.dk>
X-From: git-owner@vger.kernel.org Thu Sep 13 17:36:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCBSn-0003ty-Nn
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 17:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167Ab2IMPgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 11:36:13 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:38032 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758106Ab2IMPgM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 11:36:12 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id q8DFYrvU003031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Sep 2012 11:34:58 -0400
In-Reply-To: <20120913170943725232.01d717ef@gpio.dk>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-URT-Metrics: basalt.its.maine.edu 1060; Body=2 Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: q8DFYrvU003031
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1348155307.41913@zjTb3gYYJCTea9UHt4Sfww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205387>

On Thu, 2012-09-13 at 17:09 +0200, Jens Bauer wrote:
> Hi everyone.
> 
> I'm quite fond of git, and have used it for a while.
> Recently, I've started making printed circuit boards (PCBs) using an application called OsmondPCB (for Mac), and I'd like to use git to track changes on these.
> This application was originally written for the old Mac OS (Mac OS 6 to Mac OS 9.2).
> The old Mac OS does not use LF, nor CRLF for line endings, but only CR.
> 
> I've read that git supports two different line endings; either CRLF or LF, but it does not support CR.
> Would it make sense to add support for CR (if so, I hereby request it as a new feature) ?

Jens,
Even if Git can't do CRLF/LF translation on a file it will still store
and track the content of it it just fine. In fact you probably want
translation completely disabled in this case. 

(Given that you seem to be working on a Mac I suspect that "disabled" is
likely the default setting for that configuration item.)

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
