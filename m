From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCHv3 GSoC] gitweb: Move static files into seperate subdirectory
Date: Thu, 13 May 2010 10:54:01 +0200
Message-ID: <201005131054.01262.chriscool@tuxfamily.org>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com> <201005120127.55971.jnareb@gmail.com> <4BEA5E2F.9070608@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 10:54:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCUBQ-0006Cw-AT
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 10:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab0EMIyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 04:54:14 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:43279 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755142Ab0EMIyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 04:54:12 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 26781818034;
	Thu, 13 May 2010 10:54:02 +0200 (CEST)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP;
	Thu, 13 May 2010 10:54:01 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <4BEA5E2F.9070608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146979>

On Wednesday 12 May 2010 09:52:15 Pavan Kumar Sunkara wrote:
> 
>   First you have to generate gitweb.cgi from gitweb.perl using
> -"make gitweb", then copy appropriate files (gitweb.cgi, gitweb.js,
> -gitweb.css, git-logo.png and git-favicon.png) to their destination.
> -For example if git was (or is) installed with /usr prefix, you can do
> +"make gitweb", then "make install-gitweb" appropriate files

There is something missing between 'then "make install-gitweb"' and 
'appropriate files', perhaps 'will copy'

> +(gitweb.cgi, gitweb.js, gitweb.css, git-logo.png and git-favicon.png)
> +to their destination. For example if git was (or is) installed with
> +/usr prefix and gitwebdir is /var/www/cgi-bin, you can do
> 
>       $ make prefix=/usr gitweb                            ;# as yourself
>       # make gitwebdir=/var/www/cgi-bin install-gitweb     ;# as root

Thanks,
Christian.
