From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 20:58:13 +0200
Message-ID: <200806242058.13721.jnareb@gmail.com>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com> <ce513bcc0806240642g56ca5450t4edd24fd88ce79c7@mail.gmail.com> <20080624135429.GA6905@atn.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Erez Zilber <erezzi.list@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthias Kestenholz <mk@spinlock.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Anton Gladkov <agladkov@parallels.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:59:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDji-0008Pd-NS
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 20:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbYFXS6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 14:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbYFXS6b
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 14:58:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:53003 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbYFXS6a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 14:58:30 -0400
Received: by nf-out-0910.google.com with SMTP id d3so50412nfc.21
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IH/qIz0aGK0Rk2KqdSSIBCo/ua1IKHuNoA29XVMaDw8=;
        b=LU7FnrwXRshbNb1IbD02CxralGzjkz0x1ghysrBxnEIB+X5jpw7P0GDFZ6EOixGkiG
         B5S0LoOZ29a6XIq3L+HT/WB27TUnTGIFninv8T3Dm0zMQmqGtqhwYdrwDy5UYHG3+2hM
         iOxiKWfGxY6acfVBO1SQJO2Kr9h7HDpdk0KDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Bte5Eu4AjITRiefVkgpLCcZzmJq9PdL/CxBfmlTKrzahp0isCbvq/v8rNVhhL+j+6d
         3jjM0cMPhjRIPZ7zQOfWlRpmvlRfUKIFu42mirpeTwYCbDHUo7RSZ7U0iT2B++LEPPWO
         KtfGQsfPG74ptftF7psDTrs/nHaiGJmK27DYM=
Received: by 10.210.27.20 with SMTP id a20mr603474eba.89.1214333897708;
        Tue, 24 Jun 2008 11:58:17 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.223.44])
        by mx.google.com with ESMTPS id f6sm1398340nfh.37.2008.06.24.11.58.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 11:58:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080624135429.GA6905@atn.sw.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86107>

On Tue, 24 Jun 2008, Anton Gladkov wrote:
> On Tue, Jun 24, 2008 at 05:42:14PM +0400, Erez Zilber wrote:
> >
> > I guess that the problem is that no proper mapping exists. That's why
> > I see the following in /var/log/httpd/error_log:
> > 
> > [Tue Jun 24 16:31:52 2008] [error] [client 172.16.0.7] File does not
> > exist: /var/www/html/pub
> > 
> > What do I need to add in /etc/httpd/conf.d/ in order to set the
> > mapping to /pub/git instead of /var/www/html/pub ? Is there an example
> > that shows how to map?
> 
> IMO the simplest way is to create a symlink 'pub' in /var/www/html directory
> pointing to /pub and to add 'Options FollowSymLinks' to <Directory /> in httpd.conf.

Another solution (not necessary simplest, but it might be preferred
from the security point of view) is to do some URL rewriting / redirection.
See your web server documentation for details...

-- 
Jakub Narebski
Poland
