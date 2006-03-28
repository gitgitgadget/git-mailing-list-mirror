From: Paul Mackerras <paulus@samba.org>
Subject: Re: Gitk strangeness..
Date: Tue, 28 Mar 2006 15:31:11 +1100
Message-ID: <17448.48143.764989.649462@cargo.ozlabs.ibm.com>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
	<17448.40941.256361.866229@cargo.ozlabs.ibm.com>
	<7vr74nmg7e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 06:32:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO5sO-0001bH-RM
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 06:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWC1Ebc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 23:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWC1Ebc
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 23:31:32 -0500
Received: from ozlabs.org ([203.10.76.45]:27265 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751222AbWC1Ebc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 23:31:32 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 184A867A3D; Tue, 28 Mar 2006 15:31:31 +1100 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr74nmg7e.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18108>

Junio C Hamano writes:

> I might be off the mark, but are you thinking about something
> like the attached patch?

The thing is that I need to know when I have seen the last child of
the boundary parent, because I only want to draw the open-circle
commit after I have drawn all its children.

Would it be possible to put the '-' in only for the last child that
has that parent?

Paul.
