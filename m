From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Problem with git-cvsimport
Date: Tue, 30 Oct 2007 22:44:48 +0100
Message-ID: <200710302244.50034.robin.rosenberg.lists@dewire.com>
References: <470B491F.9020306@jentro.com> <F1176033-1C6E-43F3-9F47-3BDD5EC88A14@orakel.ntnu.no> <170fa0d20710301306o6b3798f9k72615eb811d871f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Michael Haggerty" <mhagger@alum.mit.edu>,
	"Eyvind Bernhardsen" <eyvind-git-list@orakel.ntnu.no>,
	"Thomas Pasch" <thomas.pasch@jentro.com>, git@vger.kernel.org,
	"Jan Wielemaker" <wielemak@science.uva.nl>,
	"Gerald (Jerry) Carter" <jerry@samba.org>,
	dev <dev@cvs2svn.tigris.org>
To: "Mike Snitzer" <snitzer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:42:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imyr7-0001sV-Jw
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 22:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbXJ3Vm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 17:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbXJ3Vm1
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 17:42:27 -0400
Received: from [83.140.172.130] ([83.140.172.130]:15471 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753196AbXJ3Vm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 17:42:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DB504A149BD;
	Tue, 30 Oct 2007 22:33:33 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02819-02; Tue, 30 Oct 2007 22:33:33 +0100 (CET)
Received: from [10.9.0.10] (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id 4DAF18026CE;
	Tue, 30 Oct 2007 22:33:33 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <170fa0d20710301306o6b3798f9k72615eb811d871f2@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62759>

tisdag 30 oktober 2007 skrev Mike Snitzer:
> On 10/10/07, Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no> wrote:
> ...
> >
> > Thanks for making cvs2svn the best CVS-to-git conversion tool :)  Now
> > if it would only support incremental importing...
> 
> Michael,
> 
> I second this question: is there any chance incremental importing will
> be implemented in cvs2svn?
> 
> I've not used cvs2svn much and when I did it was for svn not git; but
> given that git-cvsimport is known to mess up your git repo (as Eyvind
> pointed out earlier) there doesn't appear to be any reliable tools to
> allow for incrementally importing from cvs to git.
> 
> Are others using a tool for reliably importing from cvs to git?

I use fromcvs which is *very* fast, and quite memory conservative compared to 
the others and seems reliable so far (six months). It probably breaks on 
exotic variants of branches though, but I don't have those / don't care about 
them.

Do not push into the same repo fromcvs works on. I don't understand why, but I 
pushed once and *poof* the conversion went bad. 

Drawbacks, more dependencies and access to the rcs files is required and tags 
are not converted.

-- robin
