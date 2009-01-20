From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add tests for diff.color-words configuration option.
Date: Tue, 20 Jan 2009 17:54:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201748230.5159@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <200901192017.54163.bss@iguanasuicide.net> <alpine.DEB.1.00.0901201057080.3586@pacific.mpi-cbg.de> <200901201034.22478.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 17:56:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPJte-00009K-7F
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 17:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758204AbZATQyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 11:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbZATQyt
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 11:54:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:39477 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755989AbZATQyt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 11:54:49 -0500
Received: (qmail invoked by alias); 20 Jan 2009 16:54:46 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp053) with SMTP; 20 Jan 2009 17:54:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KJi9VLZxKJp+tLR70gUcfbVOrgc+ALQ+G/ZevXs
	wfj+JiwfaDEBX2
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200901201034.22478.bss@iguanasuicide.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106493>

Hi,

On Tue, 20 Jan 2009, Boyd Stephen Smith Jr. wrote:

> On Tuesday 2009 January 20 03:58:37 Johannes Schindelin wrote:
> >On Mon, 19 Jan 2009, Boyd Stephen Smith Jr. wrote:
> >> I'm not sure why the diff is crazy long.
> >
> >Because you changed things that need no changing, such as "cat > expect"
> >-> "cat > expect.blabla",
> 
> I suppose I could have gotten away with doing this differently, but I 
> did need to save off some of those results to different files because I 
> wanted to resuse the results.

Why didn't you do that, then?

	cp expect expect.for-later-use

> >and because you inserted your test instead of adding it at the end.
> 
> I put the tests in that order explicitly to test that .gitattributes 
> overrides the configuration option.

Why not just remove the .gitattributes for your second test?

It would be much clearer that you did not modify any existing tests, then.

Ciao,
Dscho
