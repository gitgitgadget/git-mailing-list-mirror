From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Make git-push silent
Date: Thu, 21 Oct 2010 14:45:08 -0400
Message-ID: <1287686708.24161.39.camel@drew-northup.unet.maine.edu>
References: <20101021181906.GA28700@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Thu Oct 21 20:46:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P909Y-00007K-QM
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 20:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307Ab0JUSqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 14:46:10 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:43270 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab0JUSqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 14:46:09 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9LIjEl7009847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Oct 2010 14:45:19 -0400
In-Reply-To: <20101021181906.GA28700@nibiru.local>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9LIjEl7009847
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288291530.24483@/L0b2H9vZp/8C5OWc6Pjtw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159534>


On Thu, 2010-10-21 at 20:19 +0200, Enrico Weigelt wrote:
> Hi folks,
> 
> 
> is there a way to make git-push silent in a way that it only 
> outputs something in case of error ?
> 
> I'm using it as a backup tool via cron scripts, and therefore I
> dont want any output when everything went okay.
> 
> If there's no such a feature/switch yet, could anyone give me
> a hint where/how to implement this ?

Have you tried wrapping it in a shell script? That's what I do when
virus-checking multiple webspaces and not wanting routine output unless
there's a problem. If the return value (to the shell) is something other
than zero then I return all of the output I captured to the user (and
therefore it gets mailed to me by cron).

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
