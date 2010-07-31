From: David Aguilar <davvid@gmail.com>
Subject: Re: noob user, want checkins to all be forced to LF terminated lines
Date: Sat, 31 Jul 2010 08:12:12 -0700
Message-ID: <20100731151209.GA5693@gmail.com>
References: <i308gl$v6p$1@dough.gmane.org>
 <20100731044957.GA8920@burratino>
 <i30bg7$50k$1@dough.gmane.org>
 <20100731053918.GA19688@LK-Perkele-V2.elisa-laajakaista.fi>
 <i30da5$84d$1@dough.gmane.org>
 <20100731055735.GA19812@LK-Perkele-V2.elisa-laajakaista.fi>
 <i30fj8$cit$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 17:12:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfDji-0003zj-3q
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 17:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756391Ab0GaPMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 11:12:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60001 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014Ab0GaPMV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 11:12:21 -0400
Received: by pwi5 with SMTP id 5so888312pwi.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GnEl7uLo09A6xKyCijrTXTXnA9migc5vPzbkmBQMv5Y=;
        b=Dp6H3HLN2ZNd7D/0TiA0tX7UjchhZg6lMpCKIp0g2gA1Z5fLXcdj0irP3BYz6AW9fK
         izb/3X98MCFZlpusJoQe9KbMoXHn6GWkpDsSgOM5I/+8i4YyE45mQ0DnbRqyyT9Jj9QC
         G947gDlL76UJWK7wYTcHXbsCPDvrOy1h/DgUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pCbQja9SGf3firxj8PxlZAaddRs/buUmoYQryLqjMTwBGqv2V8MTgQQ+wSw/ApblRu
         oS8sGh37AQIFmSGne/KQ1y4BXCjCQb83YwKjVlpeRqHwHA7NUvfdsAkJZMmghSxYUE5Y
         nDxrJy7S9N5HeJ0NKtEdih9F2BOWDxisGDhh0=
Received: by 10.142.215.14 with SMTP id n14mr3085925wfg.13.1280589140437;
        Sat, 31 Jul 2010 08:12:20 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id x18sm4379779wfd.8.2010.07.31.08.12.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 08:12:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <i30fj8$cit$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152329>

On Fri, Jul 30, 2010 at 11:24:34PM -0700, Walter Bright wrote:
> Ilari Liusvaara wrote:
> >On Fri, Jul 30, 2010 at 10:45:36PM -0700, Walter Bright wrote:
> >
> >>>[1] But upon restore, the working copy cache will be wrong
> >>Why? Is it someplace else?
> >
> >It is inside .git directory and will be caught by full recursive
> >backup. Unfortunately, it contains i-node numbers, which aren't
> >preserved through backup and restore.
> >
> >The wrong i-node numbers would then confuse git (false positives
> >in modification detection). Fortunately, this data can be rebuilt
> >with single command (see below).
> 
> Hmm. One thing I wanted to get away from from Windows was the
> inability to restore files by just copying the tree.

I think we gave you too much information.
Just copy the tree, that's all there is to see here...


> >>>and needs to be rebuilt (git update-index --refresh).
> 
> That's crucial to know. Thanks!

Actually, I think that's too much to know.

Casual git users can just say 'git status' and git
will DTRT updating the index itself.

Sorry if the information in this thread made you
think that there's "something else" that you have to
worry about backing up.  Nope, it's all just .git.

-- 
		David
