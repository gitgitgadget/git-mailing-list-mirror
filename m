From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Tue, 02 Feb 2016 15:08:54 -0500
Organization: Twitter
Message-ID: <1454443734.5545.1.camel@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Feb 02 21:09:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQhG2-0000o1-4A
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 21:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757833AbcBBUI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 15:08:58 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34991 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822AbcBBUI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 15:08:57 -0500
Received: by mail-qk0-f171.google.com with SMTP id o6so71190249qkc.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 12:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=53ADwOCKaAd3seSRlHuz/hI0h5f8iOMKoNNa6Ig4iwU=;
        b=fu8v5Jo7KzWZml9wB0LkZ0hCLQFO+BhCHswV6FYw2HSgY9UCsIWOVHhaLN0GVKRtLT
         BGtycQMgxsx7iAcT4RSlDRYIfB7+FOQOE6zmk90Za3u8HGUdqfyL0EbRAqTu/16l7oZ8
         XMGGxHaoegDsiBI3P49GLjKHZPDP1NumVCjCv20i9dxGVc33cIyXHCTrc8l8GjbroNtB
         YeRIfEcLaRq/hcRnHgKw1Tcp8XwE37XIyvMkSJoo8gS5+0TrcIik9vItnlF5QUXE7nAQ
         HVaCcUkOPQg1LbKJzvfn8dW+vVrDc9m6zQfHlvXB2soB/JDpcCfvOExd0HYbtMi5ilxA
         2vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=53ADwOCKaAd3seSRlHuz/hI0h5f8iOMKoNNa6Ig4iwU=;
        b=Ce6yJdVvvDp1CBKVek5E9XZH3RzYL7GhRMB1XrK+z36+E1xmQI9q/CmCd86D3wt0cX
         ZkWIMZSXoIjUcidCDET6sabS/jToKrvlkM5siXHkMqZwXmu6Sb5+se5u/jXrrifSr/K4
         zdQ/afRxVyp3uCYUzzHOqwCvywtwS6uJMVZKbpTlNaQrotRrPlThkofvT5WMEHfGGgzF
         g+82L3dL1kMycJ/Yx7kwgyk0lpAATVoT/MnqyheEdxsuMF+P9X7K/io3aBIDZpZMGAY4
         hoxtg+tZysouBE78cswrGBeLX8Hd523mvWko6i8FTG4GPuXYTORolbSyE/fHV//dOpsF
         VEEg==
X-Gm-Message-State: AG10YOQpMYjcN0ngOmhIniUgku4hZ41q1XysvAmxLWQSYWkkg0KCx/rXK1Or76fjvVot0A==
X-Received: by 10.55.78.198 with SMTP id c189mr37645892qkb.95.1454443736587;
        Tue, 02 Feb 2016 12:08:56 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id p188sm1442879qhb.34.2016.02.02.12.08.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Feb 2016 12:08:55 -0800 (PST)
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285302>

Are there any more reviews on this?  I do have some changes from this
set, but they're pretty minor so I don't want to post a new one (unless
folks would rather see those changes before reviewing).  Let me know.

Thanks.

On Thu, 2016-01-14 at 11:25 -0500, David Turner wrote:
> I rebased this on top of 20fabf9b194c4099d329582c734e433f9f6586a3
> (the
> commit before the previous version of this series).
> 
> This entailed removing Michael Haggerty's patch to builtin/clone.c,
> since a patch by Stefan already did approximately the same thing.
> 
> There was a somewhat hairy merge of "resolve symbolic refs first",
> but
> I think the new one is fine (the same tests all pass except for the
> one TODO noted in the lmdb code).
> 
> David Turner (17):
>   refs: add do_for_each_per_worktree_ref
>   refs: add methods for reflog
>   refs: add method for initial ref transaction commit
>   refs: add method for delete_refs
>   refs: add methods to init refs db
>   refs: add method to rename refs
>   refs: make lock generic
>   refs: move duplicate check to common code
>   refs: allow log-only updates
>   refs: resolve symbolic refs first
>   refs: always handle non-normal refs in files backend
>   init: allow alternate backends to be set for new repos
>   refs: check submodules ref storage config
>   refs: allow ref backend to be set for clone
>   svn: learn ref-storage argument
>   refs: add LMDB refs backend
>   refs: tests for lmdb backend
> 
> Ronnie Sahlberg (3):
>   refs: add a backend method structure with transaction functions
>   refs: add methods for misc ref operations
>   refs: add methods for the ref iterators
> 
>  .gitignore                                     |    1 +
>  Documentation/config.txt                       |    7 +
>  Documentation/git-clone.txt                    |    6 +
>  Documentation/git-init-db.txt                  |    2 +-
>  Documentation/git-init.txt                     |    7 +-
>  Documentation/technical/refs-lmdb-backend.txt  |   52 +
>  Documentation/technical/repository-version.txt |    5 +
>  Makefile                                       |   12 +
>  builtin/clone.c                                |    5 +
>  builtin/init-db.c                              |   40 +-
>  builtin/submodule--helper.c                    |    2 +-
>  cache.h                                        |    2 +
>  config.c                                       |   29 +
>  configure.ac                                   |   33 +
>  contrib/workdir/git-new-workdir                |    3 +
>  git-submodule.sh                               |   13 +
>  git-svn.perl                                   |    6 +-
>  path.c                                         |   29 +-
>  refs.c                                         |  451 +++++-
>  refs.h                                         |   17 +
>  refs/files-backend.c                           |  397 +++--
>  refs/lmdb-backend.c                            | 2051
> ++++++++++++++++++++++++
>  refs/refs-internal.h                           |  128 +-
>  setup.c                                        |   23 +-
>  t/t0001-init.sh                                |   24 +
>  t/t1460-refs-lmdb-backend.sh                   | 1109 +++++++++++++
>  t/t1470-refs-lmdb-backend-reflog.sh            |  359 +++++
>  t/t1480-refs-lmdb-submodule.sh                 |   85 +
>  t/test-lib.sh                                  |    1 +
>  test-refs-lmdb-backend.c                       |   64 +
>  transport.c                                    |    7 +-
>  31 files changed, 4767 insertions(+), 203 deletions(-)
>  create mode 100644 Documentation/technical/refs-lmdb-backend.txt
>  create mode 100644 refs/lmdb-backend.c
>  create mode 100755 t/t1460-refs-lmdb-backend.sh
>  create mode 100755 t/t1470-refs-lmdb-backend-reflog.sh
>  create mode 100755 t/t1480-refs-lmdb-submodule.sh
>  create mode 100644 test-refs-lmdb-backend.c
> 
