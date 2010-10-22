From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFC] Print diffs of UTF-16 to console / patches to email as
	UTF-8...?
Date: Fri, 22 Oct 2010 13:01:56 -0400
Message-ID: <1287766916.31218.71.camel@drew-northup.unet.maine.edu>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
	 <20101022161851.GH9224@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 19:04:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9L2P-0000G5-VZ
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 19:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373Ab0JVREI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 13:04:08 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:46088 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab0JVREH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 13:04:07 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9MH21a6001345
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 13:02:06 -0400
In-Reply-To: <20101022161851.GH9224@burratino>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9MH21a6001345
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288371743.19104@MIIUZ27JnOVdbcaLo41Qqw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159713>


On Fri, 2010-10-22 at 11:18 -0500, Jonathan Nieder wrote:
> Hi,
> 
> Drew Northup wrote:
> 
> >         This is part of my ongoing work to treat UTF-16 as text (in
> > other words, the crlf options will work and .gitattributes hacks won't
> > be required to display diffs, etc).
> 
> What's wrong with .gitattributes for this use case?  I would think a
> clean/smudge filter would produce very good behavior from most git
> commands.
> 
> If speed is the issue, maybe a built-in clean/smudge filter would
> address that?

That still doesn't fix the crlf issue, for starters. Also, I would like
to be able to email patches for files that are in UTF-16 and properly
re-import them. Unless I'm missing something really big there's not much
that a display filter is going to do for me there. I want this to be
two-way.
To be honest, the not needing of a display filter goes along with
treating UTF-16 patches as text. The same sort of code will be required
for both, so why not get predictable behavior for another text encoding
at the same time?

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
