From: "franky" <yinping@kooxoo.com>
Subject: RE: Is it possible for git to support binary differencing for binary files?
Date: Fri, 12 Oct 2007 11:01:05 +0800
Message-ID: <20071012030112.024F27E6F@mail.kooxoo.com>
References: <470E633D.8060107@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "'Jean-Luc Herren'" <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Fri Oct 12 05:02:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgAmJ-0006PC-J8
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 05:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973AbXJLDBR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2007 23:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755157AbXJLDBQ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 23:01:16 -0400
Received: from mail.kooxoo.com ([60.28.194.208]:34095 "EHLO mail.kooxoo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754820AbXJLDBO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2007 23:01:14 -0400
Received: from yinping (unknown [124.42.17.129])
	by mail.kooxoo.com (Postfix) with ESMTP id 024F27E6F;
	Fri, 12 Oct 2007 11:01:09 +0800 (CST)
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcgMMLEk/66Tt1mTR5CFKh3+PIsOHgAS023Q
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
In-Reply-To: <470E633D.8060107@gmx.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60650>

git-gc works perfectly! Thanks all very much.=20

-----Original Message-----
=46rom: Jean-Luc Herren [mailto:jlh@gmx.ch]=20
Sent: Friday, October 12, 2007 1:54 AM
To: =D2=F8=C6=BD
Cc: git@vger.kernel.org
Subject: Re: Is it possible for git to support binary differencing for
binary files?

=D2=F8=C6=BD wrote:
> Hi.=20
> Storing binary files as deltas is helpful [...] So is it
> possible for git to do that as svn. This is my only pain when
> using git.

Yes, and git does this already in pack files.  Maybe you're not
seeing it because you haven't packed anything yet.  Try to run
'git gc'.

jlh
