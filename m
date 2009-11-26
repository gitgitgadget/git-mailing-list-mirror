From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (Nov 2009, #06; Wed, 25)
Date: Thu, 26 Nov 2009 08:37:15 +0100
Message-ID: <200911260837.15377.johan@herland.net>
References: <7v8wduksgq.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911251715u661ce0aem79a4d700d552e105@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 08:37:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDYut-0004Tf-HE
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 08:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758918AbZKZHhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 02:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758174AbZKZHhO
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 02:37:14 -0500
Received: from smtp.getmail.no ([84.208.15.66]:47329 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752512AbZKZHhM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 02:37:12 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTP008HYH66CG60@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 26 Nov 2009 08:37:18 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTP00AVTH64O010@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 26 Nov 2009 08:37:18 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.11.26.72718
User-Agent: KMail/1.12.3 (Linux/2.6.31-ARCH; KDE/4.3.3; x86_64; ; )
In-reply-to: <fabb9a1e0911251715u661ce0aem79a4d700d552e105@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133774>

On Thursday 26 November 2009, Sverre Rabbelier wrote:
> Heya,
> 
> On Thu, Nov 26, 2009 at 02:03, Junio C Hamano <gitster@pobox.com> wrote:
> > * sr/vcs-helper (2009-11-18) 12 commits
> >  - Add Python support library for remote helpers
> >  - Basic build infrastructure for Python scripts
> >  - Allow helpers to report in "list" command that the ref is unchanged
> >  - Fix various memory leaks in transport-helper.c
> >  - Allow helper to map private ref names into normal names
> >  - Add support for "import" helper command
> >  - Allow specifying the remote helper in the url
> >  - Add a config option for remotes to specify a foreign vcs
> >  - Allow fetch to modify refs
> >  - Use a function to determine whether a remote is valid
> >  - Allow programs to not depend on remotes having urls
> >  - Fix memory leak in helper method for disconnect
> >
> > Replaced again, and looking good.  Perhaps Daniel has some comments?
> 
> Indeed, Johan, Daniel, is the current version good for next?

As I replied to an earlier "What's cooking" email, it all looks good to me, 
but I would really like Daniel's ACK on the transport layer parts.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
