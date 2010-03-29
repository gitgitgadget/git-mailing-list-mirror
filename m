From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] Documentation/urls: Add <transport>::<address> syntax
Date: Mon, 29 Mar 2010 19:01:48 +0300
Message-ID: <20100329160148.GB31829@LK-Perkele-V2.elisa-laajakaista.fi>
References: <f3271551003290810u4edbbbd0x2432bc7411333800@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 18:02:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwHPs-0000Bo-Od
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 18:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab0C2QCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:02:12 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:38023 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0C2QCK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:02:10 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 4A7918C94B;
	Mon, 29 Mar 2010 19:02:09 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05A9E3C98D; Mon, 29 Mar 2010 19:02:09 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id EDE59158A6B;
	Mon, 29 Mar 2010 19:01:59 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <f3271551003290810u4edbbbd0x2432bc7411333800@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143488>

On Mon, Mar 29, 2010 at 08:40:07PM +0530, Ramkumar Ramachandra wrote:
> Add <transport>::<address> syntax for explicitly invoking a remote
> helper.
> ---
>  Documentation/urls.txt |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index 459a394..041cbfe 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -30,6 +30,11 @@ To sync with a local directory, you can use:
>  - /path/to/repo.git/
>  - file:///path/to/repo.git/
> 
> +To explicity request a remote helper for a certain transport protocol,
> +you can use:
> +
> +- <transport>::path/to/repo.git
> +

Except that what follows <transport>:: part depends on remote helper. For
some helpers it may be a path. And for such helpers, it probably won't
be git repository (so no .git ending). For other helpers, it might be
server and path. Or something even more exotic.

-Ilari
