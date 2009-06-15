From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] avoid NULL dereference on failed malloc
Date: Mon, 15 Jun 2009 09:49:15 +0200
Message-ID: <4A35FCFB.1080000@drmicha.warpmail.net>
References: <87hbyioayl.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 09:49:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG6wr-00082z-GB
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 09:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbZFOHtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 03:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbZFOHte
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 03:49:34 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59102 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751478AbZFOHtd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 03:49:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 249D6360E51;
	Mon, 15 Jun 2009 03:49:34 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 15 Jun 2009 03:49:34 -0400
X-Sasl-enc: bSoOYa7aMeUhdYUyaT7DlLSLM9BdPs4zPmvXqsHhFcz4 1245052173
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7DD1F2B2A4;
	Mon, 15 Jun 2009 03:49:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090609 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <87hbyioayl.fsf@meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121589>

Jim Meyering venit, vidit, dixit 14.06.2009 21:46:
> 
> * builtin-remote.c (get_one_entry): Use xmalloc, not malloc.

Learning something new with every patch... Sorry, Junio; thanks, Jim!

Michael
