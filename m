From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH v7, resend] gitweb: ref markers link to named shortlogs
Date: Tue, 2 Sep 2008 23:15:50 +0200
Message-ID: <20080902211550.GR10360@machine.or.cz>
References: <1220384825-19824-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:17:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KadFE-0003Yw-W3
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 23:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbYIBVPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 17:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbYIBVPz
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 17:15:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49779 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490AbYIBVPy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 17:15:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2B2513939B42; Tue,  2 Sep 2008 23:15:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220384825-19824-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94716>

On Tue, Sep 02, 2008 at 09:47:05PM +0200, Giuseppe Bilotta wrote:
> This patch turns ref markers for tags and heads into links to
> appropriate views for the ref name, depending on current context.
> 
> For annotated tags, we link to the tag view, unless that's the current
> view, in which case we switch to shortlog. For other refs, we prefer the
> current view if it's history or (short)log, and default to shortlog
> otherwise.
> 
> Appropriate changes are made in the CSS to prevent ref markers from
> being annoyingly blue and underlined, unless hovered. A visual
> indication of the target view difference is also implemented by making
> annotated tags show up in italic.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Petr Baudis <pasky@suse.cz>
