From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Smart-http: check if repository is OK to export
	before serving it
Date: Sun, 27 Dec 2009 13:10:33 -0800
Message-ID: <20091227211033.GB609@spearce.org>
References: <7vk4w963np.fsf@alter.siamese.dyndns.org> <1261870153-57572-1-git-send-email-tarmigan+git@gmail.com> <1261870153-57572-2-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	rctay89@gmail.com, drizzd@aon.at, warthog9@kernel.org
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 27 22:10:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP0Nu-0005C7-Tl
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 22:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbZL0VKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 16:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbZL0VKi
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 16:10:38 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:38410 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbZL0VKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 16:10:38 -0500
Received: by yxe17 with SMTP id 17so8951736yxe.33
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 13:10:37 -0800 (PST)
Received: by 10.150.250.21 with SMTP id x21mr21693637ybh.181.1261948236948;
        Sun, 27 Dec 2009 13:10:36 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm10420105iwn.12.2009.12.27.13.10.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Dec 2009 13:10:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1261870153-57572-2-git-send-email-tarmigan+git@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135714>

Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
> Similar to how git-daemon checks whether a repository is OK to be
> exported, smart-http should also check.  This check can be satisfied
> in two different ways: the environmental variable GIT_HTTP_EXPORT_ALL
> may be set to export all repositories, or the individual repository
> may have the file git-daemon-export-ok.
> 
> Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

I really think this and 1/2 should be squashed together, in which
case you can apply my ACK to the entire thing.

-- 
Shawn.
