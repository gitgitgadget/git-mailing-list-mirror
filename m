From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Wed, 1 Mar 2006 19:06:33 +0100
Message-ID: <200603011906.33433.Josef.Weidendorfer@gmx.de>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <200603011814.43573.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0603010935201.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 19:08:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEVih-00041F-2J
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 19:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWCASGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 13:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWCASGg
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 13:06:36 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:51654 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932409AbWCASGf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 13:06:35 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id BC5902268;
	Wed,  1 Mar 2006 19:06:34 +0100 (MET)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.1
In-Reply-To: <Pine.LNX.4.64.0603010935201.22647@g5.osdl.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17001>

On Wednesday 01 March 2006 18:40, Linus Torvalds wrote:
> But if somebody does the get_sha1() magic, and Junio agrees, then I think 
> it would be a great thing to do.

Yes.

	git log origin/master..

is really not that bad. And if somebody complains about typing, git-clone
could get an option "--remote-name=o" to allow for

	git log o/master..

Josef
