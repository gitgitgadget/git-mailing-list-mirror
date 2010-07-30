From: David Aguilar <davvid@gmail.com>
Subject: Re: Build error with 1.7.2 and 1.7.2.1 on PPC Mac OS X 10.4
Date: Fri, 30 Jul 2010 01:28:29 -0700
Message-ID: <20100730082827.GA2500@gmail.com>
References: <6E0EF82C-2938-4149-A277-D51BC046B4E2@gmail.com>
 <20100730014220.GC2182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Melton Low <softw.devl@gmail.com>, git@vger.kernel.org,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 10:28:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OekxW-0006FZ-Lt
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 10:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765Ab0G3I2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 04:28:46 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44324 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab0G3I2p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 04:28:45 -0400
Received: by pvc7 with SMTP id 7so424788pvc.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ylRqX9hgYCFkr7rNXHHgllk/jI4YUsNsViFS46k5hU4=;
        b=WlWJgN3V4huDQyuED83A4yTrYbBK8HxB4NyAsREAjz8Xbfflcl9q4hMeB/aQX4/yv1
         XHrgDgGKObqP/vqgBuZk334xs1dU39Hf/t4/UIUqJcboQQXZRNMeckdlAJgeo4+8DvKN
         chAkglOqInrFk2L5S4J6xSdQG9EaI3jHhptG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=g8vA8B34I+wuDnKxWk2bUiZMkRAXAU/xQYvdoYVUMANoDZhlbUCdWOjEmsdQd4mKmj
         tWc+8eb1YZopNDcOYFdVjhWm7WQ9+vR+Ugd0LKgRZoHLV91XJXOH9InX7ZbLhPYNQMnp
         LI/HNGh+0vKf3oMYfxBa+ymHimYAtkjuoJQZo=
Received: by 10.114.36.2 with SMTP id j2mr1784852waj.88.1280478521261;
        Fri, 30 Jul 2010 01:28:41 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 33sm3245860wad.18.2010.07.30.01.28.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 01:28:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100730014220.GC2182@burratino>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152225>

On Thu, Jul 29, 2010 at 08:42:20PM -0500, Jonathan Nieder wrote:
> Hi Mel,
> 
> Melton Low wrote:
> 
> > Error during build on 1.7.2.  I just tried building 1.7.2.1 with the
> > same error.  A partial output from my attempt to build 1.7.2.1:
> > 
> >     * new build flags or prefix
> >     CC fast-import.o
> > powerpc-apple-darwin8-gcc-4.0.1: unrecognized option '-pthread'
> >     CC abspath.o
> [...]
> 
> Looks like it worked, though loudly.

This is an OS Xism.
-pthread is always enabled and gcc loudly ignores it.
We don't have to pass -pthread there.

I shoulda probably just hacked the Makefile and responded with a
patch instead... ;-)

-- 
		David
