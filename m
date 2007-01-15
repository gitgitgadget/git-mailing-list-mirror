From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 09:37:24 -0300
Message-ID: <200701151237.l0FCbOYK007378@laptop13.inf.utfsm.cl>
References: <spearce@spearce.org>
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:33:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVn-0000Pq-2z
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:47 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9z-0003eK-4m
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbXAOMhf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 07:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbXAOMhf
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 07:37:35 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58025 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932289AbXAOMhe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 07:37:34 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0FCbOTS026286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jan 2007 09:37:24 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0FCbOYK007378;
	Mon, 15 Jan 2007 09:37:24 -0300
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: Message from "Shawn O. Pearce" <spearce@spearce.org> 
   of "Mon, 15 Jan 2007 05:15:29 CDT." <20070115101529.GB12257@spearce.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 15 Jan 2007 09:37:24 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2451/Mon Jan 15 07:27:30 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36842>

Shawn O. Pearce <spearce@spearce.org> wrote:
> Andy Parkins <andyparkins@gmail.com> wrote:

[...]

> > The more I think about it, the more it could be a reasonable question.
> > In my own repository I can obviously create whatever commits i like,
> > claiming them to be from whomever I like just by altering a few config
> > settings.  If I put a few of those in my own repository and then
> > managed to persuade Junio to pull from me - wouldn't I have faked
> > commits from another developer? However, I wouldn't be able to fake a
> > gpg signature.

[...]

> What I'm actually doing in one particular environment is checking
> the committer string against a database of known committer strings
> associated with the current UNIX uid.  My update hook[*1*] performs
> a `git log --pretty=raw $3 --not --all` query to determine any
> commits which are coming in as part of this push and which are not
> already referenced by an existing head or tag in this repository.
> For each of those the committer line *must* match one stored in
> the allowed-committers file for the current user, as these are
> brand new commits being introduced to the repository.

This only covers the "pure star" (centralized, CVS-like) topology: Each one
only pushes their own changes, nobody collects changes from others and
pushes the sum.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
