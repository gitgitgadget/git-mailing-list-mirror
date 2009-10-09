From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Speedup bash completion loading
Date: Fri, 9 Oct 2009 09:14:43 -0700
Message-ID: <20091009161443.GX9261@spearce.org>
References: <4e0a90ed0910051218oaa64b94jd12a6678934523ac@mail.gmail.com> <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org> <20091008132718.GA12161@tugrik.mns.mnsspb.ru> <20091008150206.GD9261@spearce.org> <20091009090958.GA4758@tugrik.mns.mnsspb.ru> <20091009144606.GT9261@spearce.org> <20091009152149.GA26171@tugrik.mns.mnsspb.ru> <20091009153936.GV9261@spearce.org> <20091009160856.GA26833@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 18:16:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwI8V-0000xi-84
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 18:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933864AbZJIQPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 12:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933862AbZJIQPV
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 12:15:21 -0400
Received: from george.spearce.org ([209.20.77.23]:54152 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933861AbZJIQPU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 12:15:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DF4E0381FF; Fri,  9 Oct 2009 16:14:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091009160856.GA26833@tugrik.mns.mnsspb.ru>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129822>

Kirill Smelkov <kirr@mns.spb.ru> wrote:
> Now I see, OK. Here is the patch which should be applied on top of
> Stephen's 1/2:
> 
> ---- 8< ----
> From: Kirill Smelkov <kirr@mns.spb.ru>
> Date: Mon, 5 Oct 2009 13:36:15 +0400
> Subject: [PATCH v4] Speedup bash completion loading

Acked-by: Shawn O. Pearce <spearce@spearce.org>
 
>  contrib/completion/.gitignore                      |    1 +
>  contrib/completion/Makefile                        |   11 ++
>  contrib/completion/git-completion.bash.generate    |  128 ++++++++++++++++
>  ...{git-completion.bash => git-completion.bash.in} |  161 +++-----------------
>  4 files changed, 162 insertions(+), 139 deletions(-)
>  create mode 100644 contrib/completion/.gitignore
>  create mode 100644 contrib/completion/Makefile
>  create mode 100755 contrib/completion/git-completion.bash.generate
>  rename contrib/completion/{git-completion.bash => git-completion.bash.in} (90%)
>  mode change 100755 => 100644

-- 
Shawn.
