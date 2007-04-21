From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/4] add mode parameter to get_sha1
Date: Sat, 21 Apr 2007 22:02:39 +0200
Message-ID: <20070421200239.GA2437@steel.home>
References: <1177158380197-git-send-email-mkoegler@auto.tuwien.ac.at>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sat Apr 21 22:02:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfLnD-0006m3-Rb
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 22:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXDUUCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 16:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbXDUUCp
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 16:02:45 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:56648 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbXDUUCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 16:02:44 -0400
Received: from tigra.home (Fcb56.f.strato-dslnet.de [195.4.203.86])
	by post.webmailer.de (klopstock mo34) (RZmta 5.6)
	with ESMTP id D074bbj3LIlcAu ; Sat, 21 Apr 2007 22:02:40 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 75883277BD;
	Sat, 21 Apr 2007 22:02:40 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 8FDF7BDDE; Sat, 21 Apr 2007 22:02:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1177158380197-git-send-email-mkoegler@auto.tuwien.ac.at>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBL0NA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45192>

Martin Koegler, Sat, Apr 21, 2007 14:26:17 +0200:
> If the mode parameter is not NULL, get_sha1 will store
> the mode of the object in it.

It looks like the number of call sites which actually use the
argument is vanishingly small compared to the number of sites
where it is set to NULL. Why don't you introduce a new function
instead, say get_sha1_and_mode, and use it for this two or three
places?
