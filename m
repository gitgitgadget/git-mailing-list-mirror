From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special
 case
Date: Fri, 4 Sep 2009 12:34:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909041232500.4605@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 12:35:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjW8L-0006Af-Ks
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845AbZIDKe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755793AbZIDKe7
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:34:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:55308 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755783AbZIDKe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:34:58 -0400
Received: (qmail invoked by alias); 04 Sep 2009 10:34:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 04 Sep 2009 12:34:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bnmwAjueb+iazDzrXXeIWRUzzdmJmJgaTRYdg9o
	oWlrIsmRlzLUFz
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127706>

Hi,

On Thu, 3 Sep 2009, Daniel Barkalow wrote:

> Instead of trying to make http://, https://, and ftp:// URLs indicative 
> of some sort of pattern of transport helper usage, make them a special 
> case which runs the "curl" helper, and leave the mechanism by which 
> arbitrary helpers will be chosen entirely to future work.

I have to admit that this does not convince me at all.

The special case is "http://" and "https://" which might indicate foreign 
VCS repositories.

In all other cases, I am afraid that you are complicating the glove.

Remember: the whole purpose of the "foreign VCS" helpers is user 
convenience.

Ciao,
Dscho
