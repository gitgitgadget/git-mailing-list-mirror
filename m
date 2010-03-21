From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/14] jn/merge-diff3-label
Date: Sat, 20 Mar 2010 19:25:36 -0500
Message-ID: <20100321002535.GA23681@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:24:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt8yD-0004hq-07
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab0CUAYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 20:24:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:65044 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab0CUAYi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:24:38 -0400
Received: by gwaa18 with SMTP id a18so395219gwa.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MJyciCmupXOJTw8CM4q9ZWLVoi9AZXtjNgBheZdRJvc=;
        b=W+j5uDo9jdhj/54i8Xe3uCqgCxBS5/VcLk5mbgaxzSoD4djnUPp4wfytQYM57e2928
         wrNbC+1/PTy7cCOvNH73cZLUdaZC+c7TgD2u57UvF5h2lwuNoegPPUh4nS9uaAlzmAGl
         Zn0XCVr1LPanD+fDyO/Z9+TGhQ0f2/uHneteE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ua7YdWPyFk6wOExJnmE9eZIBH44vadbsBvtsXcDjjAvENFGIO0yUO9E3WaMImQrJwn
         uZsVmk+9DDKhvgbRJUC2Lo1FiV8ilCD04ghwxfHw0PrQV8Vj5EzThhtZU8ST4pjMbG68
         SUoJXBZjfZxFGaUALJ3t4XD0pU8U6cd8LmXI8=
Received: by 10.100.78.2 with SMTP id a2mr11972112anb.23.1269131077935;
        Sat, 20 Mar 2010 17:24:37 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1291851iwn.8.2010.03.20.17.24.37
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:24:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142768>

Junio C Hamano wrote:

> * jn/merge-diff3-label (2010-03-17) 13 commits
>  . cherry-pick, revert: add a label for ancestor
>  . revert: clarify label on conflict hunks
>  . compat: add mempcpy()
>  . tests: document cherry-pick behavior in face of conflicts
>  . checkout -m --conflict=diff3: add a label for ancestor
>  . tests: document format of conflicts from checkout -m
>  . merge_trees(): add ancestor label parameter for diff3-style output
>  . merge_file(): add comment explaining behavior wrt conflict style
>  . checkout --conflict=diff3: add a label for ancestor
>  . ll_merge(): add ancestor label parameter for diff3-style output
>  . merge-file --diff3: add a label for ancestor
>  . xdl_merge(): move file1 and file2 labels to xmparam structure
>  . xdl_merge(): add optional ancestor label to diff3-style output
> 
> This somewhat conflicts with bw/union-merge-refactor that in 'master'; I
> could resolve the conflicts myself, but I'd rather not.  Jonathan, could
> you rebase the series?

Sure thing.  Here is the latest verison.

Jonathan Nieder (14):
  tests: document format of conflicts from checkout -m
  tests: document cherry-pick behavior in face of conflicts
  xdl_merge(): add optional ancestor label to diff3-style output
  xdl_merge(): move file1 and file2 labels to xmparam structure
  merge-file --diff3: add a label for ancestor
  ll_merge(): add ancestor label parameter for diff3-style output
  checkout --conflict=diff3: add a label for ancestor
  merge_file(): add comment explaining behavior wrt conflict style
  merge_trees(): add ancestor label parameter for diff3-style output
  checkout -m --conflict=diff3: add a label for ancestor
  compat: add mempcpy()
  revert: clarify label on conflict hunks
  cherry-pick, revert: add a label for ancestor
  merge-recursive: add a label for ancestor

 builtin/checkout.c              |    3 +-
 builtin/merge-file.c            |    6 +-
 builtin/revert.c                |  103 +++++++++++++--------
 git-compat-util.h               |    9 ++
 ll-merge.c                      |   24 +++--
 ll-merge.h                      |    2 +-
 merge-file.c                    |    8 ++-
 merge-recursive.c               |   12 ++-
 merge-recursive.h               |    1 +
 rerere.c                        |    4 +-
 t/t3507-cherry-pick-conflict.sh |  198 +++++++++++++++++++++++++++++++++++++++
 t/t6023-merge-file.sh           |    4 +-
 t/t7201-co.sh                   |   69 ++++++++++++-
 xdiff/xdiff.h                   |    6 +-
 xdiff/xmerge.c                  |   35 +++++--
 15 files changed, 405 insertions(+), 79 deletions(-)
 create mode 100644 t/t3507-cherry-pick-conflict.sh
