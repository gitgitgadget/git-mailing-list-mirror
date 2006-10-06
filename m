From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Unresolved issues #4
Date: Fri, 06 Oct 2006 11:04:27 -0500
Message-ID: <1160150667.4297.53.camel@cashmere.sps.mot.com>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
	 <7vfye20xjt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 18:04:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVsBk-0001U8-G7
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 18:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWJFQEh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 12:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWJFQEh
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 12:04:37 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:48088 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751541AbWJFQEg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 12:04:36 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k96G4Yjv021965;
	Fri, 6 Oct 2006 09:04:34 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k96G4XSm017403;
	Fri, 6 Oct 2006 11:04:33 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfye20xjt.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28411>

On Fri, 2006-10-06 at 01:26, Junio C Hamano wrote:

> From: Franck Bui-Huu <vagabon.xyz@gmail.com>
> Message-ID: <450EABD0.1040102@innova-card.com>
> 
> Repeated requests against git-daemon makes it stuck
> 
> [jc: does not reproduce easily for me; has anybody seen it?]

I've not seen that behavior either.  However, I
suspect that this might be a poorly described
issue with _clients_ that are out of date.
Specifically, if a client is older than 1.4.2.1,
it shows up in the git-daemon log as just a
single "connection from <ipaddr>" line and no
actual transfer then happens, making it perhaps
appear "stuck".

jdl
