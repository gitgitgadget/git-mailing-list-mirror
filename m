From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 20 Feb 2007 12:37:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702201235350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702191839.05784.andyparkins@gmail.com>
 <200702201021.58754.andyparkins@gmail.com> <7vabz9w270.fsf@assigned-by-dhcp.cox.net>
 <200702201057.21398.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 12:37:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJTJi-0007mm-AS
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 12:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbXBTLhv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 06:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbXBTLhv
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 06:37:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:55969 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932901AbXBTLhu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 06:37:50 -0500
Received: (qmail invoked by alias); 20 Feb 2007 11:37:49 -0000
X-Provags-ID: V01U2FsdGVkX19Ph/RbkFhPc3ivBZppOt4Lwd2+3ROITmDBjXIdS1
	uTVA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702201057.21398.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40232>

Hi,

On Tue, 20 Feb 2007, Andy Parkins wrote:

> I've never really liked "!" on strcmp() lines (but I accept that that is the 
> tradition in git) because it implies the the output of prefixcmp is boolean, 
> but it's actually ternary.

Actually, it's not even ternary, but to the return value should only be 
handled in terms of >0, ==0, <0.

Ah, and if "!" implies a boolean, then why is "!!" a common construct? 
Because "!" really does not imply a boolean.

Ciao,
Dscho
