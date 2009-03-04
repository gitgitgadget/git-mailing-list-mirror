From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why isn't hook file cloned to bared repository ?
Date: Wed, 4 Mar 2009 11:04:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903041103270.8549@intel-tinevez-2-302>
References: <856bfe0e0903032140w4d8a9415l9f7b9a0678b492cc@mail.gmail.com> <3e8340490903032213u56734301o39c9d00633410fd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1663271175-1236161076=:8549"
Cc: Emily Ren <lingyan.ren@gmail.com>, git@vger.kernel.org
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:06:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LenzO-0004AU-62
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 11:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbZCDKEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 05:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbZCDKEk
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 05:04:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:49152 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750728AbZCDKEj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 05:04:39 -0500
Received: (qmail invoked by alias); 04 Mar 2009 10:04:36 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp038) with SMTP; 04 Mar 2009 11:04:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18G39pHo3YG5+RsGvWnUZ1a40ulRxQwI/6HIwOcMh
	AM+2lSYX9in9Z9
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <3e8340490903032213u56734301o39c9d00633410fd5@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112196>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1663271175-1236161076=:8549
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 4 Mar 2009, Bryan Donlan wrote:

> On Wed, Mar 4, 2009 at 12:40 AM, Emily Ren <lingyan.ren@gmail.com> wrote:
>
> > I added file "update" in my git repository my_repo/.git/hooks/,  then
> > I run command "git clone --bare my_repo" to generate a bared
> > repository my_repo.git. But there's no update in my_repo.git/hooks.
> >
> > Do you know why ?
> 
> Because allowing code from an untrusted third-party repository to be
> executed automatically without giving a chance to examine it is not a
> very good idea from a security standpoint. In addition, hooks are
> often not of interest to the person cloning the repository. Because of
> these reasons, git clone will not copy hooks from the source
> repository (for consistency, this is the case even when the source is
> local).

I might add that hooks are not part of the repository.  They are not 
versioned, for example.

Having said that, nothing prevents you from committing a set of example 
hooks and a script to install them, and tell your users that they may 
install default hooks using that script.  I do that for one of my 
projects.

Ciao,
Dscho

--8323329-1663271175-1236161076=:8549--
