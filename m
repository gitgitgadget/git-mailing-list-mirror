From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix unterminated string in set_work_tree and improve error handling
Date: Fri, 3 Aug 2007 09:23:24 +0200
Message-ID: <81b0412b0708030023m359ec79as3197deee310e87a5@mail.gmail.com>
References: <81b0412b0708022247s1116f66al1e8751f33bcae581@mail.gmail.com>
	 <7v7iodqgg9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 09:23:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGrVS-0005I9-Ii
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 09:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757783AbXHCHX1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 03:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757431AbXHCHX1
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 03:23:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:7794 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbXHCHX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 03:23:26 -0400
Received: by ug-out-1314.google.com with SMTP id j3so430685ugf
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 00:23:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WoeBdWxWIRX30XvymSOqr8BWC5kgSRbfbogTjwUGIzXFjG+S5ofwnEvCsyVmOjGdaY5gK/g+z/9BBdo403+1kNod9hUigjyqYzEIbVycEaaW1qW8yu5KjkIL4qak5KVRJk09WNLR+RKjL9Fn4fZ7BEos+sDMGOZl+XLDcKw61FE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bpyMoAq0K7igZUzAHngBba336Z+e7yg0kNQg/lVUqQIY+en/NDONkn/fSNfgpuiF91spcubX+i/LefCXXenwWOb70vmKinkSVKZfHU76THf9+N+WV49uGAXY/SWdQnyWjHLdf/87v0hzI5zmSkBH32EBv5Zjt6u9xX/bhsLHuhs=
Received: by 10.78.160.4 with SMTP id i4mr752467hue.1186125804677;
        Fri, 03 Aug 2007 00:23:24 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Fri, 3 Aug 2007 00:23:24 -0700 (PDT)
In-Reply-To: <7v7iodqgg9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54684>

On 8/3/07, Junio C Hamano <gitster@pobox.com> wrote:
> I sense you haven't read my replacement patch (Dscho Acked it).

I did. I had to pay attention to what I read, though. Sorry.
