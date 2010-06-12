From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: use value of GIT_REFLOG_ACTION env variable as
 reflog message
Date: Sat, 12 Jun 2010 12:12:53 -0500
Message-ID: <20100612171253.GA6078@burratino>
References: <20100612160513.4104.89491.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jun 12 19:13:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONUGf-0004av-Ii
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 19:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab0FLRNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 13:13:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46669 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab0FLRNE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 13:13:04 -0400
Received: by iwn9 with SMTP id 9so1620578iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QwMQ/DJZAR2GWciLx7VC0h5wo4404Gqbr1Dzm88rM9I=;
        b=Vje3HMPG/vmZjAC1r6dDs+lNqyikS8z6jguZhsvDZBgfs2TBbQ7JshF010gqL8vfxI
         Np4Vkam4KO7BprxXUVIOYrdMsDZcQRsxJM6MYOx8qu4ZmTF1w8cHb/YoXTlMhx4gVKgT
         fhEo2xgz4KSginX2ig2S4YsA6WLPAoeMwza4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qBUPrVlr2VqrbxwMjq3hPitPj9Ku1W/53nP+t+xf05ozRCizrApK3+9PsI6SHnqr51
         du7vX3iYRypSvUhAkuJ+OD72MpP5wgmD2R0d8qIuWsBkgKUt36A+yVl+QarhAWOj0v2Z
         x7d9oyOAE4H1CSI2QFn0DEXnBda8/SwJooWzc=
Received: by 10.231.124.17 with SMTP id s17mr3597576ibr.181.1276362783015;
        Sat, 12 Jun 2010 10:13:03 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm11234645ibf.19.2010.06.12.10.13.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 10:13:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100612160513.4104.89491.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149023>

Christian Couder wrote:

> The environment variable GIT_REFLOG_ACTION was used by git-commit.sh,
> but when it was converted to a builtin
> (f5bbc3225c4b073a7ff3218164a0c820299bc9c6, Port git commit to C,
> Nov 8 2007) this was lost.

Ack --- this is just a bug, I think.  The patch makes sense.

Thanks,
Jonathan
