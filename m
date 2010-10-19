From: Stephen Bash <bash@genarts.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 20:40:56 -0400 (EDT)
Message-ID: <24099087.526689.1287448856104.JavaMail.root@mail.hq.genarts.com>
References: <AANLkTikHrCoZkJHN7Bnq4tgCTAHDfy7-92YOiV=s4VD8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 02:41:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P80GN-00077U-Pw
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 02:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702Ab0JSAlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 20:41:05 -0400
Received: from hq.genarts.com ([173.9.65.1]:31764 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755223Ab0JSAlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 20:41:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 10E191E26351;
	Mon, 18 Oct 2010 20:41:03 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B8KV+Dpd-eCl; Mon, 18 Oct 2010 20:40:56 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 4FF6C1E26211;
	Mon, 18 Oct 2010 20:40:56 -0400 (EDT)
In-Reply-To: <AANLkTikHrCoZkJHN7Bnq4tgCTAHDfy7-92YOiV=s4VD8@mail.gmail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159300>

----- Original Message -----
> From: "Sverre Rabbelier" <srabbelier@gmail.com>
> To: "Jonathan Nieder" <jrnieder@gmail.com>
> Sent: Monday, October 18, 2010 2:20:43 PM
> Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
> 
> On Mon, Oct 18, 2010 at 13:13, Jonathan Nieder <jrnieder@gmail.com>
> wrote:
> > Log messages could be an annoying special case, though, since people
> > edit those a lot. Does svn store the original log message somewhere?
> > (Please forgive my ignorance). If not, I suppose downstream can
> > publish refs produced by "git replace" to cope.
> 
> From what I've heard basically all meta-data about a commit (including
> author and date!) is mutable.

The default repository configuration does not allow changes to revision properties.  But if the repository administrator sets up a pre-revprop-change hook script that exits zero then users with commit access are allowed to modify revision properties.  In the general case, it's probably best to assume all properties are mutable.

http://svnbook.red-bean.com/en/1.5/svn.ref.reposhooks.pre-revprop-change.html

Thanks,
Stephen
