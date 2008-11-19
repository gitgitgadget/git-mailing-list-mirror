From: Mark Burton <markb@ordern.com>
Subject: Re: Git commit won't add an untracked file given on the command
 line
Date: Wed, 19 Nov 2008 23:30:27 +0000
Organization: Order N Ltd.
Message-ID: <20081119233027.17687dd5@crow>
References: <20081118211237.234d8035@crow>
	<200811182227.20076.fge@one2team.com>
	<20081118214730.005fc72d@crow>
	<alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
	<20081119095452.3018d2de@crow>
	<alpine.DEB.1.00.0811191226530.30769@pacific.mpi-cbg.de>
	<7vd4grsveo.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0811191247560.19665@iabervon.org>
	<7v7i6zs4ay.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 00:32:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2wWh-0007Dn-Sc
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 00:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbYKSXaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 18:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbYKSXai
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 18:30:38 -0500
Received: from c2bthomr09.btconnect.com ([213.123.20.127]:7582 "EHLO
	c2bthomr09.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbYKSXah (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 18:30:37 -0500
Received: from crow.ordern.com (host86-128-20-200.range86-128.btcentralplus.com [86.128.20.200])
	by c2bthomr09.btconnect.com
	with ESMTP id CCN19883;
	Wed, 19 Nov 2008 23:30:28 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id CE071190CA9;
	Wed, 19 Nov 2008 23:30:27 +0000 (GMT)
In-Reply-To: <7v7i6zs4ay.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr09.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090202.4924A197.0074,ss=1,fgs=0,
	ip=86.128.20.200,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101382>


Hi,

> Allowing what Mark wants without any explicit user customization will be a
> disaster to the end user experience.

If the ability to commit a currently untracked file/tree whilst
preserving the index is really worth having (and that's debatable, as
the git user community has survived until now without that capability)
then another option (say, -O) could be added to git-commit that does
what -o does but allows untracked files/trees to be specified - that
way, the current behaviour would remain unchanged and the above
mentioned disaster averted.

Cheers,

Mark
