From: Sam Vilain <sam@vilain.net>
Subject: Re: is gitosis secure?
Date: Tue, 09 Dec 2008 22:04:13 +1300
Message-ID: <1228813453.28186.73.camel@maia.lan>
References: <200812090956.48613.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, dabe@ymc.ch
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Tue Dec 09 20:48:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA8Yv-000736-JA
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 20:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596AbYLITqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 14:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754599AbYLITqi
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 14:46:38 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:43022 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754287AbYLITqh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 14:46:37 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 96D0521C3E1; Wed, 10 Dec 2008 08:46:35 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	DATE_IN_PAST_06_12 autolearn=no version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id DF3BF21C32D;
	Wed, 10 Dec 2008 08:46:30 +1300 (NZDT)
In-Reply-To: <200812090956.48613.thomas@koch.ro>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102653>

On Tue, 2008-12-09 at 09:56 +0100, Thomas Koch wrote:
> Sorry for the shameless subject, but I presented gitosis yesterday to
> our sysadmin and he wasn't much delighted to learn, that write access to
> repositories hosted with gitosis would need SSH access.
> 
> So could you help me out in this discussion, whether to use or not to
> use gitosis? 
> Our admin would prefer to not open SSH at all outside our LAN, but
> developers would need to have write access also outside the office.

Restricted unix shells are a technology which has been proven secure for
decades now.  If you use git-shell, you are keeping the secure part of
SSH - the authentication and encryption - and restricting the SSH access
part to the bare minimum required for useful access to the required
services.

ie ... it all comes down to the shell you give those 'login' users as to
what they can do.

Sam.
