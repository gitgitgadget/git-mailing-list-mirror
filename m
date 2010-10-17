From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t0003: properly quote $HOME
Date: Sun, 17 Oct 2010 14:18:27 -0500
Message-ID: <20101017191827.GD3202@burratino>
References: <decc39532e1706c50964bad14c51d0bcd9ab09a6.1287342744.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 17 21:22:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Yo7-0003bf-CM
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 21:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538Ab0JQTWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 15:22:05 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41610 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362Ab0JQTWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 15:22:03 -0400
Received: by ywi6 with SMTP id 6so53179ywi.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 12:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=s4gLYGgLS4sgLY/BK1cnSmhKDArxKLNHeyOh8fioVPM=;
        b=fFEKxzPy9z0kLWSLirHz6nqxDSUfomZ+j7GG71TMTLZ6dNDR6h1mCQJ4I4mKOEwWp6
         zmKckZF2auGn+OiH4CFsFFDyfAdVHvFxmVa3WLCam/dZpr2cyDmD2kgz2GEI0XIobksS
         ssxVPbREMIf4POPrE7yn7xzukw2py0+yRpTY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kANV8zacbHlHEOXMW05YQwCjKJpU7oRj2rYBw5ceIEm06SO9yESwH/cOaGcxr1/hve
         SvsASUDNjzWJUi6cVBXr+DDPrrLIGsAACkyLdJsSWigqIzszV+g+TSfCbE6+r+eZ0X8V
         ebmX1KmXJT2IvgNrIIxb1BVs+mR48x7xWoEn8=
Received: by 10.100.205.15 with SMTP id c15mr2005693ang.215.1287343321521;
        Sun, 17 Oct 2010 12:22:01 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u3sm20509942ani.19.2010.10.17.12.21.59
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 12:22:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <decc39532e1706c50964bad14c51d0bcd9ab09a6.1287342744.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159210>

Thomas Rast wrote:

> 6df42ab (Add global and system-wide gitattributes, 2010-09-01) forgot
> to quote one instance of $HOME in the tests.  This broke the test for
> me with the shell complaining about an ambiguous redirect (but only
> when run with --root for some reason).

Thanks.  What shell do you use?

IIRC it is not ambiguous according to POSIX but since e.g. OpenBSD
complains it is worth fixing.
