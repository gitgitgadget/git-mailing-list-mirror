From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH RFC] Move all dashed form git commands to libexecdir
Date: Tue, 27 Nov 2007 15:12:48 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271511091.27959@racer.site>
References: <20071127150229.GA14859@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-717540316-1196176368=:27959"
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 16:14:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix28Q-0003sg-VM
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 16:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758840AbXK0PM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 10:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758827AbXK0PMz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 10:12:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:38176 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758786AbXK0PMy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 10:12:54 -0500
Received: (qmail invoked by alias); 27 Nov 2007 15:12:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 27 Nov 2007 16:12:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wGOdfYxMwZA4Zgdsd2yQF8qERZy8O1cZtW1ByVb
	6W0NjRz5wmstTJ
X-X-Sender: gene099@racer.site
In-Reply-To: <20071127150229.GA14859@laptop>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66225>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-717540316-1196176368=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 27 Nov 2007, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/config.mak.in b/config.mak.in

I don't use configure, and don't expect distros to use it either.  Maybe 
you want to change Makefile first, so that the hard-core "next" followers 
test it first?  Then, when everything is worked out and deemed to be 
stable, Junio can merge it to "master", and we can adjust the rpm spec and 
bug packagers to change their setup?

Ciao,
Dscho
---1463811741-717540316-1196176368=:27959--
