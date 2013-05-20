From: John Keeping <john@keeping.me.uk>
Subject: Re: git-submodule nested subrepo bug (Segmentation fault)
Date: Mon, 20 May 2013 11:29:26 +0100
Message-ID: <20130520102925.GM27005@serenity.lan>
References: <CAAObgf9RNyVOYD00ki347KBqMWoFA3U7-YM3DnLK4yu62SozSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Kirill Berezin <enelar@develop-project.ru>
X-From: git-owner@vger.kernel.org Mon May 20 12:29:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeNLX-00025z-37
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 12:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507Ab3ETK3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 06:29:35 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:43422 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab3ETK3e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 06:29:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id EC1A36064FD;
	Mon, 20 May 2013 11:29:33 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rMWBzNtgsCpq; Mon, 20 May 2013 11:29:32 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 24D8519800C;
	Mon, 20 May 2013 11:29:32 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id C9532161E432;
	Mon, 20 May 2013 11:29:31 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eRkK5tPDYbCb; Mon, 20 May 2013 11:29:31 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4DB93161E4B1;
	Mon, 20 May 2013 11:29:27 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAAObgf9RNyVOYD00ki347KBqMWoFA3U7-YM3DnLK4yu62SozSQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224953>

On Mon, May 20, 2013 at 09:32:21AM +0400, Kirill Berezin wrote:
> When you trying to add submodule, that already has submodule, it craches.
> For example you could try: git clone --recursive
> http://github.com/Exsul/al_server

Which version of Git were you using?  I was not able to reproduce this
with 1.8.3-rc3.
