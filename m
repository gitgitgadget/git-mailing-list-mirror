From: Daniel Reichelt <debian@nachtgeist.net>
Subject: Re: gitweb: false base href sent when integrated via reverse proxy
 and path_info is active
Date: Sun, 28 Nov 2010 22:28:57 +0100
Message-ID: <4CF2C999.4060601@nachtgeist.net>
References: <20101128081048.13668.67286.reportbug@sb74.startrek> <20101128162720.GB18335@burratino> <AANLkTinM8qyL9DafMx4XWBQ5RUeWABKVc5mNjdVEkQfZ@mail.gmail.com> <201011281847.40233.jnareb@gmail.com> <4CF2BBEE.2050808@nachtgeist.net> <20101128211054.GA20203@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 22:29:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMonw-0008L2-SI
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 22:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766Ab0K1V27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 16:28:59 -0500
Received: from srv04.jarevo.de ([88.198.54.146]:64315 "EHLO srv04.jarevo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab0K1V27 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 16:28:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by srv04.jarevo.de (Postfix) with ESMTP id 233163083;
	Sun, 28 Nov 2010 22:28:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv04.jarevo.de
Received: from srv04.jarevo.de ([127.0.0.1])
	by localhost (srv04.jarevo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5J9FdYxnVqps; Sun, 28 Nov 2010 22:28:57 +0100 (CET)
Received: from [10.0.0.1] (localhost [127.0.0.1])
	by srv04.jarevo.de (Postfix) with ESMTPA id 81FD8306F;
	Sun, 28 Nov 2010 22:28:57 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101030 Icedove/3.0.10
In-Reply-To: <20101128211054.GA20203@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162363>

> Aha.  The bug fixed by v1.7.3-rc0~85^2 (gitweb: allow configurations
> that change with each request, 2010-07-30) strikes again.
>
> Daniel, could you try again with version 1:1.7.2.3-2.1 (from Debian sid)?

Yay - now setting $base_url in gitweb.conf works (and on a side note
$my_url and $my_uri as well). Thanks to all of you guys for helping in
tracking this down.

Cheers
Daniel
