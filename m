From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] t/t5800: skip if python version is older than 2.5
Date: Tue, 17 Aug 2010 18:37:17 -0500
Message-ID: <20100817233717.GJ2221@burratino>
References: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
 <injaoVtrfs7Li4aYBNxEQeawf3YbhxcYbL79Jvef2ML9502YRtjqEol2RVKBzXfH_PfbMep0lvU@cipher.nrlssc.navy.mil>
 <AANLkTimwNBAKwhKwsquDS4k3x0_iDo3rEyqFfhMcsb38@mail.gmail.com>
 <20100817232838.GH2221@burratino>
 <AANLkTim77g+z3KXyCOy4G-caCncyFa0FfqPMFatZnwLN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 01:39:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVkJ-0002yw-Hu
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230Ab0HQXjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 19:39:01 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39949 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab0HQXjA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 19:39:00 -0400
Received: by vws3 with SMTP id 3so5141968vws.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OKi+8o9ovZQrYQEBXk9aZ35jFeZ9WP4sJ6YEfX9koyM=;
        b=fQIBQAvWe9xpsDqNputPyOkzYUNd7yB6/V67beQije+IgCOKpenypPNNCeWC4n3Pvo
         NU4uk/9zz9YZd9BFzQEG4h2AOBkKYuLD03YUQfr1NLwXV4yrTxacbljHhVq3O3sDFTT6
         /j/KvTzOQ2tFJ9WemvoBtptls5gT5x8MOC288=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HKqlXh7IL45/43DabuNFYEV0c2UN2mjKEu6zAS7mVbyUAEz5GaU1GohJ2x5jSeMUY8
         Xf9oFixangsuRXjnN21YRxESO1d8OiHhphXkt1ePF9swTdWexTA/NVTYWFsqwNVAbebv
         GAIo/R+QTX7/re+H13pVIOXhDv+0tOzYi9vUM=
Received: by 10.220.125.4 with SMTP id w4mr4366978vcr.31.1282088338938;
        Tue, 17 Aug 2010 16:38:58 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u2sm134565vcr.32.2010.08.17.16.38.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 16:38:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim77g+z3KXyCOy4G-caCncyFa0FfqPMFatZnwLN@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153791>

Hi again,

Sverre Rabbelier wrote:

> sverre@laptop-sverre:~/code/git$ cat GIT-BUILD-OPTIONS
> SHELL_PATH='/bin/sh'
> PERL_PATH='/usr/bin/perl'
> TAR='tar'
> NO_CURL=''
> NO_PERL=''
> NO_PYTHON=''

I see.  Maybe this is fixed by v1.7.2-rc0~33^2~1 (Makefile: add
PYTHON_PATH to GIT-BUILD-OPTIONS, 2010-06-09) from later in the
same series.
