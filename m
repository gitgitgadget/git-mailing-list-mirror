From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <carlos@cmartin.tk>
Subject: Re: rebase autosquash doesn't recognise a chain of fixups
Date: Tue, 5 Apr 2011 18:03:36 +0200
Message-ID: <20110405160336.GA20336@bee.lab.cmartin.tk>
References: <20110405154100.GC16031@bee.lab.cmartin.tk>
 <4D9B39EB.9040208@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 18:03:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q78jJ-0004c1-6O
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 18:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146Ab1DEQDj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 12:03:39 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:39962 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373Ab1DEQDi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 12:03:38 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 5149946124;
	Tue,  5 Apr 2011 18:03:26 +0200 (CEST)
Received: (nullmailer pid 20420 invoked by uid 1000);
	Tue, 05 Apr 2011 16:03:36 -0000
Content-Disposition: inline
In-Reply-To: <4D9B39EB.9040208@lyx.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170885>

On Tue, Apr 05, 2011 at 05:48:59PM +0200, Vincent van Ravesteijn wrote:
> On 5-4-2011 17:41, Carlos Mart=EDn Nieto wrote:
> >Hello,
> >
> >  Say I have the following commits:
> >
> >     5154127 fixup! fixup! one
> >     0d130d8 fixup! one
> >     0869d30 one
> >
> >because I keep executing `git commit -a --fixup HEAD`.
> >
> >Am I just too lazy and should look up the commit I want to fixup?
>=20
> I would use 'git commit --amend -a' instead if I am already sure
> that I want to squash my commit into the previous one.

 That does make more sense. I guess I was just too excited about
 discovering fixups :)

   cmn
