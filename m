From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] pass config slots as pointers instead of offsets
Date: Tue, 14 Oct 2014 10:46:30 -0700
Message-ID: <20141014174630.GC32245@google.com>
References: <xmqqk342zgvm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 19:46:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe6BF-00073L-LN
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 19:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbaJNRqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 13:46:37 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50753 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369AbaJNRqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 13:46:36 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so8299977pad.33
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TGHOC5MxikfsNQVo4ugo7wRjnlTThmZ88gTAXV+6PgU=;
        b=1IbNz8Jl0Xt7vyYbodouwaCsyOD4u9YjT2EvabQH7TmDWTo7YlQ5MhLlbvZ9QGyowP
         +1WTjNDDc1pFK9TiCB0fLW9FkHVoVVaxDOo3BtzoNAz5wqZUpvJW47fl65+CKTpDZ8xj
         Zh5sLfAjlNudK5s7O5AvTP+oLbWROqExivILKq0wFYfV5rlKfPWXtBnIIkreuRGACIK5
         zXEtJZwrS39GT0SQvT48wCE4lgrw/7LExUhKUMjiUEXhGqfC1ZwZdGXv21SNV+n7QeqF
         2rFnbMCKB2ip1qrnZP4DZS2dFtRBLtZ0Exgn4eHsMsY7uLQIw/UWS07F7MKNglJtUvOD
         t0qg==
X-Received: by 10.68.234.103 with SMTP id ud7mr6907912pbc.46.1413308795929;
        Tue, 14 Oct 2014 10:46:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c60:55d9:7b8c:4ce4])
        by mx.google.com with ESMTPSA id ve10sm14749848pbc.65.2014.10.14.10.46.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 10:46:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqk342zgvm.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

>  builtin/branch.c | 16 ++++++++--------
>  builtin/commit.c | 19 +++++++++----------
>  builtin/log.c    |  2 +-
>  log-tree.c       |  4 ++--
>  log-tree.h       |  2 +-
>  5 files changed, 21 insertions(+), 22 deletions(-)

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
