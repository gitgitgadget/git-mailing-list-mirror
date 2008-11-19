From: Mark Burton <markb@ordern.com>
Subject: Re: Git commit won't add an untracked file given on the command
 line
Date: Wed, 19 Nov 2008 14:41:39 +0000
Organization: Order N Ltd.
Message-ID: <20081119144139.602f3334@crow>
References: <20081118211237.234d8035@crow>
	<200811182227.20076.fge@one2team.com>
	<20081118214730.005fc72d@crow>
	<alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
	<20081119095452.3018d2de@crow>
	<alpine.DEB.1.00.0811191226530.30769@pacific.mpi-cbg.de>
	<7vd4grsveo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 15:43:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2oGw-0001PZ-KM
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 15:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbYKSOl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 09:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbYKSOl7
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 09:41:59 -0500
Received: from c2bthomr14.btconnect.com ([213.123.20.132]:4770 "EHLO
	c2bthomr14.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbYKSOl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 09:41:58 -0500
Received: from crow.ordern.com (host86-128-20-200.range86-128.btcentralplus.com [86.128.20.200])
	by c2bthomr14.btconnect.com
	with ESMTP id BXV88742;
	Wed, 19 Nov 2008 14:41:40 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 2BE18190CA9;
	Wed, 19 Nov 2008 14:41:40 +0000 (GMT)
In-Reply-To: <7vd4grsveo.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr14.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090203.492425A7.004A,ss=1,fgs=0,
	ip=86.128.20.200,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101348>


Hi,

> > That's just impossible.  You cannot create a tree object, let alone a 
> > commit object, without touching the index (AKA staging area).
> 
> I do not think Mark really _means_ "not in the index".
> 
> The wish is more like "I want to let git know that I am interested in this
> path, but I'm not ready to say what exact content I want for that path in
> the next commit, not just yet".
> 
> I do not think that is an unreasonable wish.  On the other hand, it is
> unreasonable for anybody to insist that we satisfy the wish without
> touching the index.  The index is the most natural place to do that.
> 
> We have a half (probably a quarter) of what we need for that implemented
> already, by the way.

Sorry, poor choice of words on my part - you have to remember my
viewpoint is one of user more than developer.

My wish was really just based on the advertised behaviour that
specifying a file on the command line would commit the contents of that
file while leaving the index intact. Whether the index was temporarily
used/altered during the execution of the commit didn't cross my mind.

Hey, it's not a big deal and with the accepted patch to the
documentation it need not take any more of anyone's time.

Cheers,

Mark
