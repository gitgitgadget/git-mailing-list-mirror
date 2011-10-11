From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5/RFC 3/6] gitweb: Add manpage for gitweb (APPLICATION!!!)
Date: Tue, 11 Oct 2011 16:20:12 +0200
Message-ID: <201110111620.12788.jnareb@gmail.com>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com> <201110111551.09621.jnareb@gmail.com> <1318341714.22324.46.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Oct 11 16:27:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDdIp-000409-1L
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 16:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab1JKO10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 10:27:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39298 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab1JKO1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 10:27:25 -0400
Received: by eye27 with SMTP id 27so2595428eye.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 07:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=+3uBiy4fP0AiWwLTfyb2PIjQFt2YP+58NU12/uXfuDU=;
        b=otjTm+P4xddHI5elVsk8LxbfFrQbafi1fiLQqOhdXIYCip7GOd9NYZLO75uDBHAYD1
         AB4MsmhJZvBzTD5EEcu8ukyZ6HvUGMZeAWLboYfdiw+mRoRJRavhkXpR/CP6YmAvmjPc
         F4lABFnicylMAteMXTwCkegd6LgMXbemYd4zE=
Received: by 10.223.1.131 with SMTP id 3mr41046815faf.30.1318342809958;
        Tue, 11 Oct 2011 07:20:09 -0700 (PDT)
Received: from [192.168.1.13] (abwh114.neoplus.adsl.tpnet.pl. [83.8.231.114])
        by mx.google.com with ESMTPS id x22sm37798483faa.5.2011.10.11.07.20.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Oct 2011 07:20:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1318341714.22324.46.camel@drew-northup.unet.maine.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183298>

On Tue, 11 Oct 2011, Drew Northup wrote:
> On Tue, 2011-10-11 at 15:51 +0200, Jakub Narebski wrote:
> > On Tue, 11 Oct 2011, Drew Northup wrote:
> 
> > > This would be why I included a synopsis with my original submission. As
> > > this was supposed to be a description of the configuration files of said
> > > application it does not make much sense to put the executable in the
> > > synopsis. Please forgive me for attempting to make sense!
> > 
> > But this manpage is about _gitweb itself_, not about gitweb config file(s).
> > Gitweb itself is application, though it is not runnable directly (yet).
> > 
> > Web apps either don't use manpages as documentation, and those that do
> > that I found (SVN::Web for example) include runnable server-starting script.
> 
> Hmm, Couldn't tell from the mail header _which_ we were talking about in
> this subthread. I'll have to read the _whole_ patch apparently next
> time.

I'm sorry.  I guess better subjects would be:

  gitweb: Add gitweb.conf(5) manpage
  gitweb: Add gitweb(1) manpage

instead of current

  gitweb: Add manpage for gitweb configuration files
  gitweb: Add manpage for gitweb

Or perhaps:

  gitweb: Add manpage for gitweb configuration files
  gitweb: Add manpage for gitweb itself

-- 
Jakub Narebski
Poland
