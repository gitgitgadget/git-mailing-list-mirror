From: Mark Burton <markb@ordern.com>
Subject: Re: [PATCH] git-gui: Teach start_push_anywhere_action{} to notice
 when remote is a mirror.
Date: Tue, 2 Dec 2008 16:31:04 +0000
Organization: Order N Ltd.
Message-ID: <20081202163104.29306f22@crow>
References: <20081202151502.3f30ced4@crow>
	<20081202153007.GJ23984@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 17:32:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7YAo-0002rv-46
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 17:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687AbYLBQbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 11:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755681AbYLBQbJ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 11:31:09 -0500
Received: from c2bthomr06.btconnect.com ([213.123.20.124]:22555 "EHLO
	c2bthomr06.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661AbYLBQbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 11:31:08 -0500
Received: from crow.ordern.com (host86-128-197-104.range86-128.btcentralplus.com [86.128.197.104])
	by c2bthomr06.btconnect.com
	with ESMTP id CFR55646;
	Tue, 2 Dec 2008 16:31:04 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 529BD190C96;
	Tue,  2 Dec 2008 16:31:04 +0000 (GMT)
In-Reply-To: <20081202153007.GJ23984@spearce.org>
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr06.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A010203.493562C9.0115,ss=1,fgs=0,
	ip=86.128.197.104,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102154>


Hi Shawn,

> Yea, it is a chunk of work.  I thought about trying to do it myself
> right now, but realized I won't be able to do it in 15 minutes and
> gave up.  :-)

Well, when you/someone looks at updating the push dialog you could
consider adding another checkbox that disables the refspec so that the
push uses whatever default refspec has been configured. I think that would
be a useful addition.

Cheers,

Mark
