From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 06/21] Refactor tag name verification loop to use index 'i' instead of incrementing pointer 'tag_line'
Date: Sat, 9 Jun 2007 23:26:13 +0200
Message-ID: <81b0412b0706091426x5cc496aft788376872fc56995@mail.gmail.com>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
	 <200706090210.36270.johan@herland.net>
	 <200706090215.05318.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:26:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8Rs-0006wb-Ox
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbXFIV0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbXFIV0P
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:26:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:61468 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbXFIV0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:26:14 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1201929ugf
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 14:26:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QrgoFJvWlJbiAvS6mXEM3wqNbCbopjcuvb0dGIo0b85OKAP/fNlDMAmaRKHfaEmBnO/6dgvDHVpfh5GB24HXTtQFdVihYYqQVnO+DMyhGAbNy/+nmlrvdoVWmnCNkIDu97XnpgW10dmnVEEigssCtQhZJuWur/n5Cf8nz6dSih0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aeH5+cEVT9/v/aFcUBeeMSP3vGyQgGjiZYWmpLr83ZBei00rUG/fAc1PsICRRIvDFSZ5/5JmapFJckeusoXfPmhdUYw1G3MX51NQf4HXOPn4Qqd6XnC30YicSwIkJjcZnjrsSdsWDXCAQucvd3gG6SJUDoxj/1N+V7H4+mGwAsI=
Received: by 10.78.21.7 with SMTP id 7mr1672667huu.1181424373117;
        Sat, 09 Jun 2007 14:26:13 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Sat, 9 Jun 2007 14:26:13 -0700 (PDT)
In-Reply-To: <200706090215.05318.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49616>

On 6/9/07, Johan Herland <johan@herland.net> wrote:
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  mktag.c |   29 ++++++++++++++++-------------
>  1 files changed, 16 insertions(+), 13 deletions(-)

What is this change good for?
How did you justify the type selection for your
loop index variable?

IOW,  the patch looks very useless.
