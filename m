From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: bad line length character: fata
Date: Mon, 17 May 2010 10:16:01 +0200
Message-ID: <4BF0FB41.5000500@drmicha.warpmail.net>
References: <loom.20100516T095148-64@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Constable <markc@renta.net>
X-From: git-owner@vger.kernel.org Mon May 17 10:16:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODvUW-00073C-J1
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 10:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111Ab0EQIPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 04:15:55 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37064 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751830Ab0EQIPy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 04:15:54 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 619B1F62B4;
	Mon, 17 May 2010 04:15:54 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 17 May 2010 04:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=/CnH5iCil0P2ba86eAQoxDPuOsg=; b=D5C/aa1E9HSDm/15tQvw2Fc5ohFyg+80XjahLzYyl/I9V3lJ7pxNatwthpDkI2OFgKl36NcYEKVSYGfApEMBVBURpgMcSUF7r17o6aGCNfXeaPbHjgotBp3BR3+HaqtKLvrF3A7NQXUFO3rNzUapJDK6hqLqDDsEfYwl5vx12PM=
X-Sasl-enc: TZxEwR+GBhCMWXWcXjmo5YRw5MVEsd1otsvHkjYm9mNH 1274084154
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CA68D557AD;
	Mon, 17 May 2010 04:15:53 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <loom.20100516T095148-64@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147217>

Mark Constable venit, vidit, dixit 16.05.2010 09:53:
> What does this error message indicate when doing a git pull?
> 
> fatal: protocol error: bad line length character: fata
> 
> Git v1.7.1 both ends.

This is funny. Git tries to read a 4 digit (hex) line length according
to the git protocol, and what it got from the remote end apparently was
a "fatal..." at a place where there usually is no textual error report.

Can you reproduce this and describe the circumstances? For example, what
is the transport (ssh, http), what are the surrounding messages, does it
happen for every client?

Michael
