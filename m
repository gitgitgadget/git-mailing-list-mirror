From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [test failure] Re: t4114 binary file becomes symlink
Date: Sun, 19 Jul 2009 00:03:55 +0200
Message-ID: <200907190003.56137.j6t@kdbg.org>
References: <20090718134551.GC16708@vidovic> <200907182106.06776.j6t@kdbg.org> <20090718201721.GF16708@vidovic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sun Jul 19 00:04:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSI15-0004TF-6o
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 00:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbZGRWED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 18:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753768AbZGRWEC
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 18:04:02 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:9867 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753764AbZGRWEB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 18:04:01 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EF9F4A7EB3;
	Sun, 19 Jul 2009 00:03:56 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B2110425D5;
	Sun, 19 Jul 2009 00:03:56 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090718201721.GF16708@vidovic>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123538>

On Samstag, 18. Juli 2009, Nicolas Sebrecht wrote:
>   ./configure --prefix=/home/nicolas/bin
>   make
>   make install

If you are on Linux and only want a special prefix, you don't 
need ./configure; just:

   echo prefix=/home/nicolas/bin > config.mak
   make && make install

-- Hannes
