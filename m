From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT+CYGWIN annoying test failure
Date: Thu, 15 Feb 2007 02:37:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702150236590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45B6C1FB.7060005@gmail.com>
 <Pine.LNX.4.63.0701241041190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45BD4AA9.5090400@gmail.com> <45D3AF9B.40205@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, GIT <git@vger.kernel.org>
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 02:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHVZ4-0000I1-Qf
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 02:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbXBOBhg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 20:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbXBOBhf
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 20:37:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:38952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751482AbXBOBhf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 20:37:35 -0500
Received: (qmail invoked by alias); 15 Feb 2007 01:37:34 -0000
X-Provags-ID: V01U2FsdGVkX1+9xEolVT+9BFCp4IyugS0ix7DY84LIAhSCfWbU4C
	po8g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D3AF9B.40205@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39786>

Hi,

On Thu, 15 Feb 2007, SungHyun Nam wrote:

>  check_result () {
> +    [ -r current ] && rm -f current
>      git-ls-files --stage | sed -e 's/ '"$_x40"' / X /' >current &&
>      diff -u expected current
>  }

Are you having a restrictive umask, or what are the permissions on that 
file?

Ciao,
Dscho
