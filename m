From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: update 'git commit' completion
Date: Sat, 5 Dec 2009 13:17:03 -0800
Message-ID: <20091205211703.GC5610@spearce.org>
References: <1259974301-11593-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER G??bor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Dec 05 22:17:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH209-0004Ep-HW
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 22:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756486AbZLEVRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 16:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755600AbZLEVRA
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 16:17:00 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:59774 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805AbZLEVQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 16:16:59 -0500
Received: by gxk26 with SMTP id 26so3185333gxk.1
        for <git@vger.kernel.org>; Sat, 05 Dec 2009 13:17:06 -0800 (PST)
Received: by 10.91.50.26 with SMTP id c26mr1734120agk.77.1260047825965;
        Sat, 05 Dec 2009 13:17:05 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm2185847iwn.15.2009.12.05.13.17.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 13:17:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1259974301-11593-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134623>

SZEDER G??bor <szeder@ira.uka.de> wrote:
> I just wanted to add the recently learnt '--reset-author' option, but
> then noticed that there are many more options missing.  This patch
> adds support for all of 'git commit's options, except '--allow-empty',
> because it is primarily there for foreign scm interfaces.
> 
> Furthermore, this patch also adds support for completing the arguments
> of those options that take a non-filename argument: valid modes are
> offered for '--cleanup' and '--untracked-files', while refs for
> '--reuse-message' and '--reedit-message', because these two take a
> commit as argument.
> 
> Signed-off-by: SZEDER G??bor <szeder@ira.uka.de>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

>  contrib/completion/git-completion.bash |   22 +++++++++++++++++++++-
>  1 files changed, 21 insertions(+), 1 deletions(-)

-- 
Shawn.
