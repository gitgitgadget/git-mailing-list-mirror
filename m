From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: gitweb sets incorrect <base> header
Date: Wed, 29 Apr 2009 11:22:13 +0200
Message-ID: <gt9685$l9g$1@ger.gmane.org>
References: <877i15uf14.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 11:24:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz628-0003iE-Su
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 11:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758323AbZD2JWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 05:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758303AbZD2JWc
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 05:22:32 -0400
Received: from main.gmane.org ([80.91.229.2]:45542 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758260AbZD2JWb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 05:22:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lz5zp-0003Vy-4F
	for git@vger.kernel.org; Wed, 29 Apr 2009 09:22:29 +0000
Received: from nat.ct.ingv.it ([193.206.223.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 09:22:29 +0000
Received: from giuseppe.bilotta by nat.ct.ingv.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 09:22:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat.ct.ingv.it
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117871>

On Tuesday 28 April 2009 14:41, Peter Simons wrote:
> after a recent gitweb update to revision v1.6.3-rc3-12-gb79376c, the CGI now
> generates an incorrect <base> header. For example, the first "patch" on the
> page
> 
>   http://git.cryp.to/fastcgi/commitdiff/9ad9965b3fa293c458df14391f181f2f8f1197cd
> 
> erroneously refer to http://git.cryp.to/cgi-bin/gitweb.cgi#patch1, but that

Both in Konqueror and Opera the patch link on that page refers to 

http://git.cryp.to/fastcgi/patch/9ad9965b3fa293c458df14391f181f2f8f1197cd

which is quite correct.

> page doesn't exist. It appears that $base_url is not determined correctly.
> 
> Does anyone have a clue how that problem can be fixed?

OTOH by looking at the source I see

<base href="http://git.cryp.to/cgi-bin/gitweb.cgi" />

which doesn't seem correct at all. Do you have something in the gitweb config
that may be hard-coding the base url?

-- 
Giuseppe "Oblomov" Bilotta
