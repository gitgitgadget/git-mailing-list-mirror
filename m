From: "franky" <yinping@kooxoo.com>
Subject: RE: Is there any plan to support partial checkout or submoudule improvement?
Date: Tue, 16 Oct 2007 19:53:08 +0800
Message-ID: <20071016115310.5FB957E6D@mail.kooxoo.com>
References: <Pine.LNX.4.64.0710161158350.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Lars Hjemli'" <hjemli@gmail.com>, <git@vger.kernel.org>
To: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 13:53:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhkzE-0004XR-Uc
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 13:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760286AbXJPLxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 07:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760182AbXJPLxO
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 07:53:14 -0400
Received: from mail.kooxoo.com ([60.28.194.208]:57501 "EHLO mail.kooxoo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759943AbXJPLxN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 07:53:13 -0400
Received: from yinping (unknown [124.42.17.129])
	by mail.kooxoo.com (Postfix) with ESMTP id 5FB957E6D;
	Tue, 16 Oct 2007 19:53:10 +0800 (CST)
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <Pine.LNX.4.64.0710161158350.25221@racer.site>
Thread-Index: AcgP5DxgXD0oTKRbSgCM8z6jQnAZ6AABg2Ig
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61150>

> [please do not top post.  Only keep the parts of the original message that
> you are responding to, and put your answers just below.  It is a matter of
> simple economy: it takes you just a couple of minutes, but spares those
> "millions" of readers the minutes to understand what you're talking about.
> In addition, it is a matter of politeness.]

Thanks for the hint, and I have corrected this.

> On Tue, 16 Oct 2007, franky wrote:
> 
> > I want a single "git-pull" to deploy a new version and a
> > single "git-reset" to back to versions before [on partial checkouts]
> 
> You are talking as if your partial checkout was a project in its own
> right.  Then make it so.  Do not use a partial checkout, but make that a
> submodule.

As I said in the first email, the submodule way suffers from the multiple
commit problem: src and bin as two submodules of project, three commits (for
the 3 dirs separately) are needed when src directory changes and compiled
binaries being put in bin directory. It's annoying to have to give 3 commit
logs.
 
franky
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
