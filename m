From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH RFC 09/10] send-email: Minor cleanup of =?utf-8?b?JHNtdHBfc2VydmVy?= usage and =?utf-8?b?c2VuZF9tZXNzYWdlKCk=?=
Date: Sat, 11 Apr 2009 21:58:14 +0000 (UTC)
Message-ID: <loom.20090411T215335-597@post.gmane.org>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com> <1239476908-25944-2-git-send-email-mfwitten@gmail.com> <1239476908-25944-3-git-send-email-mfwitten@gmail.com> <1239476908-25944-4-git-send-email-mfwitten@gmail.com> <1239476908-25944-5-git-send-email-mfwitten@gmail.com> <1239476908-25944-6-git-send-email-mfwitten@gmail.com> <1239476908-25944-7-git-send-email-mfwitten@gmail.com> <1239476908-25944-8-git-send-email-mfwitten@gmail.com> <1239476908-25944-9-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 12 00:00:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LslFS-00057b-0w
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 00:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447AbZDKV6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 17:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbZDKV6j
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 17:58:39 -0400
Received: from main.gmane.org ([80.91.229.2]:53744 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395AbZDKV6i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 17:58:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LslDe-00061e-9P
	for git@vger.kernel.org; Sat, 11 Apr 2009 21:58:34 +0000
Received: from h-68-164-64-249.lsanca54.dynamic.covad.net ([68.164.64.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 21:58:34 +0000
Received: from bebarino by h-68-164-64-249.lsanca54.dynamic.covad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 21:58:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 68.164.64.249 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.8) Gecko/2009032609 Firefox/3.0.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116356>

Michael Witten <mfwitten <at> gmail.com> writes:

> 
>  	be specified by the 'sendemail.smtpserver' configuration
>  	option; the built-in default is `/usr/sbin/sendmail` or
>  	`/usr/lib/sendmail` if such program is available, or
> -	`localhost` otherwise.
> +	`127.0.0.1` otherwise. Also, if <host> is the empty string,
> +	then a built-in default is used.

Does this help anyone? localhost at least doesn't change when/if ipv6 is used,
whereas '127.0.0.1' is only for ipv4.
