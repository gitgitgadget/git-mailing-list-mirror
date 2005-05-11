From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: GIT compile error on Sun Sparc SB2000
Date: Wed, 11 May 2005 13:32:38 +0400
Message-ID: <200505111332.38491.snake@penza-gsm.ru>
References: <200505111141.27725.snake@penza-gsm.ru> <4281BBC4.8060709@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 11 11:25:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVnSt-0002E9-50
	for gcvg-git@gmane.org; Wed, 11 May 2005 11:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVEKJcq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 05:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVEKJcq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 05:32:46 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:22747
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261940AbVEKJcn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 05:32:43 -0400
Received: (qmail 28655 invoked from network); 11 May 2005 09:32:41 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 11 May 2005 09:32:38 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <4281BBC4.8060709@dgreaves.com>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-105.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	TW_LR,TW_RW,TW_WX,USER_IN_WHITELIST autolearn=ham version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wensday, 11 May 2005 12:01 David Greaves wrote:
> Alexey Nezhdanov wrote:
> >Hello. GIT refuses to compile on Debian sarge on sparc64.
> >Probably some compile flag is incompartible but can't figure out which.
>
> read the error message:
> >/usr/bin/ld: skipping
> >incompatible /usr/lib/gcc-lib/sparc-linux/3.3.3/../../../libz.so when
>
> hmm...
> libz.so
>
> >/usr/bin/ld: cannot find -lz
>
> Can't find often equals "not installed"
webmaster@www:/tmp/cogito-0.10$ ls -l /usr/lib/libz.so
lrwxr-xr-x    1 root     root            9 2005-05-11 11:18 /usr/lib/libz.so 
-> libz.so.1
webmaster@www:/tmp/cogito-0.10$ ls -l /usr/lib/libz.a 
-rw-r--r--    1 root     root        83610 2004-12-07 21:38 /usr/lib/libz.a

>
> So go to aptitude, search for zlib
> You'll find libz-dev
> Install it
>
> Or just run
> apt-get install libz-dev
>
> And try again
Nope, not helped.
www:/home/snake# apt-get install libz-dev
Reading Package Lists... Done
Building Dependency Tree... Done
Note, selecting zlib1g-dev instead of libz-dev
zlib1g-dev is already the newest version.
0 upgraded, 0 newly installed, 0 to remove and 307 not upgraded.
www:/home/snake# 
>
> David
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Respectfully
Alexey Nezhdanov

