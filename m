From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cross-Platform Version Control
Date: Tue, 12 May 2009 18:13:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905121808480.4447@intel-tinevez-2-302>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 12 18:14:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3ucF-0005ei-8d
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbZELQNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbZELQNy
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:13:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:46297 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751949AbZELQNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:13:53 -0400
Received: (qmail invoked by alias); 12 May 2009 16:13:52 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp010) with SMTP; 12 May 2009 18:13:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/B1MJmH3XBUBt5myzZI9ce6NyyH+o8PDPsdyfnTE
	c6JuLJ7aCr1CGs
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090512151403.GS30527@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118914>

Hi,

On Tue, 12 May 2009, Shawn O. Pearce wrote:

> Esko Luontola <esko.luontola@gmail.com> wrote:
> > Are there any plans on storing the encoding information of file names 
> > and commit messages in the Git repository?
> 
> Commit messages already store their encoding in an optional "encoding" 
> header if the message isn't stored in UTF-8, or US-ASCII, which is a 
> strict subset of UTF-8.
> 
> As for file names, no plans, its a sequence of bytes, but I think a
> lot of people wind up using some subset of US-ASCII for their file
> names, especially if their project is going to be cross platform.

Some context: this issue cropped up in msysGit, of course.

As to storing all file names in UTF-8, my point about Unicode being not 
necessarily appropriate for everyone still stands.

UTF-8 _might_ be the de-facto standard for Linux filesystems, but 
IMHO we should not take away the freedom for everybody to decide what they 
want their file names to be encoded as.

However, I see that there might be a need to be able to encode the file 
names differently, such as on Windows.  IMHO the best solution would be 
a config variable controlling the reencoding of file names.

For some time, it looked as if two people were interested in implementing 
something like that (Peter and Robin IIRC), but efforts have stalled.

Ciao,
Dscho
