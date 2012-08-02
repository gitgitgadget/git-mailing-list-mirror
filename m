From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC 0/16] Introduce index file format version 5
Date: Thu, 2 Aug 2012 19:10:57 +0700
Message-ID: <CACsJy8De=1RR9yAQ79zzNM_iALF1OCB2L9A8pMK_v+ixZqgJug@mail.gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 14:11:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwuFa-0004bN-56
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 14:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab2HBML3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 08:11:29 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62250 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab2HBML2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 08:11:28 -0400
Received: by yhmm54 with SMTP id m54so8606490yhm.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nxRcEgUT5nAwfZ7FMsQtAHN+vplr+zzxm8255YLlY4k=;
        b=wb16WioOY0GRBUHxpMx5B8YYS+80cvPL8b7FKqvVc5dmy3uMdvWwZzqntu+dHL+0dD
         MwCLj0b+PynFTKQ5KmqoNFvpkRZX+eXjvWV9QsaTpLg1rlyVTafnU03FGzxAaCMwOiK7
         W15yXlVMV+jjyTHLv5YKqpNMx4KA9udKFV960JNsBzjsjCT7gWX471+Jb3rIDAGVBiuS
         Y6zlNPJ8YSBrq5kUwaK47oMhxFGm+xqm3h+0DvfCUvkr0I8LAxza5h0DPDhIZWv6GXC/
         KULTGyK76GWoPPh/o8fsttPBRIiy7tIyQtcxkzLE93Gz87f25WXMQPTHihG+4wrNSgyz
         o3OA==
Received: by 10.42.145.7 with SMTP id d7mr3605935icv.45.1343909487892; Thu, 02
 Aug 2012 05:11:27 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Thu, 2 Aug 2012 05:10:57 -0700 (PDT)
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202769>

On Thu, Aug 2, 2012 at 6:01 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Documentation/technical/index-file-format-v5.txt |  281 ++++++++++++++++++++++++++++++++++
> builtin/update-index.c                           |    5 +-
> cache-tree.c                                     |  145 ++++++++++++++++++
> cache-tree.h                                     |    7 +
> cache.h                                          |   96 +++++++++++-
> read-cache.c                                     | 1519 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
> resolve-undo.c                                   |  129 ++++++++++++++++
> resolve-undo.h                                   |    3 +
> t/perf/p0002-index.sh                            |   33 ++++
> t/t2104-update-index-skip-worktree.sh            |   15 +-
> t/t3700-add.sh                                   |    1 +
> test-index-version.c                             |    2 +-
> 12 files changed, 2082 insertions(+), 154 deletions(-)

This is not good (too many pluses in read-cache.c) if it comes from
format-patch. Does it?
-- 
Duy
