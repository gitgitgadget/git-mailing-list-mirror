From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] remove doubled words, e.g., s/to to/to/, and fix
	related typos
Date: Wed, 13 Apr 2011 14:35:49 -0400
Message-ID: <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
References: <87d3kq6tz7.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 20:36:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA4vQ-0007SH-QB
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 20:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174Ab1DMSgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 14:36:19 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:37184 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756574Ab1DMSgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 14:36:19 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p3DIZseG032553
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Apr 2011 14:35:54 -0400
In-Reply-To: <87d3kq6tz7.fsf@rho.meyering.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p3DIZseG032553
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1303324558.41851@qRLSPZjHvyFeAqSQKN1uXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171469>


On Wed, 2011-04-13 at 17:39 +0200, Jim Meyering wrote:
> I found that some doubled words had snuck back into projects from
> which I'd already removed them, so now there's a "syntax-check" makefile
> rule in gnulib to help prevent recurrence.  Running the command below
> spotted a few in git, too:
> 
> This patch is relative to "next".

Jim,
Try putting the output of git format-patch into your drafts folder, then
open that draft in your mail client. The output of format-patch isn't
meant to be pasted directly into a mail message.

> 
> >From d21d6f61bbeeba4a754cdcded66ca86a709695ee Mon Sep 17 00:00:00 2001
> From: Jim Meyering <meyering@redhat.com>

<rest of submission removed>

The above tells me that you just dumped the output of format-patch into
your mail client. There is a full tutorial in
Documentation/SubmittingPatches in git.git.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
