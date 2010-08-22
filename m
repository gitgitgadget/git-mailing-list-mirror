From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: What's cooking in git.git (Aug 2010, #05; Sat, 21)
Date: Sun, 22 Aug 2010 15:34:12 +0300
Message-ID: <20100822123412.GA22353@LK-Perkele-V2.elisa-laajakaista.fi>
References: <7v4oen5clj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 22 14:34:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On9kU-0004up-JA
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 14:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab0HVMdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 08:33:51 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:56403 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab0HVMdu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 08:33:50 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id C6F9BEB9C2;
	Sun, 22 Aug 2010 15:33:48 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A029CFBF69E; Sun, 22 Aug 2010 15:33:48 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id AD12E1C6387;
	Sun, 22 Aug 2010 15:33:46 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7v4oen5clj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154181>

On Sun, Aug 22, 2010 at 12:30:00AM -0700, Junio C Hamano wrote:
> 
> * il/rfc-remote-fd-ext (2010-08-14) 6 commits
>  - Fix build on Windows
>  - Simplify send_git_request()
>  - Rewrite bidirectional traffic loop
>  - gitignore: Ignore the new /git-remote-{ext,fd} helpers
>  - New remote helper: git-remote-ext
>  - New remote helper git-remote-fd
> 
> I haven't heard anything about this series.  Is it desirable?  Or is it
> not used by anybody and just another baggage we'd rather not carry?

Well, as said in series introduction, some possible uses:
- ssh with odd options without editing ssh_config (this ocassionally pops up
on #git, especially with keypair setting, dunno how much of that is
XY-problem and how much is not).
- TLS-tunneling git://.
- etc...

And yes, I use it a lot internally.

-Ilari
