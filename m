From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Wed, 27 Oct 2010 11:16:35 -0400
Message-ID: <1288192595.15518.37.camel@drew-northup.unet.maine.edu>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
	 <20101019175103.GA28847@kytes>  <20101027150314.GB1136@kytes>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 17:19:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7ma-0006Ck-Ir
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 17:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933649Ab0J0PTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 11:19:15 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:36935 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933540Ab0J0PTO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 11:19:14 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9RFGdAr028440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Oct 2010 11:16:44 -0400
In-Reply-To: <20101027150314.GB1136@kytes>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=8
	Fuz1=8 Fuz2=8
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9RFGdAr028440
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288797421.02592@tCJqe/0KhbLInmHK2gNSog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160087>


On Wed, 2010-10-27 at 20:33 +0530, Ramkumar Ramachandra wrote:
> Hi,
> 
> Ramkumar Ramachandra writes:
> > From a863e58d240956191c2fa9cbe992aaca5786730b Mon Sep 17 00:00:00 2001
> > From: Ramkumar Ramachandra <artagnon@gmail.com>
> > Date: Tue, 19 Oct 2010 22:42:05 +0530
> > Subject: [PATCH] Documentation: Consistently use the hyphenated "remote-tracking"
> > 
> > Replace instances of the term "remote tracking" with "remote-tracking"
> > in the documentation for clarity.
> > 
> > Reported-by: Thore Husfeldt <thore.husfeldt@gmail.com>
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> 
> and
> 
> > From 7422c2af1ef40c922d8f628715ad96172e4a5734 Mon Sep 17 00:00:00 2001
> > From: Ramkumar Ramachandra <artagnon@gmail.com>
> > Date: Tue, 19 Oct 2010 23:16:04 +0530
> > Subject: [PATCH] UI: Don't say "working directory" when we really mean "working tree"
> > 
> > While in some places "working directory" is used to refer to the
> > (current) working directory, it's incorrectly used in places where Git
> > actually means "working tree" or worktree. Weed out and replace these
> > instances in the UI.
> > 
> > Reported-by: Thore Husfeldt <thore.husfeldt@gmail.com>
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> 
> Junio: Are these patches suitable for inclusion?
> 
> -- Ram

Ram,
Matthieu has been working on a more comprehensive set of documentation
patches--which I'm pretty sure include all of the changes you just
mentioned.


-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
