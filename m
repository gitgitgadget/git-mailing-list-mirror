From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/9] Add infrastructure to write revisions in
 fast-export format
Date: Thu, 24 Jun 2010 14:36:29 -0500
Message-ID: <20100624193629.GA2065@burratino>
References: <20100624105004.GA12336@burratino>
 <20100624110217.GG12376@burratino>
 <AANLkTikyjq7HQY1hUTOGF_oBsGDj_jUI-GwDBRdacCzG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 21:36:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORsEA-0006gF-Ly
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 21:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab0FXTgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 15:36:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33352 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab0FXTgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 15:36:41 -0400
Received: by iwn41 with SMTP id 41so1153434iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Nqd4wbDzhosTsnVP7ULysE0nxJK+NdvqLB4YbdEKWBs=;
        b=By2Ki+bM3Oj9GIISxggHlbcPvLNwv0AWjvHPPvWXp6oqlgTwZYftuvfX1BfQxvKv6w
         F1o4h1542Xb0Adoq6IwxXv6QECDMp90IrB4RoZvkfD6HxAy3TT8iwt4H4GC7T1N9S/xO
         rXREd9jooET4XM1BB1q9LkbuIQvbQOF2bON7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=V05tI2y5oOu98GxIIzKKV5oaRdj3X4eoUzihrHVqa0xR28EdM6OVdRYyiquuVLJBsK
         p/yGGQDOGRQsKSyBZ6CB9hfAUXkSIPG3LORKtJQDurb7yKhL/SNGh4h5visOaXSHQ5oH
         9RWPdlpoXKD30ZkF9x60Fk/fE6jTQdwdTlY9o=
Received: by 10.231.181.69 with SMTP id bx5mr10722040ibb.189.1277408200839;
        Thu, 24 Jun 2010 12:36:40 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm19652782ibf.13.2010.06.24.12.36.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 12:36:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikyjq7HQY1hUTOGF_oBsGDj_jUI-GwDBRdacCzG@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149627>

Ramkumar Ramachandra wrote:

> This is like API documentation- should it go into the commit message?
> Maybe put this in a a dedicated repo_tree.txt like trp.h?

Good question.  The answer depends on whether we want to keep it
maintained.

Since this is not meant to be a general-purpose API, I thought it
simplest to document it in the commit message and let future commit
messages describe the purpose of future changes.  We are not
approaching any limit on the length of a commit object, after all.

Jonathan
