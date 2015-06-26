From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/7] git-stash: use git-reflog instead of creating files
Date: Fri, 26 Jun 2015 15:14:30 -0700
Message-ID: <xmqqegkyrubd.fsf@gitster.dls.corp.google.com>
References: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
	<1435278548-3790-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 00:14:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8btP-0004Tt-1i
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 00:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbbFZWOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 18:14:33 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35487 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbbFZWOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 18:14:32 -0400
Received: by iebrt9 with SMTP id rt9so84339395ieb.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=msAQxEi5EpK11O2zWzNhsWct2dr2kP+jDil+vfsmfgg=;
        b=zDZwNh2MsYCSdon0WlD7+H/EBwbo/FzeS6o9w2z0Ut5ZO6A7o+FytL2YsdF9sniLtf
         51KQxBCi62PSz//EZ/8vFdImcfFRXfDx4jFHl+4yt/BaJ2Q0PPRQWdh5NrmbEsy3mK0M
         AvujX1yhlbjSl+LZCQS9V3ixqYnO3k8RMcnZfHeIgx/5Nc3SMBdASuTYKXpykta08Wzn
         Ry+KvElu8yRex9I4K979DyPDj9UxnABUsUnKVudz+7/VgAiYNQGdMmG1/qFuNgm05bbH
         /HBReVQY/3rirPaACxRESuILp68lWIkdsvzr0s1appBuV6KfOKS2/rfODj402lIMbBCQ
         Yfjg==
X-Received: by 10.42.30.208 with SMTP id w16mr5881018icc.88.1435356872163;
        Fri, 26 Jun 2015 15:14:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id d4sm146570igl.1.2015.06.26.15.14.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 15:14:31 -0700 (PDT)
In-Reply-To: <1435278548-3790-7-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 25 Jun 2015 20:29:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272836>

David Turner <dturner@twopensource.com> writes:

> This is in support of alternate ref backends which don't necessarily
> store reflogs as files.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

6/7 and 7/7 looked sensible; "git reflog create/exists" needs a doc
update, though.

Thanks.
