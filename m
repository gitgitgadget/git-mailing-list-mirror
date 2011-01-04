From: Drew Northup <drew.northup@maine.edu>
Subject: Re: git repo corruption
Date: Tue, 04 Jan 2011 07:34:03 -0500
Message-ID: <1294144443.17969.0.camel@drew-northup.unet.maine.edu>
References: <AANLkTi=TSy1WQZARNQgGfPiV93hQ-xmCTip75JAixgDB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Levend Sayar <levendsayar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 13:40:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa6Bv-0000ei-Qh
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 13:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197Ab1ADMkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 07:40:39 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:34201 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab1ADMki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 07:40:38 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p04CY8YI001319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Jan 2011 07:34:08 -0500
In-Reply-To: <AANLkTi=TSy1WQZARNQgGfPiV93hQ-xmCTip75JAixgDB@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p04CY8YI001319
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1294749250.18965@/3cuaSJBKdrbeQSWc58z5w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164486>


On Tue, 2011-01-04 at 11:10 +0200, Levend Sayar wrote:
> Hi, all.
> 
> We have a repo on a corporate server. The sysadmin changed access
> rights of files on our repo by accedant.
> Some directories have 2750 acces rights before, but he changed as
> 
> chmod -R 2770 *
> 
> Now when you make git status, every file that is tracked by git is said as
> 
> changed but not updated
> 
> So is there a way to get this back to normal ?
> 
> TIA
> 
> _lvnd_
> (^_^)

Am I correct in guessing that this is not a bare repo?

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
