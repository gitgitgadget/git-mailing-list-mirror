From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSoC] gitweb: Move static files into seperate subdirectory
Date: Mon, 10 May 2010 14:55:45 +0200
Message-ID: <201005101455.50633.jnareb@gmail.com>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com> <m3bpcoenci.fsf@localhost.localdomain> <AANLkTim2rIFDBRChBxTiWZCNmd8ozwKQzM3RZOEr3mgp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 14:56:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBSWn-0007Tg-5d
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 14:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab0EJM4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 08:56:02 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63886 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab0EJM4B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 08:56:01 -0400
Received: by fxm7 with SMTP id 7so58128fxm.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Aj8WTkFLyFKwdalbTFvnWltBBxLbH1d0sXQXs5WgSnQ=;
        b=GEeD0PGILfYXyCgnKO0xZKo6RSxcMEFdfxHEt51+oQzwodV+e0tCmptu6gqHt2IHej
         Cq4TOpAyG9sT9ChzYcVBYiHYeFL4qNvETEQhjgoEq+1cZfOjGzOBm72ceoSjGjOQyYrm
         8Zaq6t4JuAUBwzXQl04nVnNxD9wrpagMZVwKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=txDUcRGBaCiaxH1newQyCeR1aqrUtIIj+kfj9HmDsOli18+hL0V7YVeJ4w3Lvjo0sV
         JUbyf9sf+mu1HsE3vVrlpgtJUlBHDrjBrnGJ0q6zLN8dTIX4w254Wo9gRGROXuY9gyKm
         2nHKtHfzFnxXxBCpXldEvQPV0asHl8eXMPuzo=
Received: by 10.223.24.148 with SMTP id v20mr4307076fab.43.1273496159352;
        Mon, 10 May 2010 05:55:59 -0700 (PDT)
Received: from [192.168.1.13] (abwb94.neoplus.adsl.tpnet.pl [83.8.225.94])
        by mx.google.com with ESMTPS id 7sm21391178far.6.2010.05.10.05.55.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 05:55:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTim2rIFDBRChBxTiWZCNmd8ozwKQzM3RZOEr3mgp@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146807>

Only minor comments about submission itself.  Patch I think is now
all right with added required changes to main Makefile.


On Mon, 10 May 2010, Pavan Kumar Sunkara wrote:

> Gitweb: Move static files into seperate subdirectory

This should be the subject of an email, like now is (only without
"Re:"), and this line should be missing from email body.

Or you need to use

  Subject: gitweb: Move static files into seperate subdirectory

It is customary to start subsystem prefix with lowercase.

> 
> Create a new subdirectory called 'static' in gitweb/, and move
> all static files required by gitweb.cgi when running, which means
> styles, images and Javascript code. This should make gitweb more
> readable and easier to maintain.
> 
> Update t/gitweb-lib.sh to reflect this change.  The default is
> now to install static files also in 'static' subdirectory in target
> directory: update Makefile, gitweb's INSTALL, README and Makefile
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---

The comments about patch itself should be put *here*, between "---\n"
and diffstat.

> 
> This is the new patch which includes the changes suggested by Jakub.
> 
> Regarding wordwrap, all the mailing ports in my university are closed
> which leaves me only the gmail web cient which don't have any option
> to disable wordwrap. I will try to find a workaround for this. Please
> bear with my wordwrap until then.
> 
> Thanks
> -Pavan
 
Like this.

>  Makefile                            |   20 ++++++++++----------
>  gitweb/INSTALL                      |   20 ++++++++++----------
>  gitweb/Makefile                     |   20 ++++++++++----------
>  gitweb/README                       |   13 +++++++------
>  gitweb/{ => static}/git-favicon.png |  Bin 115 -> 115 bytes
>  gitweb/{ => static}/git-logo.png    |  Bin 207 -> 207 bytes
>  gitweb/{ => static}/gitweb.css      |    0
>  gitweb/{ => static}/gitweb.js       |    0
>  t/gitweb-lib.sh                     |    6 +++---
>  9 files changed, 40 insertions(+), 39 deletions(-)
>  rename gitweb/{ => static}/git-favicon.png (100%)
>  rename gitweb/{ => static}/git-logo.png (100%)
>  rename gitweb/{ => static}/gitweb.css (100%)
>  rename gitweb/{ => static}/gitweb.js (100%)

[...]
-- 
Jakub Narebski
Poland
