From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Problems during upgrade git from 1.5.3.2 to latest
Date: Sun, 26 Oct 2008 20:58:32 -0700
Message-ID: <49053C68.9020901@pcharlan.com>
References: <20180862.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: horry <qch1695@motorola.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 05:03:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuJKC-0000Sw-EY
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 05:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbYJ0D6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 23:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbYJ0D6e
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 23:58:34 -0400
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:54752 "EHLO
	swarthymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751338AbYJ0D6d (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Oct 2008 23:58:33 -0400
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id BFA2C8F440;
	Sun, 26 Oct 2008 20:58:32 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <20180862.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99200>

horry wrote:
> Hello ,
>    My previous git version is 1.5.3.2 and i perform the suggested commands : 
> git clone http://www.kernel.org/pub/scm/git/git.git  and it goes well , end
> up with :
> 
> ....................................................................
> got d00da833cbeec16da9415e0ac11269594279545a
> Checking 1480 files out...
>  100% (1480/1480) done
> 
> Then i perform make in the same directory i performed clone and it shows
> errors .
> 
> bfnt47-gx1:/apps/mds_lrt/git/git> make
> GIT_VERSION = 1.6.0.3.517.g759a
>     * new build flags or prefix
>     CC fast-import.o
> In file included from /usr/include/openssl/ssl.h:179,
>                  from git-compat-util.h:104,
>                  from builtin.h:4,
>                  from fast-import.c:142:
> /usr/include/openssl/kssl.h:72:18: krb5.h: No such file or directory

This is saying that you are missing this header file.  On my machine
(Debian Linux "testing") the package that provides that file is libkrb5-dev.

Even if you're not using Debian, or Linux, this page may help you locate
which packages on your system may contain a given missing file:

http://www.debian.org/distrib/packages#search_contents

Entering krb5.h in the "Search the contents of packages" box brings up a
list of packages containing files ending in "krb5.h", one (likely
example of which) is libkrb5-dev.

--Pete

> XXXXXXX:/apps/mds_lrt/git/git> git version
> git version 1.5.3.2
> 
> Can someone tell me how to resolve it ?
> 
> thanks,
> Horry
