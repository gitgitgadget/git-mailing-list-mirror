From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: post-update script to update wc - version 2
Date: Wed, 27 Jun 2007 11:21:45 +0200
Message-ID: <81b0412b0706270221y40bac0a7gf6b73eda9f1e4bb0@mail.gmail.com>
References: <E1I3MuE-0005eO-00@www.watts.utsl.gen.nz>
	 <4681C640.6060408@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <samv@utsl.gen.nz>, git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 11:21:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Tij-00087F-QT
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 11:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbXF0JVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 05:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753014AbXF0JVs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 05:21:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:54205 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbXF0JVr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 05:21:47 -0400
Received: by wr-out-0506.google.com with SMTP id 76so68191wra
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 02:21:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fcTm9gd48MIUatzwwsQxUCor2b1G9nyHK9YZant58z/MwLZ+5U6EkEeIGv+u87nJNNeFGV1VGORkBua5djfxtMYuGAKq7lL/FRXMcaQaqWFI/dJh0xpZTrip/rfQX3VKiWJ6yj33kybOiNvynoES2vrxQi1Apkf/tzltV94KIJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MWKP8t8g7I2Ztg/Qsd1O54RmeFpWrVSxh6WW6bKtaqEWXeyz0yKQBKSQF22YAui9I3i8mAdH7i8YsHW78QeIb1G5KjaN9hezBfNGRGbQnBX7YC/4R/koYwV58V6vxndwF0MYM83HCPcfMAdESW8UzZ5jWtSzsN85EdgYzKTlSzE=
Received: by 10.78.201.10 with SMTP id y10mr134573huf.1182936105141;
        Wed, 27 Jun 2007 02:21:45 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 27 Jun 2007 02:21:45 -0700 (PDT)
In-Reply-To: <4681C640.6060408@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51027>

On 6/27/07, Sam Vilain <sam@vilain.net> wrote:
> Sam Vilain wrote:
> >         this_tree=`git-cat-file commit $commit | awk '/^tree/ { print $2; exit }'`
>
> Of course on newer git, `git-rev-parse $commit:` will do that.
>

Are you sure? Maybe you mean git-rev-parse "$commit"^{tree}?
