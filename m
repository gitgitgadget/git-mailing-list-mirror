From: Mark Burton <markb@ordern.com>
Subject: Re: Bugs in git-gui and git-push when pushing src:dst to mirror?
Date: Tue, 2 Dec 2008 17:49:31 +0000
Organization: Order N Ltd.
Message-ID: <20081202174931.4f5c6560@crow>
References: <20081202130859.43ba54f6@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 18:50:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ZOd-0002Gd-Oy
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 18:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbYLBRte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 12:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbYLBRte
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 12:49:34 -0500
Received: from c2beaomr08.btconnect.com ([213.123.26.186]:28201 "EHLO
	c2beaomr08.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794AbYLBRtd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 12:49:33 -0500
Received: from crow.ordern.com (host86-128-197-104.range86-128.btcentralplus.com [86.128.197.104])
	by c2beaomr08.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id BIN92207;
	Tue, 2 Dec 2008 17:49:31 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 53290190C96
	for <git@vger.kernel.org>; Tue,  2 Dec 2008 17:49:31 +0000 (GMT)
In-Reply-To: <20081202130859.43ba54f6@crow>
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr08.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0204.4935752B.0291,ss=1,fgs=0,
	ip=86.128.197.104,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102165>


On Tue, 2 Dec 2008 13:08:59 +0000
Mark Burton <markb@ordern.com> wrote:

> The other issue is that although git-push did print the usage blurb,
> it didn't actually produce a message saying what it's problem was.

Ah, just twigged, 1.6.0.4 doesn't include b259f09b181c (Make push more
verbose about illegal combination of options) so the lack of error message
from push is understandable.

Cheers,

Mark
