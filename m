From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git: Wrong parsing of ssh urls with IPv6 literals ignores port
Date: Tue, 12 Jun 2012 16:00:03 -0500
Message-ID: <20120612210003.GA16816@burratino>
References: <20111022001704.3115.87464.reportbug@hejmo>
 <20120610090516.GA30177@burratino>
 <4FD78EA0.2090306@lsrfire.ath.cx>
 <20120612202953.GG9764@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo =?utf-8?Q?Tr=C3=A1pani?= <etrapani@gmail.com>,
	git@vger.kernel.org, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 12 23:01:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeYCM-0005th-Qv
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 23:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab2FLVAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 17:00:15 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:39893 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab2FLVAL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 17:00:11 -0400
Received: by gglu4 with SMTP id u4so3842728ggl.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 14:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SBwHOf+jg/Hv8SQYz2+BE1kHFW2mBr8YDHwHSZ4cxGc=;
        b=P7J/wysppBuWtv7xiEpcbSFzGWCzBzBeWBzHbo6v9ydLqcADfXJ0B1V7nM1bVeHdGF
         0FbxZALm3bwvIyyFQVDO+fSQGO7mstYV8Ce0C6U+Ab3hKRrtC823a8chrGFSCDWf34C4
         3VA+TPSFKISdEUcccqILh2bCHMBvUr9Vr1StO286XkROGhrIGp7Z0JJ+Cabr9lZ/Ljlb
         tPiV+3DnCDBBSpP9ER1gfzkBOrg0G/eBd54cLzTb0xkgxuf6YaHVn0/4wm5YMkjTqHTO
         1/FG7QDHimTlEP1WgvcISwl7qQaKUeBT8J6ftgR3KqbEWNwh+OxI60Bxks6DmW5M9ika
         WvmQ==
Received: by 10.236.187.2 with SMTP id x2mr3944509yhm.42.1339534810987;
        Tue, 12 Jun 2012 14:00:10 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id j34sm925679ani.14.2012.06.12.14.00.09
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 14:00:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120612202953.GG9764@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199853>

Jonathan Nieder wrote:
> Ren=C3=A9 Scharfe wrote:

>> How about this instead?
>
> Looks good to me.

Oh, hold on a second.  Won't this get confused by

	ssh://[::1]/foo/bar/baz:80/qux

?
