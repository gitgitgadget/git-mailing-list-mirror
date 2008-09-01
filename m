From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: [PATCH] Git.pm: Require File::Temp 0.14 for new()
Date: Mon, 1 Sep 2008 12:21:02 +0200
Message-ID: <48BBC20E.20808@statsbiblioteket.dk>
References: <48BBB59F.9080204@statsbiblioteket.dk> <vpqvdxggpw6.fsf@bauges.imag.fr> <20080901100435.GC6555@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Petr Baudis <pasky@suse.cz>
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Mon Sep 01 12:22:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka6Y2-0003Y9-Bz
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbYIAKVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 06:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753019AbYIAKVH
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:21:07 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:14123 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753016AbYIAKVG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2008 06:21:06 -0400
Received: from [130.225.25.181] (130.225.25.181) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.291.1; Mon, 1 Sep 2008 12:21:03 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080820)
In-Reply-To: <20080901100435.GC6555@toroid.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94562>

Abhijit Menon-Sen wrote:
> File::Temp->new() was introduced in File::Temp 0.14, but 5.8.0 shipped
> with File::Temp 0.13, as pointed out by Tom G. Christensen. Since the
> dependency is optional anyway, we can require 0.14.
> 
IMHO not acceptable since RHEL3 users will not be able to use git-svn 
anymore.
Wouldn't it be possible to accomplish the same as File::Temp->New with 
the old File::Temp?

-tgc
