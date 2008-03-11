From: Andreas Hildebrandt <anhi@bioinf.uni-sb.de>
Subject: How to ignore deleted files
Date: Tue, 11 Mar 2008 13:58:43 +0100
Message-ID: <47D68203.10905@bioinf.uni-sb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 14:52:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ4uK-0006UY-KX
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbYCKNwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbYCKNwE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:52:04 -0400
Received: from theia.rz.uni-saarland.de ([134.96.7.31]:1810 "EHLO
	theia.rz.uni-saarland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbYCKNwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:52:03 -0400
X-Greylist: delayed 3196 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Mar 2008 09:52:03 EDT
Received: from mail.cs.uni-sb.de (mail.cs.uni-sb.de [134.96.254.200])
	by theia.rz.uni-saarland.de (8.14.1/8.14.0) with ESMTP id m2BCwix3028600
	for <git@vger.kernel.org>; Tue, 11 Mar 2008 14:58:45 +0200
Received: from domino.bioinf.uni-sb.de (domino.bioinf.uni-sb.de [134.96.237.60])
	by mail.cs.uni-sb.de (8.14.2/2008022900) with ESMTP id m2BCwiau022170
	for <git@vger.kernel.org>; Tue, 11 Mar 2008 13:58:44 +0100 (CET)
Received: from [134.96.237.57] ([134.96.237.57])
          by domino.bioinf.uni-sb.de (Lotus Domino Release 8.0)
          with ESMTP id 2008031114105444-17306 ;
          Tue, 11 Mar 2008 14:10:54 +0100 
User-Agent: Thunderbird 2.0.0.5 (X11/20070725)
X-MIMETrack: Itemize by SMTP Server on domino/CBISaar(Release 8.0|August 02, 2007) at
 11.03.2008 14:10:54,
	Serialize by Router on domino/CBISaar(Release 8.0|August 02, 2007) at
 11.03.2008 14:10:55,
	Serialize complete at 11.03.2008 14:10:55
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (theia.rz.uni-saarland.de [134.96.7.31]); Tue, 11 Mar 2008 13:58:45 +0100 (CET)
X-AntiVirus: checked by AntiVir MailGate (version: 2.1.2-14; AVE: 7.6.0.73; VDF: 7.0.3.16; host: AntiVir1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76846>

Dear all,

our git repository contains a number of .tar.gz - files that are
automatically extracted and then deleted during the build process.
Unfortunately, commiting any changes after that step will mark those
files as deleted and try to commit that to the repository. Is there any
way to tell git to ignore those files automatically (apart from changing
our build process not to use or not to delete those files)?

Sorry if I overlooked something obvious,

Andreas Hildebrandt
