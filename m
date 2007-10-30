From: "Mike Snitzer" <snitzer@gmail.com>
Subject: Re: Problem with git-cvsimport
Date: Tue, 30 Oct 2007 17:15:18 -0400
Message-ID: <170fa0d20710301415w40305533o8332419e3b05ece3@mail.gmail.com>
References: <470B491F.9020306@jentro.com>
	 <200710091447.50501.wielemak@science.uva.nl>
	 <470B8049.1090308@samba.org>
	 <47065A5D-D170-4D11-A802-85376F97F8D2@orakel.ntnu.no>
	 <470C3A3A.2070809@alum.mit.edu>
	 <F1176033-1C6E-43F3-9F47-3BDD5EC88A14@orakel.ntnu.no>
	 <170fa0d20710301306o6b3798f9k72615eb811d871f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eyvind Bernhardsen" <eyvind-git-list@orakel.ntnu.no>,
	"Thomas Pasch" <thomas.pasch@jentro.com>, git@vger.kernel.org,
	"Jan Wielemaker" <wielemak@science.uva.nl>,
	"Gerald (Jerry) Carter" <jerry@samba.org>,
	dev <dev@cvs2svn.tigris.org>
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:15:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImyQx-0002A6-CJ
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 22:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbXJ3VPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 17:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbXJ3VPV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 17:15:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:45459 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbXJ3VPU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 17:15:20 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1212497wra
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2U29ybctYyurjTPnsUIJ2t2sL9RjoEbRp3XamrxecM8=;
        b=YzTSVuF7K4lsV5HtKUwuoed4hD9vZ2xKFhv4LcqoSZEb/ItYHBnMBEbLcnfDiZG8VYF8UK1C3ilWDkYGfNjs7aswXcYgARpgnkVgbxKcX2YG/v0dLSUbGTev/lryt9QwkhCxrg8hxxujYLR1c/qvV18WXgOBhkmnnHp1UWFKYUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z10AtI8FRJKe7sx8zSw+JhwGWoQc69blgy1uMHYWw6C4tseq6/3CoRc+1WnK+R9iLoUaJIJHa2Xz7Y9Q2XWJ6hrw3VOafMMzq+8G4cztmkZwizjQMXrg5a5DB4Zwk4ajuK4cdx6S2Qy+779a2MtJ/3i2doMqGwNeLDdrVp2c56s=
Received: by 10.142.113.17 with SMTP id l17mr1905796wfc.1193778918416;
        Tue, 30 Oct 2007 14:15:18 -0700 (PDT)
Received: by 10.142.222.3 with HTTP; Tue, 30 Oct 2007 14:15:18 -0700 (PDT)
In-Reply-To: <170fa0d20710301306o6b3798f9k72615eb811d871f2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62758>

On 10/30/07, Mike Snitzer <snitzer@gmail.com> wrote:
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

After reading the fairly recent "cvs2svn conversion directly to git
ready for experimentation" thread it is clear that its doable but
hasn't been done (seeing as you were looking for volunteers to do it).

Sorry for the noise,
Mike
