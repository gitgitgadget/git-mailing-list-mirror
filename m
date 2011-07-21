From: Nikolai Weibull <now@bitwi.se>
Subject: Command-line options that lack documentation
Date: Thu, 21 Jul 2011 14:07:05 +0200
Message-ID: <CADdV=MsNyhOg7r9NV67e0V1_7FCvdBu4YA=7gAEjPLagP0r9yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 21 14:07:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjs24-0000df-8m
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 14:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876Ab1GUMHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 08:07:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57773 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab1GUMHG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 08:07:06 -0400
Received: by pvh21 with SMTP id 21so295612pvh.19
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=eN7IFNyBytUpz4h7hL2ztAodcPelivNsobDSE/PQT0o=;
        b=kMM33Ugmis5yXExae0EfpH9+zmWcF7QW/twrWp8l6XECOmfJt27lLxKsuNUu/SQPL+
         JvCZV6Q73aEulvpRQSpWijJb8LV771XZOTzIJHRFdKFwUggcHlKbKcOA47c+/CIgogSc
         XNE04XC7JHctmCelaL8kvfZb9sSoMCHg5Awbw=
Received: by 10.68.31.1 with SMTP id w1mr201101pbh.421.1311250025888; Thu, 21
 Jul 2011 05:07:05 -0700 (PDT)
Received: by 10.68.48.200 with HTTP; Thu, 21 Jul 2011 05:07:05 -0700 (PDT)
X-Google-Sender-Auth: wUMG5IzOq2f7pLQbSxcR71KMfcw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

The following options lack (full) documentation in the manual pages:

git-am:
  --patch-format
  --rerere-autoupdate

git-bisect:
  next subcommand

git-commit:
  --null
  --interactive

git-notes copy:
  --for-rewrite

git-submodule update:
  --init

git-config:
  --local

git-reflog expire:
  -n, --dry-run

git-reflog delete:
  -n, --dry-run

git-repack:
  --quiet

git-cherry:
  --abbrev

git-fsck:
  -v

git-rerere:
  --rerere-autoupdate

git-verify-tag:
  -v, --verbose

git-svn init | fetch | clone | rebase | dcommit:
  --no-auth-cache
  --config-dir

git-svn fetch | clone | rebase | dcommit:
  --noMetadata
  --useSvmProps
  --useSvnsyncProps
  --log-window-size
  --no-checkout

git-svn fetch | rebase | dcommit:
  --fetch-all, --all

git-svn dcommit:
  -C, --copy-similarity

git-svn log:
  --color
  --pager
  --non-recursive

git-svn show-ignore | mkdirs:
  -r, --revision

git-svn commit-diff:
  -m, --message
  -F, --file
  -r, --revision

git-index-pack:
  --pack_header

git-merge-file:
  --marker-size
  --diff3

git-pack-objects:
  --reflog
  --keep-unreachable
  --unpack-unreachable

git-ls-files:
  --resolve-undo

git-send-pack:
  --mirror
  --stateless-rpc
  --helper-status

git-receive-pack:
  --advertise-refs
  --stateless-rpc

git-upload-pack:
  --advertise-refs
  --stateless-rpc

git-mailinfo:
  --no-inbody-headers

Furthermore, the fact that most commands take -h and --help is
undocumented, but perhaps not of any real importance.

I would provide patches to the documentation, but most of these
options are beyond my grasp of Git.
