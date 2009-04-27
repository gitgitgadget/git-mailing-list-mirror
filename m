From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t3702-add-edit.sh failure in next
Date: Mon, 27 Apr 2009 18:13:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904271812180.7741@intel-tinevez-2-302>
References: <e2b179460904270812t3fa159f1ja3b06905d9effebe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 18:13:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyTSN-0003j3-Fz
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 18:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbZD0QNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 12:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755073AbZD0QNO
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 12:13:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:34747 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754918AbZD0QNO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 12:13:14 -0400
Received: (qmail invoked by alias); 27 Apr 2009 16:13:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp007) with SMTP; 27 Apr 2009 18:13:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/j9ggng63jukzCIbyrllQDZ/IJZtOBmvS5+9bO0C
	hOOiXl/Ne/CgRU
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <e2b179460904270812t3fa159f1ja3b06905d9effebe@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117684>

Hi,

On Mon, 27 Apr 2009, Mike Ralphson wrote:

> I'm seeing a reproducible failure in t3702 on AIX 5.3, shell set to
> bash (v2.05b)
> 
> The 'test_cmp orig-patch expected-patch' is seeing this diff:
> 
> 2c2
> < index b9834b5..52aff4c 100644
> ---
> > index b9834b5..0b8f197 100644

Could you send me the output of

	cd t/trash\ directory.t3702* &&
	git show 0b8f197 > file.txt

?

Thanks,
Dscho
