From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] gitweb: Support for arbitrary diffs
Date: Mon, 3 Sep 2007 10:23:41 +0200
Message-ID: <200709031023.42366.jnareb@gmail.com>
References: <11887443682216-git-send-email-mkoegler@auto.tuwien.ac.at> <fbfjtl$7gh$1@sea.gmane.org> <20070903013330.GR1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Sep 03 12:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS9XG-0007Na-KA
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 12:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbXICKvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 06:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbXICKvv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 06:51:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:7004 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbXICKvu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 06:51:50 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1173352nfh
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 03:51:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LRW1BBy6UAh6zPunGTtHU3n51fMjWkJ6jg5tefhNjFlk322C/jEyUHTciBtOqOxyDSaFLMk4LiQWbH1N0kdqWEiIQLxBJPxFdEDH+j2ejiJTpakkO5eMC2p2NTUbMmltWNy/wXfnrXVVpcfYkFPMB43wWze7kunvmu0LB37WlRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=n3OqNIPPS8N+dBZ7VK83Tb+N1cSx7QBCDuovxNMDKahHj07cawC5LDIuuhj8XFbIpOCHFxirLaa6IG5ccm2/8XmcT8pkuOgKaL6uLHpZtzRBlvEsQyVd7aCWvBTj99GVMwL5S4SJdpdjJsTcINmvTHWRqVYH8vKMDFPBhzrH4hs=
Received: by 10.78.166.7 with SMTP id o7mr3115681hue.1188816707895;
        Mon, 03 Sep 2007 03:51:47 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id p30sm1044865hub.2007.09.03.03.51.39
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Sep 2007 03:51:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070903013330.GR1219@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57464>

On Mon, 3 September 2007, Petr "Pasky" Baudis wrote:

> To hijack this post a bit, another patch in the queue (the incremental
> blame thingie) introduces blame.js. Do you think that we should keep the
> .js files separate, or instead have one big gitweb.js with everything?
> I'm inclined to the second possibility in order to reduce the number of
> requests, but it comes at a price of slightly worse maintainability.

On the other hand if we have blame.js separate, we could load it
(require it) only for the 'blame' view, it means only when needed.

gitweb.js would contain JavaScript code used by all (or almost all)
views, then...

I don't think gitweb.js would be as large as gitweb.perl, if we are
talking about maintability ;-)

-- 
Jakub Narebski
Poland
