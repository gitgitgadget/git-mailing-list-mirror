From: Drew Northup <drew.northup@maine.edu>
Subject: Re: How to push the very last modification only ?
Date: Mon, 18 Jul 2011 12:49:13 -0400
Message-ID: <1311007753.18654.32.camel@drew-northup.unet.maine.edu>
References: <20110718131730.4898ddaf@shiva.selfip.org>
	 <4E23F5CB.3090009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Mon Jul 18 18:50:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qir17-0007AZ-5L
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 18:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab1GRQt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 12:49:56 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:44270 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab1GRQtz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 12:49:55 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p6IGnIrA001605
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 18 Jul 2011 12:49:23 -0400
In-Reply-To: <4E23F5CB.3090009@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p6IGnIrA001605
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1311612576.67265@tEdBZW0Ygzpw6XtIrRFpuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177384>


On Mon, 2011-07-18 at 20:58 +1200, Chris Packham wrote:
> Hi,
> 
> On 18/07/11 19:47, J. Bakshi wrote:
> > Hello list,
> > 
> > I have found that during push, all local commit goes into the git 
> > server.
> 
> Yes that's the normal behaviour. When you think about what push is doing
> it's trying to make the remote branch the same as your local branch.
> 
> > Where I like to only push the very last modification with
> > a meaningful comment which will be available at the git server. How
> > can I then push only the last modified one ?
> 
> This is easily doable. What you need to do is prepare a branch that you
> do want to push. Something like this, assuming that your current branch
> is 'master' and you want to push to origin/master:
<snip>

Another way to do what Chris describes is to use Interactive Rebase (git
rebase -i) to squash commits together. Please read the manual page for
that carefully before using it on a production repository.
-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
