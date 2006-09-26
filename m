From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 26 Sep 2006 10:04:32 -0700 (PDT)
Message-ID: <20060926170432.820.qmail@web31812.mail.mud.yahoo.com>
References: <7vhcyvrvab.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 19:04:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSGMG-0005aL-Oz
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 19:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWIZREd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 13:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWIZREd
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 13:04:33 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:13474 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932147AbWIZREd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 13:04:33 -0400
Received: (qmail 822 invoked by uid 60001); 26 Sep 2006 17:04:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=O/Ce9Bo0DtluTARuHI+XRGmElFQBcZfVPBPLAaXlqzMbEkq/2XkUECDXZRu6bR3RK5Qf2IBSi8MSj5YSRpqx6v/U59pYSXZuF+sK8KOHc/pVoU5XoVYW0nRNCgWpFHYwrPWmXDUsEQPVMtHriYQ2jq+BYOIbbiXuZPCzc6wS7lI=  ;
Received: from [71.80.233.118] by web31812.mail.mud.yahoo.com via HTTP; Tue, 26 Sep 2006 10:04:32 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhcyvrvab.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27802>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Binary and non-binary blobs:
> >
> > The "list" table element of tree view is identical
> > to the "blob" link part of the link table element.
> > I.e. clicking on "blob" is identical to clicking on
> > the entry itself.
> 
> Then perhaps we can lose tree link for the same reasoning?

Indeed, I think so too.

    Luben
