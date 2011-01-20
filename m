From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] Introduce new configuation option to override committer information
Date: Thu, 20 Jan 2011 13:52:01 +0100
Message-ID: <201101201352.01874.trast@student.ethz.ch>
References: <igadki$4tb$2@dough.gmane.org> <1294568989-5848-1-git-send-email-artagnon@gmail.com> <ih95il$62b$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Ramkumar Ramachandra <artagnon@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 13:52:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pftzl-0005cS-Nb
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 13:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570Ab1ATMwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 07:52:06 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:27640 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755412Ab1ATMwE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 07:52:04 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 20 Jan
 2011 13:51:40 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 20 Jan
 2011 13:52:02 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <ih95il$62b$2@dough.gmane.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165311>

Stephen Kelly wrote:
> 
> Is this patch going to become part of git, or is it in already?
> 
> If not it will probably just get lost because there is no issue tracker.

Discussion stalled without an agreement that any patch proposed is
"good", so if it ends here it will be dropped.

You could probably help getting closer to a solution by:

* Not dropping Cc's all the time.  I saw this email just by chance.

* Stating *why* this cannot be solved in any other way on the KDE
  end.  So far you only said

  > > Is it impossible to fix this on the KDE side?  I would think a
  > > many-to-one mapping from committer identities to bugzilla account
  > > names could be a useful thing to have in any case.
  > 
  > I asked that before coming here, and apparently that is not possible.

  My gut feeling is that a footer line in the commit along the lines
  of

    Bugzilla-Id: Registered Name <registered.email@example.com>

  would work.  I suspect others have a similar feeling.  A good case
  why this is not a feasible solution for (presumably) border cases
  like you would help get rid of it.

* Replying to e.g.

    http://mid.gmane.org/201101111542.15185.trast@student.ethz.ch

  with (ideally better) ideas of what the semantics should be.  My
  assessment is that it either conflicts with user expectations or
  with established git-config mechanisms of how the various files
  override each other.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
