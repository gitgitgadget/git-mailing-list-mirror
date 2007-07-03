From: "Patrick Doyle" <wpdster@gmail.com>
Subject: Re: How to create & switch to a branch after changes have already been made?
Date: Tue, 3 Jul 2007 10:04:22 -0400
Message-ID: <e2a1d0aa0707030704r45769fdaw2413a4cad19be935@mail.gmail.com>
References: <e2a1d0aa0707021918mb335856j278b3128203a793a@mail.gmail.com>
	 <e2a1d0aa0707021949k181f9042j26ebd124f61ca1ae@mail.gmail.com>
	 <Pine.LNX.4.64.0707031210020.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 16:04:29 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5izS-0000Oe-CU
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 16:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbXGCOEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 10:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbXGCOEY
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 10:04:24 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:47925 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbXGCOEX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 10:04:23 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2767514wah
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 07:04:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pFrTQKqNxgFmB7cROc4VUsE4STktYWB75hejLf95cvEU5zsdDIm83Y3rtxjt9QlVyAN7jSOvCfbzJUwFLv0BLOMNAISATs+sl8BgpxUGU4s59v2BvBj7JjGSYEX74yJOHFeOlxVIw6ZkJsXHSKkZXmTgoMRfGLBriMcZ8kZM2KM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OE6SisrAo+4UvoHDKTMhbDTimwKAc3dsfnpx4Gg/UqH1pkoziEiaW69Iwr/adJtiXjZcpFlbjDVK/yy6RR8d/XuIIaPsmAhzsJgOibuPBHODaDVjx4WVzh87UZkDjey3HxBUypYunk+mxr3pe3V0y44gDptb3E3VvghqxOwpE/w=
Received: by 10.115.79.1 with SMTP id g1mr6215766wal.1183471462779;
        Tue, 03 Jul 2007 07:04:22 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Tue, 3 Jul 2007 07:04:22 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707031210020.4071@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51495>

The real problem was that I did a

$ git-mv somefile somefile.new

and then created a new version of "somefile".  When I temporarily
renamed it, all of the given suggestions worked.  Thanks.

--wpd
