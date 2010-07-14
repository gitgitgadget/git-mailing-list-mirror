From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/9] Get svnrdump merged into git.git
Date: Tue, 13 Jul 2010 19:28:43 -0500
Message-ID: <20100714002843.GC2308@burratino>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <20100713235825.GC12639@debian>
 <20100714001530.GB2308@burratino>
 <20100714002235.GF12639@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 02:29:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYpqx-0005oo-Oq
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 02:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571Ab0GNA3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 20:29:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47242 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab0GNA33 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 20:29:29 -0400
Received: by iwn7 with SMTP id 7so6396144iwn.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 17:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/sCv1IpZg+8RLyMr87slk+oTbLUN7L2UxezSecxXBvY=;
        b=w2K571b1lYhX6lEflEidJcCN6WKdIh8GLkJgS6wobKwEXS+6IOzHTblAfWrGN0HvHY
         yy6G47Gghpc2mRyHnApNChjx1bc9tv3g59eY/6CaWsaiNoo6u76orQc60OneJL/MfWue
         fTGE4P9Jt4YtRwrXWwwNE2bgg6oQJAjLL60sI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lvDHYqi9yMy0ok0Uju1dEdHnpH7eL9Snmt6NrN9boyfQ26e7bDknCIRbYXmt930TJr
         mK0JP6/7/O2ut3BQjiyHsW7i2y00MoraqKHYIMhz5G0xj6HFAziVPz/wTH3oyvN6heo+
         IsU11SUPssVAk67KwTQwoTjv+hf9vsQXq4tzg=
Received: by 10.231.161.16 with SMTP id p16mr11209059ibx.61.1279067369145;
        Tue, 13 Jul 2010 17:29:29 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm27435872ibh.16.2010.07.13.17.29.28
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 17:29:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100714002235.GF12639@debian>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150953>

Ramkumar Ramachandra wrote:

> Is licensing an issue? I won't be the copyright holder or the sole
> contributor to svnrdump when it's in ASF. Can I just copy-paste from
> there into the git.git tree?

As long as the relevant licenses permit that.  svnrdump only links to
libsvnclient, right?  So copy-pasting the code along with

 - a copy of the Apache license
 - prominent notices in any files that differ from the svn version
 - the notices from the Subversion NOTICE file

should be okay.
