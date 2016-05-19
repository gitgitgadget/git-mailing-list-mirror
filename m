From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v10 00/20] index-helper/watchman
Date: Thu, 19 May 2016 15:08:45 -0400
Organization: Twitter
Message-ID: <1463684925.24478.81.camel@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 21:09:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3TJg-0004H1-Ve
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 21:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbcESTIt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 15:08:49 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35035 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbcESTIr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 15:08:47 -0400
Received: by mail-qg0-f41.google.com with SMTP id j18so706169qge.2
        for <git@vger.kernel.org>; Thu, 19 May 2016 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :mime-version:content-transfer-encoding;
        bh=Ofi3tVLpYQoXHkKrS4Hr8ePwCs4MyMhiCnjTmYUMjJo=;
        b=pH/O0lpvOyDvYWqiFTZOLsjR5t7VS+Wcym1qZU60S2MgI1KRgPG+BWNkdV0jxrgUwh
         ENankj2BVZQ7/6gAdUkZSFdb4MuxqMKL9tLNFldcyN3gobeiPYpn1VP5Fv6CNYuWX1wu
         ojRhb/4Lq3HWkC0oCIl2dZWYhXJohMb+yF05P+f9itC/j/5HWE8u9VnqApE3LIfx3Kwb
         0x+5Utjw7xudu5XBgD19y8c/oFfwYfgM2BRPoWvvKeYe2bBDTUz4IHbSCxdDI/cwbnbX
         Hyuqi2XY8/K6ial0lGWsBvc4bZxMcpk2GwXM+vTuYGwzuqSga/jpQn0XAUxo6Ea0DBXS
         cQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Ofi3tVLpYQoXHkKrS4Hr8ePwCs4MyMhiCnjTmYUMjJo=;
        b=lmQSxKxT7e2bJtD4KBZ0PTiARQrEuZFBIzh0PK1y0PxR/jrgm5SbZ01NxDJXbfyTXL
         UxywJFFj4VI7E/43eyhfqMswE/5woHF7YWDZvdj9KNyOiClEUIEzPM62wqfA02oUA5Xw
         Tbjat7FC5+wLcJWvxhsR61HJi3sK7rI6j7igtZz83Wev8wQz2mN/GX9yZDXCBlNYDLry
         KtKUQUIFKQhffbgHLQA6TJqxFCSo38kTKpV1mWJKXInQSr7ioFQ7zJo9rt72JYxuW4Qk
         sswN6Hfoci6arnaVFaAvci+HfNLn5Sj7MXhZypBToD7xL6T8l0OjYIVInHmo2Uz3FdLH
         71Tw==
X-Gm-Message-State: AOPr4FXM67wyQqxLDtw90GsyxaOsYyYwh0L9cC9Ypck2k9zusGn0RezZptUPYZZfUa+P+w==
X-Received: by 10.140.230.20 with SMTP id a20mr16728098qhc.68.1463684926713;
        Thu, 19 May 2016 12:08:46 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id i126sm7271106qkf.1.2016.05.19.12.08.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 May 2016 12:08:46 -0700 (PDT)
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295092>

Do folks have any more comments on this version? Do I need to re-roll
to replace 11/20 as I proposed and drop 20/20? =20

Thanks.

On Thu, 2016-05-12 at 16:19 -0400, David Turner wrote:
> packet_write was causing the sigpipes (by calling write_or_die, which
> intentionally overrides the caller's preferences about signal
> handling).
>=20
> This version fixes that.  I didn't test on a virtual machine, but I
> did
> test by adding a sleep().
>=20
> David Turner (9):
>   pkt-line: add gentle version of packet_write
>   index-helper: log warnings
>   unpack-trees: preserve index extensions
>   watchman: add a config option to enable the extension
>   index-helper: kill mode
>   index-helper: don't run if already running
>   index-helper: autorun mode
>   index-helper: optionally automatically run
>   untracked-cache: config option
>=20
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
>   read-cache.c: fix constness of verify_hdr()
>   read-cache: allow to keep mmap'd memory after reading
>   index-helper: new daemon for caching index and related stuff
>   index-helper: add --strict
>   daemonize(): set a flag before exiting the main process
>   index-helper: add --detach
>   read-cache: add watchman 'WAMA' extension
>   watchman: support watchman to reduce index refresh cost
>   index-helper: use watchman to avoid refreshing index with lstat()
>   update-index: enable/disable watchman support
>   trace: measure where the time is spent in the index-heavy
> operations
>=20
>  .gitignore                               |   2 +
>  Documentation/config.txt                 |  12 +
>  Documentation/git-index-helper.txt       |  81 +++++
>  Documentation/git-update-index.txt       |   6 +
>  Documentation/technical/index-format.txt |  22 ++
>  Makefile                                 |  18 ++
>  builtin/gc.c                             |   2 +-
>  builtin/update-index.c                   |  16 +
>  cache.h                                  |  25 +-
>  config.c                                 |   5 +
>  configure.ac                             |   8 +
>  contrib/completion/git-completion.bash   |   1 +
>  daemon.c                                 |   2 +-
>  diff-lib.c                               |   4 +
>  dir.c                                    |  25 +-
>  dir.h                                    |   6 +
>  environment.c                            |   3 +
>  git-compat-util.h                        |   1 +
>  index-helper.c                           | 486
> ++++++++++++++++++++++++++++
>  name-hash.c                              |   2 +
>  pkt-line.c                               |  18 ++
>  pkt-line.h                               |   2 +
>  preload-index.c                          |   2 +
>  read-cache.c                             | 536
> ++++++++++++++++++++++++++++++-
>  refs/files-backend.c                     |   2 +
>  setup.c                                  |   4 +-
>  t/t1701-watchman-extension.sh            |  37 +++
>  t/t7063-status-untracked-cache.sh        |  22 ++
>  t/t7900-index-helper.sh                  |  69 ++++
>  t/test-lib-functions.sh                  |   4 +
>  test-dump-watchman.c                     |  16 +
>  unpack-trees.c                           |   1 +
>  watchman-support.c                       | 135 ++++++++
>  watchman-support.h                       |   7 +
>  34 files changed, 1561 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/git-index-helper.txt
>  create mode 100644 index-helper.c
>  create mode 100755 t/t1701-watchman-extension.sh
>  create mode 100755 t/t7900-index-helper.sh
>  create mode 100644 test-dump-watchman.c
>  create mode 100644 watchman-support.c
>  create mode 100644 watchman-support.h
>=20
