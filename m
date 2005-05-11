From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: GIT compile error on Sun Sparc SB2000
Date: Wed, 11 May 2005 16:57:14 +0400
Message-ID: <200505111657.14424.snake@penza-gsm.ru>
References: <200505111141.27725.snake@penza-gsm.ru> <1115809273.16187.493.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 11 14:50:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVqf0-0001pk-Dt
	for gcvg-git@gmane.org; Wed, 11 May 2005 14:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVEKM5V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 08:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVEKM5V
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 08:57:21 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:55269
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261195AbVEKM5S
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 08:57:18 -0400
Received: (qmail 14142 invoked from network); 11 May 2005 12:57:16 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 11 May 2005 12:57:15 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <1115809273.16187.493.camel@hades.cambridge.redhat.com>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-105.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	USER_IN_WHITELIST autolearn=ham version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wensday, 11 May 2005 15:01 David Woodhouse wrote:
> On Wed, 2005-05-11 at 11:41 +0400, Alexey Nezhdanov wrote:
> > /usr/bin/ld: skipping incompatible /usr/lib/libz.so when searching for
> > -lz /usr/bin/ld: skipping incompatible /usr/lib/libz.a when searching for
> > -lz /usr/bin/ld: cannot find -lz
>
> Libraries which are in /usr/lib as opposed to /usr/lib64 are presumably
> 64-bit. Since the linker is claiming that they're incompatible, I assume
> your compiler is defaulting to 64-bit output. Try adding '-m32' to
> CFLAGS, or installing 64-bit libz.
Thank you very much.
-m32 helped.
64bits libz and libcurl are missing.

-- 
Respectfully
Alexey Nezhdanov

