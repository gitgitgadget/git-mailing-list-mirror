From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/13] remote helper improvements
Date: Sun, 29 Aug 2010 20:53:21 -0500
Message-ID: <20100830015321.GG2305@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 03:55:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Optaa-00058b-By
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 03:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab0H3BzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 21:55:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52959 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368Ab0H3BzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 21:55:05 -0400
Received: by gwj17 with SMTP id 17so1819868gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 18:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NIlIjHKi2wO1EXl969fVdOGDfBuyH3C0vQDLrnCgt6w=;
        b=TvkS33MsoGv/EhwTWqdktRax3dINBZb5/oQUmsVu+E5YrjkkNTbUi1Gnu/y0fjN5Pc
         X16BoJTaco+fgWjiwS5PhG89pcbMj0eLJNZA0KA5yfw30I7Sc75r8qPuJNwN/qKuA+zi
         Ued2NYjl4ZHqJGAXAdVZCXSJQ/IyFpDEEiBNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TOpyWwVxDFWKrqmVFM2g1ygnOwbTZE5ZG/zciZ6wLbOWQQQ61bzdVZermzP0ayuaSq
         dm6AJZqxvyupxYA7pbo9QVUhRHbT6cMlF9QaGd6ZPXVtKRfti6l+vAa/gJwsSCjDvTUT
         7LMlc/UDxyePQRkZdgRcsm+VIdBfJlpvEg9yk=
Received: by 10.101.28.16 with SMTP id f16mr3804661anj.59.1283133304365;
        Sun, 29 Aug 2010 18:55:04 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i25sm11661787anh.17.2010.08.29.18.55.03
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 18:55:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154744>

Sverre Rabbelier wrote:

> I had a week and then some stray days here and there to do some more
> work on git-remote-hg, the result of which is this series. It takes
> the 'import' and 'export' commands out of their 'toy' stage, and gets
> them ready for real usage.

Sign-off?

> Although 'git-remote-testgit' is still the
> only thing using them, 'git-remote-hg' is nearing completion, I hope
> to send out an RFC for it Real Soon Now (TM).

Very good to hear. :)
