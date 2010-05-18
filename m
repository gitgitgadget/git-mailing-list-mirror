From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git clone problem, missing "configure"
Date: Tue, 18 May 2010 16:53:20 -0500
Message-ID: <20100518215320.GA9065@progeny.tock>
References: <984297.53304.qm@web30503.mail.mud.yahoo.com>
 <20100518200150.GB4448@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anthony Willard <awillard69@yahoo.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 18 23:53:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEUjM-0004W4-UP
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 23:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723Ab0ERVxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 17:53:33 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:59012 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446Ab0ERVxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 17:53:31 -0400
Received: by qyk13 with SMTP id 13so9992037qyk.1
        for <git@vger.kernel.org>; Tue, 18 May 2010 14:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=B0+v7SvmWWEEkF+PsvjUIwlLWpyRYGChv4NANjhWW2w=;
        b=joFgr4b1x90tjyZi7OtFUcs8j/t/b3sCm71qprYfebrO2c5I2cZqLhoHYbWiAzC4DA
         cPgc36OpMeDYNRc7smvk1eqG13Se6SPsxWQf2oAkpLgk6gYjIx3o91B/nCAUGoOy3Rrb
         A9/d5BinEj+8YvzC2e7ZhQoWe3xQtu6AKfOwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZYI6X5OYmOwcWQn4/kBb/5zEhUcgLd8zfh6mMLJlwkxXeyAlVDxzW9zwpflBHkBfLg
         3vAvPVr4rwr+hw03h13Yk3+8ZV8Jmr2mqdbHD86Y9vNXZmiglXIG7EJg3XFXip+QlKGG
         pm4bzbiyAFImUTyoky0bDi8RX9oAeZBuJgkiM=
Received: by 10.229.236.16 with SMTP id ki16mr1622418qcb.68.1274219609536;
        Tue, 18 May 2010 14:53:29 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f5sm1490051qcg.8.2010.05.18.14.53.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 May 2010 14:53:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100518200150.GB4448@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147310>

Hi,

Jeff King wrote:

> Right. We don't commit the configure script, as it is auto-generated.
> You need to either:
> 
>   1. Build from a release tarball which contains the "configure" script.
> 
>   2. Run "autoconf" to generate the configure script (obviously this
>      implies that you have GNU autoconf installed).
> 
>   3. Just run "make" without configure. You may need to tweak some
>      settings if you don't have some optional libraries installed. See the
>      top of Makefile for details.

To add to this excellent reply, I should mention the

  make configure

command.  This runs autoconf, also filling in the version number for
correct ./configure --help output. :)

See the README and INSTALL files for more details.

Hope that helps,
Jonathan
