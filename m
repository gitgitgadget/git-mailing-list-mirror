From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git push asking for a password
Date: Mon, 26 Jul 2010 21:30:58 +0300
Message-ID: <20100726183058.GA29313@LK-Perkele-V2.elisa-laajakaista.fi>
References: <29265051.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: brennsuppa <joe@bastarde.at>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:30:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSR7-0004Lc-Nx
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab0GZS34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 14:29:56 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:43095 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab0GZS3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:29:55 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 93F5A13B487;
	Mon, 26 Jul 2010 21:29:53 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A051A890169; Mon, 26 Jul 2010 21:29:53 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 6BA361C6382;
	Mon, 26 Jul 2010 21:29:51 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <29265051.post@talk.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151874>

On Mon, Jul 26, 2010 at 03:31:20AM -0700, brennsuppa wrote:
> 
> Hi,
> 
> I'm working with git for the first time and when I started it I just had to
> commit/push/pull on an existing repository.
> 
> Now I should create a new repo, but this fails when I try to git push origin
> master:refs/heads/master because it is asking for a password, which should
> not happen since ssh-keys are in use, right?

<Snip secition some repos working and some not>

The password prompts come from SSH, not git. And there only user and host
specified in URL matter.

BTW: 'git push origin master:refs/heads/master' can be shortened as
'git push origin master' if 'master' is a branch (it usually is). This isn't
the problem however.

Few possible problems:

- The URL points to wrong host or host alias
- The username in URL is wrong
- You are trying access from different computer/user that doesn't have valid
keys for that system.

-Ilari
