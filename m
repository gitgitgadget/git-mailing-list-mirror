From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] gitweb: add extensions to highlight feature
Date: Fri, 17 Dec 2010 12:17:23 +0100
Message-ID: <201012171217.24350.jnareb@gmail.com>
References: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr> <m3y68slxj9.fsf@localhost.localdomain> <1292538804.2511.4.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Fri Dec 17 12:17:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTYJj-0007JB-T4
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 12:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225Ab0LQLRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 06:17:38 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:59576 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab0LQLRh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 06:17:37 -0500
Received: by fxm18 with SMTP id 18so523466fxm.2
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 03:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=51nOGJshUY+EyQqUwvLZOnaLiic0H4m8P2Ay9egW1iE=;
        b=C/kr7lkQ2Y8PhDDaP/v86au4bEdeAkSObqp5lCpxcTQtYfkwRwKTGX1V7gCmoeK2ht
         S6mAbgwWNVXD9RwdmJ4cC7pLRLH+geiSRTvxskPxnrS33PXgktRC4AN9xgiWTxEfLfLA
         zDI41R/BOh8dFYf4U9sUOho6DYKUo1erDeXJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Gk9CZF/cg5yCgKBNn25SX0wMVA497usZEQmoEvliLD9u0MFxMXMATUGmKicSoT6Zca
         7dhDPidXYsRlHFs/soRDliQyGEUvpBfrZUFqrJhuWLIjVnivwvnDcPmqgKZU24I8JqWY
         70zqUob6mgu+0MkmlzXINcDDhLAUrDUZufkBY=
Received: by 10.223.86.65 with SMTP id r1mr967635fal.24.1292584656323;
        Fri, 17 Dec 2010 03:17:36 -0800 (PST)
Received: from [192.168.1.13] (aeho46.neoplus.adsl.tpnet.pl [79.186.196.46])
        by mx.google.com with ESMTPS id y14sm49156fak.42.2010.12.17.03.17.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 03:17:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1292538804.2511.4.camel@kheops>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163872>

On Thu, 16 Dec 2010, Sylvain Rabot wrote:
> On Thu, 2010-12-16 at 14:22 -0800, Jakub Narebski wrote:
> > Sylvain Rabot <sylvain@abstraction.fr> writes:

> > >  	# alternate extensions, see /etc/highlight/filetypes.conf
> > >  	'h' => 'c',
> > > +	map { $_ => 'sh'  } qw(bash zsh),
> > 
> > Good idea.
> 
> Does ksh, csh can be highlighted as sh too ?

My /etc/highlight/filetypes.conf does include only

  $ext(sh)=bash

All of bash, zsh and ksh are POSIX shell (sh) compatibile, so sh syntax
(which is according to my /usr/share/highlight/langDefs/sh.lang file
"Bash script language definition file" ;-)) should work.  csh IIRC isn't.
So therefore I am not sure if csh can be highlighted correctly using sh
syntax.

-- 
Jakub Narebski
Poland
