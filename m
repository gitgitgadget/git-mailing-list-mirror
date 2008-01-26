From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 8/9] Use git diff instead of diff in t7201
Date: Fri, 25 Jan 2008 19:11:18 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801251910170.13593@iabervon.org>
References: <alpine.LNX.1.00.0801251824010.13593@iabervon.org> <7v1w855ugx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 01:11:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIYeG-0002x8-KU
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 01:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbYAZALV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 19:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbYAZALV
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 19:11:21 -0500
Received: from iabervon.org ([66.92.72.58]:54846 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbYAZALU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 19:11:20 -0500
Received: (qmail 5703 invoked by uid 1000); 26 Jan 2008 00:11:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Jan 2008 00:11:18 -0000
In-Reply-To: <7v1w855ugx.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71758>

On Fri, 25 Jan 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > If the test failed, it was giving really unclear ed script
> > output. Instead, give a diff that sort of suggests the problem.
> 
> Hmm.  I'd actually prefer using "diff -u" instead.

Should I change the 4 places that currently use "git diff" on a pair of 
filenames to "diff -u"? All 6 places should match, surely.

	-Daniel
*This .sig left intentionally blank*
