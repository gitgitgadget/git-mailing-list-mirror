From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: ssh admin git accidentally deleted
Date: Tue, 7 Jul 2015 15:49:43 +0200
Message-ID: <20150707134942.GA7613@paksenarrion.iveqy.com>
References: <CAF1FN5CDnUYxjChO2PZFrDnPRUiuqXhko=iDo=tuqwvJJdUg5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: agnes retnaningsih <agnes.monest@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 15:50:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTGC-0003Qg-Ch
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 15:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308AbbGGNt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 09:49:57 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:33285 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307AbbGGNtr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 09:49:47 -0400
Received: by laar3 with SMTP id r3so196523369laa.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xI1ug0MP7VwvNxT3+0Z+RW2maPeaUG/6z/BRDrbPFXY=;
        b=i3z7YdZP/RSi2dPXfHiSEJhZTnFCNSbI98ppzPNFC22uNgk5B0zybhBwYYcXrIHlB5
         +J+7mkEbJfsD65He4LiUmlQbFwIRNBukD608IPt1kLRLN+IcIwsshLrBd+TlsibVasOb
         TJ+TVB4mCGAL/kelcEQgbe7Tl9efHOPgZm8qJnyppx5P+rLVlWX/pdFZ+B4/1/hPVzjx
         tkBzoRBl63kpKBH8cOKlPn+alb46F2DSwg75nkhGApNpEMqWexkyfLlsNm21znN7brjb
         CWe9/2u5oan4CObAdjKVc7hil+t2EFek7NZDHth1ee2qAEs5SOHoVOzAGaU8dPonWtJC
         31IQ==
X-Received: by 10.153.4.12 with SMTP id ca12mr4177723lad.20.1436276985684;
        Tue, 07 Jul 2015 06:49:45 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-17-125.bredband.comhem.se. [83.249.17.125])
        by mx.google.com with ESMTPSA id o18sm5615146lbg.1.2015.07.07.06.49.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2015 06:49:44 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1ZCTFn-00011y-4A; Tue, 07 Jul 2015 15:49:43 +0200
Content-Disposition: inline
In-Reply-To: <CAF1FN5CDnUYxjChO2PZFrDnPRUiuqXhko=iDo=tuqwvJJdUg5A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273505>

On Tue, Jul 07, 2015 at 08:30:59PM +0700, agnes retnaningsih wrote:
> Dear git , I accidentally delete ssh admin git, unfortunately there
> just one admin so I can't make a change in the config and push to the
> repository. If there's a way undo the change or make an existing user
> become an admin or is there any super admin command?

Git does not have access control at all. There's no admin in git. You're
talking about a hosting solution for git and you're not telling which
one you're using. If you want a better answer you need to provide more
information.

_Assuming_ you're using gitolite on Linux you can always use the root
account on the server to correct any mistakes you did in the gitolite
configuration.

> 
> I use git version 1.7.5.4

What's the reason for using a 4 year old version? You're missing a lot
of development. It's like using an iPhone 4s today instead of an iPhone
6.

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
