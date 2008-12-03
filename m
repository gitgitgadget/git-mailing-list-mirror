From: Mark Burton <markb@ordern.com>
Subject: Re: gitk: 'show origin of this line' barfs if gitk run in subdir
Date: Wed, 3 Dec 2008 22:22:58 +0000
Organization: Order N Ltd.
Message-ID: <20081203222258.6db9b34e@crow>
References: <20081203205158.6b4b62c7@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 23:24:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L808z-0001oL-M3
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 23:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbYLCWXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 17:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbYLCWXM
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 17:23:12 -0500
Received: from c2bthomr06.btconnect.com ([213.123.20.124]:19386 "EHLO
	c2bthomr06.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbYLCWXM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 17:23:12 -0500
Received: from crow.ordern.com (host86-128-197-104.range86-128.btcentralplus.com [86.128.197.104])
	by c2bthomr06.btconnect.com
	with ESMTP id CFW22167;
	Wed, 3 Dec 2008 22:22:58 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id B8CC7190C96;
	Wed,  3 Dec 2008 22:22:58 +0000 (GMT)
In-Reply-To: <20081203205158.6b4b62c7@crow>
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr06.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0208.493706C3.00DF,ss=1,fgs=0,
	ip=86.128.197.104,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102295>


Hi,

I think the same problem exists with the 'run git gui blame on this
line' feature. It doesn't work when gitk is started in a subdir of the
working tree but it does work when gitk is started in the top-level
directory.

Cheers,

Mark
