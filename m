From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Windows & executable bit
Date: Tue, 18 Aug 2009 12:14:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181213590.4680@intel-tinevez-2-302>
References: <45321.77.61.241.211.1250588523.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Tue Aug 18 12:14:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdLiO-00065C-GM
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 12:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758613AbZHRKOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 06:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758609AbZHRKOr
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 06:14:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:58730 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753746AbZHRKOq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 06:14:46 -0400
Received: (qmail invoked by alias); 18 Aug 2009 10:14:46 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp022) with SMTP; 18 Aug 2009 12:14:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CJlwLbSoCHp6ZeI+q74yFeHyb0GpN5HYbtgzb3n
	atltGILneCOapD
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <45321.77.61.241.211.1250588523.squirrel@hupie.xs4all.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126369>

Hi,

On Tue, 18 Aug 2009, Ferry Huberts wrote:

> after a checkout the status of SQC.sh is always 'modified' and we can't 
> convince git to reset it. I actually succeeded _once_ but can not 
> remember how I did it. The file is _always_ dirty.
> 
> Is this a bug?
> 
> I have to note that when I re-clone the repo I don't have the problem. 
> So it seems to be somewhere in the 'update the working copy' code?

git config trust.fileMode false

Ciao,
Dscho
