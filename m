From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Intensive rename detection
Date: Mon, 3 Nov 2008 20:23:54 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811032022580.3419@nehalem.linux-foundation.org>
References: <216e54900811031717j70669868p3c7503357ceb5138@mail.gmail.com> <216e54900811031718o4cc81294sc0c32be1e71b9372@mail.gmail.com> <alpine.LFD.2.00.0811032021210.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 05:25:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxDTj-00026Y-0B
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 05:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbYKDEX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 23:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbYKDEX6
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 23:23:58 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51857 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752740AbYKDEX5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 23:23:57 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA44NsQl023340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Nov 2008 20:23:56 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA44NsDB000528;
	Mon, 3 Nov 2008 20:23:54 -0800
In-Reply-To: <alpine.LFD.2.00.0811032021210.3419@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.439 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100031>



On Mon, 3 Nov 2008, Linus Torvalds wrote:
> 
> You could try adding
> 
> 	[diff]
> 		renamelimit=0
> 
> to your ~/.gitconfig file. It can be quite expensive though.

Oh, and obviously Junio is right that some create/deletes won't be seen as 
renames anyway, if you changed enough of the file and/or if the files in 
question are so small that they end up being considered rewrites just 
because of that.

		Linus
