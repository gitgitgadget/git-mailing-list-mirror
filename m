From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: XDL_FAST_HASH breaks git on OS X 10.7.3
Date: Sun, 29 Apr 2012 16:52:51 -0400
Message-ID: <441BE38F-E081-4ED8-B587-BF72AD6368EE@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Apr 29 22:53:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOb7F-0000Hz-7U
	for gcvg-git-2@plane.gmane.org; Sun, 29 Apr 2012 22:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab2D2Uw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 16:52:58 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59455 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab2D2Uw5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Apr 2012 16:52:57 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 326FB1FFC016; Sun, 29 Apr 2012 20:52:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_50
	autolearn=ham version=3.2.5
Received: from [10.10.10.141] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 0C25E1FFC009;
	Sun, 29 Apr 2012 20:52:45 +0000 (UTC)
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196514>

I don't mean for the subject to be excessive, but it does cause 242 test files to fail and t9001-send-email.sh to hang by asking "Which 8bit encoding should I declare [UTF-8]?"  Clearing XDL_FAST_HASH in my config.mak does fix the issue.

~~ Brian Gernhardt

Test Summary Report
-------------------
t9700-perl-git.sh                                (Wstat: 256 Tests: 44 Failed: 14)
  Failed tests:  1, 4-5, 8, 10, 13-16, 28-29, 38, 43-44
  Non-zero exit status: 1
t9502-gitweb-standalone-parse-output.sh          (Wstat: 256 Tests: 16 Failed: 7)
  Failed tests:  1-5, 7, 9
  Non-zero exit status: 1
t9501-gitweb-standalone-http-status.sh           (Wstat: 256 Tests: 12 Failed: 2)
  Failed tests:  1, 8
  Non-zero exit status: 1
t9401-git-cvsserver-crlf.sh                      (Wstat: 256 Tests: 17 Failed: 7)
  Failed tests:  7-8, 10-11, 15-17
  Non-zero exit status: 1
t9400-git-cvsserver-server.sh                    (Wstat: 256 Tests: 40 Failed: 3)
  Failed tests:  30-31, 40
  Non-zero exit status: 1
t9350-fast-export.sh                             (Wstat: 256 Tests: 28 Failed: 15)
  Failed tests:  1-5, 10, 12-18, 20-21
  Non-zero exit status: 1
t9139-git-svn-non-utf8-commitencoding.sh         (Wstat: 256 Tests: 6 Failed: 1)
  Failed test:  4
  Non-zero exit status: 1
t9200-git-cvsexportcommit.sh                     (Wstat: 256 Tests: 14 Failed: 11)
  Failed tests:  1-2, 4-8, 10-11, 13-14
  Non-zero exit status: 1
t9500-gitweb-standalone-no-errors.sh             (Wstat: 256 Tests: 117 Failed: 10)
  Failed tests:  35-37, 51, 54, 69, 84-85, 100, 109
  Non-zero exit status: 1
t9137-git-svn-dcommit-clobber-series.sh          (Wstat: 256 Tests: 5 Failed: 1)
  Failed test:  4
  Non-zero exit status: 1
t9125-git-svn-multi-glob-branch-names.sh         (Wstat: 256 Tests: 3 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
t9124-git-svn-dcommit-auto-props.sh              (Wstat: 256 Tests: 7 Failed: 3)
  Failed tests:  3, 5-6
  Non-zero exit status: 1
t9118-git-svn-funky-branch-names.sh              (Wstat: 256 Tests: 5 Failed: 2)
  Failed tests:  3-4
  Non-zero exit status: 1
t9114-git-svn-dcommit-merge.sh                   (Wstat: 256 Tests: 6 Failed: 4)
  Failed tests:  2-3, 5-6
  Non-zero exit status: 1
t9116-git-svn-log.sh                             (Wstat: 256 Tests: 17 Failed: 14)
  Failed tests:  1-5, 7-13, 16-17
  Non-zero exit status: 1
t9105-git-svn-commit-diff.sh                     (Wstat: 256 Tests: 3 Failed: 3)
  Failed tests:  1-3
  Non-zero exit status: 1
t9106-git-svn-commit-diff-clobber.sh             (Wstat: 256 Tests: 10 Failed: 8)
  Failed tests:  1, 3-6, 8-10
  Non-zero exit status: 1
t8007-cat-file-textconv.sh                       (Wstat: 256 Tests: 10 Failed: 5)
  Failed tests:  1, 4-7
  Non-zero exit status: 1
t8006-blame-textconv.sh                          (Wstat: 256 Tests: 16 Failed: 10)
  Failed tests:  1-2, 4-6, 9, 12-14, 16
  Non-zero exit status: 1
t8005-blame-i18n.sh                              (Wstat: 256 Tests: 5 Failed: 5)
  Failed tests:  1-5
  Non-zero exit status: 1
t8003-blame-corner-cases.sh                      (Wstat: 256 Tests: 19 Failed: 3)
  Failed tests:  1, 12-13
  Non-zero exit status: 1
t8002-blame.sh                                   (Wstat: 256 Tests: 21 Failed: 7)
  Failed tests:  5, 10, 14, 16, 18, 20-21
  Non-zero exit status: 1
t8001-annotate.sh                                (Wstat: 256 Tests: 21 Failed: 6)
  Failed tests:  5, 10, 14, 16, 18, 20
  Non-zero exit status: 1
t7810-grep.sh                                    (Wstat: 256 Tests: 108 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t9101-git-svn-props.sh                           (Wstat: 256 Tests: 26 Failed: 13)
  Failed tests:  5, 8-18, 25
  Non-zero exit status: 1
t7611-merge-abort.sh                             (Wstat: 256 Tests: 26 Failed: 9)
  Failed tests:  9-13, 15-16, 24, 26
  Non-zero exit status: 1
t7811-grep-open.sh                               (Wstat: 256 Tests: 10 Failed: 4)
  Failed tests:  2, 5, 8, 10
  Non-zero exit status: 1
t7701-repack-unpack-unreachable.sh               (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t7800-difftool.sh                                (Wstat: 256 Tests: 25 Failed: 25)
  Failed tests:  1-25
  Non-zero exit status: 1
t7610-mergetool.sh                               (Wstat: 256 Tests: 14 Failed: 14)
  Failed tests:  1-14
  Non-zero exit status: 1
t7609-merge-co-error-msgs.sh                     (Wstat: 256 Tests: 6 Failed: 5)
  Failed tests:  1-5
  Non-zero exit status: 1
t7607-merge-overwrite.sh                         (Wstat: 256 Tests: 17 Failed: 12)
  Failed tests:  1-10, 13-14
  Non-zero exit status: 1
t7608-merge-messages.sh                          (Wstat: 256 Tests: 5 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
t7509-commit.sh                                  (Wstat: 256 Tests: 12 Failed: 12)
  Failed tests:  1-12
  Non-zero exit status: 1
t7507-commit-verbose.sh                          (Wstat: 256 Tests: 7 Failed: 6)
  Failed tests:  1-6
  Non-zero exit status: 1
t9100-git-svn-basic.sh                           (Wstat: 256 Tests: 25 Failed: 2)
  Failed tests:  14, 16
  Non-zero exit status: 1
t7506-status-submodule.sh                        (Wstat: 256 Tests: 28 Failed: 4)
  Failed tests:  1, 21, 27-28
  Non-zero exit status: 1
t7501-commit.sh                                  (Wstat: 256 Tests: 45 Failed: 5)
  Failed tests:  20-21, 26-27, 39
  Non-zero exit status: 1
t7500-commit.sh                                  (Wstat: 256 Tests: 32 Failed: 19)
  Failed tests:  1, 8-14, 16, 21, 23-31
  Non-zero exit status: 1
t7502-commit.sh                                  (Wstat: 256 Tests: 45 Failed: 37)
  Failed tests:  2, 4-8, 11-19, 22, 24, 26-45
  Non-zero exit status: 1
t7408-submodule-reference.sh                     (Wstat: 256 Tests: 10 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t7405-submodule-merge.sh                         (Wstat: 256 Tests: 11 Failed: 7)
  Failed tests:  2-8
  Non-zero exit status: 1
t7407-submodule-foreach.sh                       (Wstat: 256 Tests: 15 Failed: 10)
  Failed tests:  3, 5-13
  Non-zero exit status: 1
t7403-submodule-sync.sh                          (Wstat: 256 Tests: 6 Failed: 5)
  Failed tests:  1, 3-6
  Non-zero exit status: 1
t7402-submodule-rebase.sh                        (Wstat: 256 Tests: 5 Failed: 3)
  Failed tests:  2-4
  Non-zero exit status: 1
t7300-clean.sh                                   (Wstat: 256 Tests: 30 Failed: 18)
  Failed tests:  1-6, 11-20, 23-24
  Non-zero exit status: 1
t7201-co.sh                                      (Wstat: 256 Tests: 35 Failed: 7)
  Failed tests:  29-35
  Non-zero exit status: 1
t7406-submodule-update.sh                        (Wstat: 256 Tests: 33 Failed: 23)
  Failed tests:  1-5, 7-14, 20-25, 29-31, 33
  Non-zero exit status: 1
t7105-reset-patch.sh                             (Wstat: 256 Tests: 8 Failed: 8)
  Failed tests:  1-8
  Non-zero exit status: 1
t7110-reset-merge.sh                             (Wstat: 256 Tests: 21 Failed: 21)
  Failed tests:  1-21
  Non-zero exit status: 1
t7101-reset.sh                                   (Wstat: 256 Tests: 10 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t7060-wtstatus.sh                                (Wstat: 256 Tests: 10 Failed: 9)
  Failed tests:  1-4, 6-10
  Non-zero exit status: 1
t7006-pager.sh                                   (Wstat: 256 Tests: 75 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
t7004-tag.sh                                     (Wstat: 256 Tests: 121 Failed: 10)
  Failed tests:  104-109, 111-112, 115, 121
  Non-zero exit status: 1
t7001-mv.sh                                      (Wstat: 256 Tests: 29 Failed: 6)
  Failed tests:  1, 3, 6, 12, 14, 18
  Non-zero exit status: 1
t7003-filter-branch.sh                           (Wstat: 256 Tests: 33 Failed: 10)
  Failed tests:  1, 3, 5-6, 12-13, 16, 31-33
  Non-zero exit status: 1
t6050-replace.sh                                 (Wstat: 256 Tests: 16 Failed: 11)
  Failed tests:  2-4, 7-14
  Non-zero exit status: 1
t6120-describe.sh                                (Wstat: 256 Tests: 36 Failed: 31)
  Failed tests:  1-13, 15-24, 26-27, 29-30, 32, 34-36
  Non-zero exit status: 1
t6042-merge-rename-corner-cases.sh               (Wstat: 256 Tests: 26 Failed: 19)
  Failed tests:  1-3, 5, 7, 9, 12-21, 23, 25-26
  Non-zero exit status: 1
t6037-merge-ours-theirs.sh                       (Wstat: 256 Tests: 5 Failed: 4)
  Failed tests:  1-3, 5
  Non-zero exit status: 1
t6036-recursive-corner-cases.sh                  (Wstat: 256 Tests: 22 Failed: 6)
  Failed tests:  1-6
  Non-zero exit status: 1
t6034-merge-rename-nocruft.sh                    (Wstat: 256 Tests: 3 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t6032-merge-large-rename.sh                      (Wstat: 256 Tests: 10 Failed: 5)
  Failed tests:  2, 4, 7, 9-10
  Non-zero exit status: 1
t6031-merge-recursive.sh                         (Wstat: 256 Tests: 5 Failed: 1)
  Failed test:  5
  Non-zero exit status: 1
t6028-merge-up-to-date.sh                        (Wstat: 256 Tests: 6 Failed: 6)
  Failed tests:  1-6
  Non-zero exit status: 1
t6026-merge-attr.sh                              (Wstat: 256 Tests: 8 Failed: 7)
  Failed tests:  1-7
  Non-zero exit status: 1
t6029-merge-subtree.sh                           (Wstat: 256 Tests: 8 Failed: 8)
  Failed tests:  1-8
  Non-zero exit status: 1
t6027-merge-binary.sh                            (Wstat: 256 Tests: 3 Failed: 3)
  Failed tests:  1-3
  Non-zero exit status: 1
t6025-merge-symlinks.sh                          (Wstat: 256 Tests: 7 Failed: 3)
  Failed tests:  1, 4, 6
  Non-zero exit status: 1
t6024-recursive-merge.sh                         (Wstat: 256 Tests: 6 Failed: 5)
  Failed tests:  2-6
  Non-zero exit status: 1
t6023-merge-file.sh                              (Wstat: 256 Tests: 18 Failed: 11)
  Failed tests:  1-5, 8, 10, 12, 16-18
  Non-zero exit status: 1
t6030-bisect-porcelain.sh                        (Wstat: 256 Tests: 53 Failed: 7)
  Failed tests:  35-38, 40-42
  Non-zero exit status: 1
t6022-merge-rename.sh                            (Wstat: 256 Tests: 45 Failed: 45)
  Failed tests:  1-45
  Non-zero exit status: 1
t6018-rev-list-glob.sh                           (Wstat: 256 Tests: 36 Failed: 29)
  Failed tests:  1-6, 9-12, 14-18, 20-27, 29-34
  Non-zero exit status: 1
t6020-merge-df.sh                                (Wstat: 256 Tests: 6 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
t6015-rev-list-show-all-parents.sh               (Wstat: 256 Tests: 3 Failed: 3)
  Failed tests:  1-3
  Non-zero exit status: 1
t6013-rev-list-reverse-parents.sh                (Wstat: 256 Tests: 3 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t6012-rev-list-simplify.sh                       (Wstat: 256 Tests: 9 Failed: 9)
  Failed tests:  1-9
  Non-zero exit status: 1
t6009-rev-list-parent.sh                         (Wstat: 256 Tests: 13 Failed: 12)
  Failed tests:  1-10, 12-13
  Non-zero exit status: 1
t6007-rev-list-cherry-pick-file.sh               (Wstat: 256 Tests: 17 Failed: 16)
  Failed tests:  1-3, 5-17
  Non-zero exit status: 1
t6006-rev-list-format.sh                         (Wstat: 256 Tests: 35 Failed: 2)
  Failed tests:  1, 14
  Non-zero exit status: 1
t6001-rev-list-graft.sh                          (Wstat: 256 Tests: 13 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t6004-rev-list-path-optim.sh                     (Wstat: 256 Tests: 7 Failed: 6)
  Failed tests:  1, 3-7
  Non-zero exit status: 1
t5900-repo-selection.sh                          (Wstat: 256 Tests: 8 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
t5800-remote-helpers.sh                          (Wstat: 256 Tests: 14 Failed: 13)
  Failed tests:  1-13
  Non-zero exit status: 1
t5710-info-alternate.sh                          (Wstat: 256 Tests: 11 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
t5708-clone-config.sh                            (Wstat: 256 Tests: 4 Failed: 1)
  Failed test:  4
  Non-zero exit status: 1
t5707-clone-detached.sh                          (Wstat: 256 Tests: 13 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t5704-bundle.sh                                  (Wstat: 256 Tests: 7 Failed: 3)
  Failed tests:  1-2, 7
  Non-zero exit status: 1
t5570-git-daemon.sh                              (Wstat: 256 Tests: 16 Failed: 2)
  Failed tests:  1, 4
  TODO passed:   5
  Non-zero exit status: 1
t5701-clone-local.sh                             (Wstat: 256 Tests: 17 Failed: 1)
  Failed test:  14
  Non-zero exit status: 1
t5700-clone-reference.sh                         (Wstat: 256 Tests: 23 Failed: 10)
  Failed tests:  1-2, 5, 10, 12-13, 15, 17-18, 22
  Non-zero exit status: 1
t5561-http-backend.sh                            (Wstat: 256 Tests: 14 Failed: 13)
  Failed tests:  1, 3-14
  Non-zero exit status: 1
t5560-http-backend-noserver.sh                   (Wstat: 256 Tests: 14 Failed: 13)
  Failed tests:  1, 3-14
  Non-zero exit status: 1
t5551-http-fetch.sh                              (Wstat: 256 Tests: 7 Failed: 3)
  Failed tests:  1, 4-5
  Non-zero exit status: 1
t5550-http-fetch.sh                              (Wstat: 256 Tests: 19 Failed: 3)
  Failed tests:  1, 13-14
  Non-zero exit status: 1
t5532-fetch-proxy.sh                             (Wstat: 256 Tests: 3 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t5541-http-push.sh                               (Wstat: 256 Tests: 21 Failed: 8)
  Failed tests:  10-16, 19
  Non-zero exit status: 1
t5540-http-push.sh                               (Wstat: 256 Tests: 17 Failed: 4)
  Failed tests:  13-16
  Non-zero exit status: 1
t5530-upload-pack-error.sh                       (Wstat: 256 Tests: 10 Failed: 3)
  Failed tests:  1-3
  Non-zero exit status: 1
t5527-fetch-odd-refs.sh                          (Wstat: 256 Tests: 2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t5526-fetch-submodules.sh                        (Wstat: 256 Tests: 25 Failed: 25)
  Failed tests:  1-25
  Non-zero exit status: 1
t5524-pull-msg.sh                                (Wstat: 256 Tests: 2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t5523-push-upstream.sh                           (Wstat: 256 Tests: 17 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
t5519-push-alternates.sh                         (Wstat: 256 Tests: 8 Failed: 1)
  Failed test:  8
  Non-zero exit status: 1
t5515-fetch-merge-logic.sh                       (Wstat: 256 Tests: 17 Failed: 17)
  Failed tests:  1-17
  Non-zero exit status: 1
t5520-pull.sh                                    (Wstat: 256 Tests: 21 Failed: 10)
  Failed tests:  6-14, 21
  Non-zero exit status: 1
t5504-fetch-receive-strict.sh                    (Wstat: 256 Tests: 9 Failed: 9)
  Failed tests:  1-9
  Non-zero exit status: 1
t5510-fetch.sh                                   (Wstat: 256 Tests: 40 Failed: 15)
  Failed tests:  2-4, 14-15, 17-19, 31-33, 35-36, 39-40
  Non-zero exit status: 1
t5001-archive-attr.sh                            (Wstat: 256 Tests: 21 Failed: 6)
  Failed tests:  1, 14-15, 17-18, 21
  Non-zero exit status: 1
t5404-tracking-branches.sh                       (Wstat: 256 Tests: 7 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
t4300-merge-tree.sh                              (Wstat: 256 Tests: 14 Failed: 14)
  Failed tests:  1-14
  Non-zero exit status: 1
t5506-remote-groups.sh                           (Wstat: 256 Tests: 8 Failed: 7)
  Failed tests:  2-8
  Non-zero exit status: 1
t4253-am-keep-cr-dos.sh                          (Wstat: 256 Tests: 7 Failed: 7)
  Failed tests:  1-7
  Non-zero exit status: 1
t4208-log-magic-pathspec.sh                      (Wstat: 256 Tests: 5 Failed: 2)
  Failed tests:  1, 5
  Non-zero exit status: 1
t4206-log-follow-harder-copies.sh                (Wstat: 256 Tests: 5 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t4202-log.sh                                     (Wstat: 256 Tests: 32 Failed: 3)
  Failed tests:  26-27, 32
  Non-zero exit status: 1
t4203-mailmap.sh                                 (Wstat: 256 Tests: 12 Failed: 3)
  Failed tests:  10-12
  Non-zero exit status: 1
t4209-log-pickaxe.sh                             (Wstat: 256 Tests: 18 Failed: 7)
  Failed tests:  1, 7-12
  Non-zero exit status: 1
t4200-rerere.sh                                  (Wstat: 256 Tests: 25 Failed: 17)
  Failed tests:  6-9, 11, 13-24
  Non-zero exit status: 1
t4152-am-subjects.sh                             (Wstat: 256 Tests: 13 Failed: 4)
  Failed tests:  2, 5-7
  Non-zero exit status: 1
t4150-am.sh                                      (Wstat: 256 Tests: 36 Failed: 31)
  Failed tests:  2-6, 8-24, 27-35
  Non-zero exit status: 1
t4130-apply-criss-cross-rename.sh                (Wstat: 256 Tests: 7 Failed: 5)
  Failed tests:  1, 3-4, 6-7
  Non-zero exit status: 1
t4128-apply-root.sh                              (Wstat: 256 Tests: 7 Failed: 6)
  Failed tests:  1, 3-7
  Non-zero exit status: 1
t4125-apply-ws-fuzz.sh                           (Wstat: 256 Tests: 4 Failed: 4)
  Failed tests:  1-4
  Non-zero exit status: 1
t4122-apply-symlink-inside.sh                    (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t4123-apply-shrink.sh                            (Wstat: 256 Tests: 2 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t4115-apply-symlink.sh                           (Wstat: 256 Tests: 3 Failed: 3)
  Failed tests:  1-3
  Non-zero exit status: 1
t4124-apply-ws-rule.sh                           (Wstat: 256 Tests: 74 Failed: 54)
  Failed tests:  1-3, 5-55
  Non-zero exit status: 1
t4114-apply-typechange.sh                        (Wstat: 256 Tests: 11 Failed: 7)
  Failed tests:  1-5, 10-11
  Non-zero exit status: 1
t4106-apply-stdin.sh                             (Wstat: 256 Tests: 3 Failed: 3)
  Failed tests:  1-3
  Non-zero exit status: 1
t4103-apply-binary.sh                            (Wstat: 256 Tests: 20 Failed: 12)
  Failed tests:  1-3, 8-9, 14-20
  Non-zero exit status: 1
t4051-diff-function-context.sh                   (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t4050-diff-histogram.sh                          (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t4048-diff-combined-binary.sh                    (Wstat: 256 Tests: 14 Failed: 9)
  Failed tests:  5-8, 10-14
  Non-zero exit status: 1
t4047-diff-dirstat.sh                            (Wstat: 256 Tests: 40 Failed: 37)
  Failed tests:  1-2, 4-37, 40
  Non-zero exit status: 1
t4045-diff-relative.sh                           (Wstat: 256 Tests: 10 Failed: 6)
  Failed tests:  1-4, 6-7
  Non-zero exit status: 1
t4044-diff-index-unique-abbrev.sh                (Wstat: 256 Tests: 2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t4042-diff-textconv-caching.sh                   (Wstat: 256 Tests: 6 Failed: 6)
  Failed tests:  1-6
  Non-zero exit status: 1
t4038-diff-combined.sh                           (Wstat: 256 Tests: 4 Failed: 3)
  Failed tests:  1, 3-4
  Non-zero exit status: 1
t4037-diff-r-t-dirs.sh                           (Wstat: 256 Tests: 2 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t4033-diff-patience.sh                           (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t4030-diff-textconv.sh                           (Wstat: 256 Tests: 11 Failed: 1)
  Failed test:  11
  Non-zero exit status: 1
t4027-diff-submodule.sh                          (Wstat: 256 Tests: 22 Failed: 20)
  Failed tests:  1-18, 20, 22
  Non-zero exit status: 1
t4034-diff-words.sh                              (Wstat: 256 Tests: 36 Failed: 27)
  Failed tests:  3-8, 10-11, 13-15, 17-18, 21-34
  Non-zero exit status: 1
t4028-format-patch-mime-headers.sh               (Wstat: 256 Tests: 3 Failed: 3)
  Failed tests:  1-3
  Non-zero exit status: 1
t4025-hunk-header.sh                             (Wstat: 256 Tests: 2 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
t4024-diff-optimize-common.sh                    (Wstat: 256 Tests: 2 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
t4023-diff-rename-typechange.sh                  (Wstat: 256 Tests: 4 Failed: 4)
  Failed tests:  1-4
  Non-zero exit status: 1
t4022-diff-rewrite.sh                            (Wstat: 256 Tests: 6 Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
t4020-diff-external.sh                           (Wstat: 256 Tests: 16 Failed: 13)
  Failed tests:  1-12, 16
  Non-zero exit status: 1
t4019-diff-wserror.sh                            (Wstat: 256 Tests: 21 Failed: 1)
  Failed test:  20
  Non-zero exit status: 1
t4018-diff-funcname.sh                           (Wstat: 256 Tests: 41 Failed: 39)
  Failed tests:  1-29, 31-38, 40-41
  Non-zero exit status: 1
t4017-diff-retval.sh                             (Wstat: 256 Tests: 24 Failed: 4)
  Failed tests:  20-21, 23-24
  Non-zero exit status: 1
t4016-diff-quote.sh                              (Wstat: 256 Tests: 5 Failed: 1)
  Failed test:  5
  Non-zero exit status: 1
t4015-diff-whitespace.sh                         (Wstat: 256 Tests: 56 Failed: 27)
  Failed tests:  1, 4, 12-16, 19-30, 35-37, 47-48, 52, 54
                56
  Non-zero exit status: 1
t4011-diff-symlink.sh                            (Wstat: 256 Tests: 8 Failed: 4)
  Failed tests:  1, 3-5
  Non-zero exit status: 1
t4014-format-patch.sh                            (Wstat: 256 Tests: 73 Failed: 12)
  Failed tests:  62-73
  Non-zero exit status: 1
t4004-diff-rename-symlink.sh                     (Wstat: 256 Tests: 4 Failed: 1)
  Failed test:  4
  Non-zero exit status: 1
t4003-diff-rename-1.sh                           (Wstat: 256 Tests: 7 Failed: 3)
  Failed tests:  3, 5, 7
  Non-zero exit status: 1
t4001-diff-rename.sh                             (Wstat: 256 Tests: 8 Failed: 4)
  Failed tests:  4-7
  Non-zero exit status: 1
t4000-diff-format.sh                             (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t3904-stash-patch.sh                             (Wstat: 256 Tests: 6 Failed: 6)
  Failed tests:  1-6
  Non-zero exit status: 1
t3902-quoted.sh                                  (Wstat: 256 Tests: 13 Failed: 5)
  Failed tests:  1, 4-5, 10-11
  Non-zero exit status: 1
t3900-i18n-commit.sh                             (Wstat: 256 Tests: 30 Failed: 2)
  Failed tests:  5, 29
  Non-zero exit status: 1
t3800-mktag.sh                                   (Wstat: 256 Tests: 26 Failed: 17)
  Failed tests:  1, 11-26
  Non-zero exit status: 1
t3702-add-edit.sh                                (Wstat: 256 Tests: 2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t3903-stash.sh                                   (Wstat: 256 Tests: 45 Failed: 14)
  Failed tests:  12, 18-20, 22-30, 45
  Non-zero exit status: 1
t3600-rm.sh                                      (Wstat: 256 Tests: 36 Failed: 3)
  Failed tests:  18-19, 28
  Non-zero exit status: 1
t3510-cherry-pick-sequence.sh                    (Wstat: 256 Tests: 39 Failed: 35)
  Failed tests:  1-5, 8-19, 21-35, 37-39
  Non-zero exit status: 1
t3508-cherry-pick-many-commits.sh                (Wstat: 256 Tests: 10 Failed: 10)
  Failed tests:  1-10
  Non-zero exit status: 1
t3509-cherry-pick-merge-df.sh                    (Wstat: 256 Tests: 9 Failed: 6)
  Failed tests:  4-9
  Non-zero exit status: 1
t3506-cherry-pick-ff.sh                          (Wstat: 256 Tests: 10 Failed: 4)
  Failed tests:  1-3, 10
  Non-zero exit status: 1
t3505-cherry-pick-empty.sh                       (Wstat: 256 Tests: 5 Failed: 3)
  Failed tests:  1-2, 4
  Non-zero exit status: 1
t3504-cherry-pick-rerere.sh                      (Wstat: 256 Tests: 6 Failed: 4)
  Failed tests:  2-5
  Non-zero exit status: 1
t3701-add-interactive.sh                         (Wstat: 256 Tests: 35 Failed: 15)
  Failed tests:  2, 4-5, 7, 9-10, 16, 18, 21-25, 29, 31
  Non-zero exit status: 1
t3500-cherry.sh                                  (Wstat: 256 Tests: 3 Failed: 3)
  Failed tests:  1-3
  Non-zero exit status: 1
t3503-cherry-pick-root.sh                        (Wstat: 256 Tests: 6 Failed: 5)
  Failed tests:  1-2, 4-6
  Non-zero exit status: 1
t3418-rebase-continue.sh                         (Wstat: 256 Tests: 6 Failed: 1)
  Failed test:  6
  Non-zero exit status: 1
t3417-rebase-whitespace-fix.sh                   (Wstat: 256 Tests: 4 Failed: 3)
  Failed tests:  2-4
  Non-zero exit status: 1
t3413-rebase-hook.sh                             (Wstat: 256 Tests: 15 Failed: 13)
  Failed tests:  1-3, 5-10, 12-15
  Non-zero exit status: 1
t3409-rebase-preserve-merges.sh                  (Wstat: 256 Tests: 5 Failed: 5)
  Failed tests:  1-5
  Non-zero exit status: 1
t3408-rebase-multi-line.sh                       (Wstat: 256 Tests: 2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t3410-rebase-preserve-dropped-merges.sh          (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t3405-rebase-malformed.sh                        (Wstat: 256 Tests: 2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t3402-rebase-merge.sh                            (Wstat: 256 Tests: 10 Failed: 8)
  Failed tests:  2-4, 6-10
  Non-zero exit status: 1
t3403-rebase-skip.sh                             (Wstat: 256 Tests: 10 Failed: 8)
  Failed tests:  1-2, 4-8, 10
  Non-zero exit status: 1
t3311-notes-merge-fanout.sh                      (Wstat: 256 Tests: 24 Failed: 24)
  Failed tests:  1-24
  Non-zero exit status: 1
t3310-notes-merge-manual-resolve.sh              (Wstat: 256 Tests: 18 Failed: 4)
  Failed tests:  5, 11, 13, 15
  Non-zero exit status: 1
t3400-rebase.sh                                  (Wstat: 256 Tests: 26 Failed: 16)
  Failed tests:  1, 5-8, 12-16, 18-23
  Non-zero exit status: 1
t3300-funny-names.sh                             (Wstat: 256 Tests: 27 Failed: 5)
  Failed tests:  20, 22, 24, 26-27
  Non-zero exit status: 1
t3210-pack-refs.sh                               (Wstat: 256 Tests: 13 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t3203-branch-output.sh                           (Wstat: 256 Tests: 12 Failed: 11)
  Failed tests:  1-10, 12
  Non-zero exit status: 1
t3200-branch.sh                                  (Wstat: 256 Tests: 77 Failed: 6)
  Failed tests:  1, 6, 39, 42, 70, 72
  Non-zero exit status: 1
t3060-ls-files-with-tree.sh                      (Wstat: 256 Tests: 3 Failed: 3)
  Failed tests:  1-3
  Non-zero exit status: 1
t3031-merge-criscross.sh                         (Wstat: 256 Tests: 2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t3030-merge-recursive.sh                         (Wstat: 256 Tests: 31 Failed: 27)
  Failed tests:  1-26, 30
  Non-zero exit status: 1
t3032-merge-recursive-options.sh                 (Wstat: 256 Tests: 11 Failed: 11)
  Failed tests:  1-11
  Non-zero exit status: 1
t3003-ls-files-exclude.sh                        (Wstat: 256 Tests: 7 Failed: 3)
  Failed tests:  1, 3, 6
  Non-zero exit status: 1
t2202-add-addremove.sh                           (Wstat: 256 Tests: 2 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t2203-add-intent.sh                              (Wstat: 256 Tests: 7 Failed: 2)
  Failed tests:  5-6
  Non-zero exit status: 1
t2200-add-update.sh                              (Wstat: 256 Tests: 16 Failed: 3)
  Failed tests:  1, 3, 5
  Non-zero exit status: 1
t2105-update-index-gitfile.sh                    (Wstat: 256 Tests: 4 Failed: 2)
  Failed tests:  1, 3
  Non-zero exit status: 1
t2101-update-index-reupdate.sh                   (Wstat: 256 Tests: 7 Failed: 1)
  Failed test:  4
  Non-zero exit status: 1
t2050-git-dir-relative.sh                        (Wstat: 256 Tests: 4 Failed: 3)
  Failed tests:  2-4
  Non-zero exit status: 1
t2030-unresolve-info.sh                          (Wstat: 256 Tests: 8 Failed: 8)
  Failed tests:  1-8
  Non-zero exit status: 1
t2023-checkout-m.sh                              (Wstat: 256 Tests: 4 Failed: 4)
  Failed tests:  1-4
  Non-zero exit status: 1
t2022-checkout-paths.sh                          (Wstat: 256 Tests: 2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t2020-checkout-detach.sh                         (Wstat: 256 Tests: 19 Failed: 9)
  Failed tests:  1-7, 13-14
  Non-zero exit status: 1
t2019-checkout-ambiguous-ref.sh                  (Wstat: 256 Tests: 9 Failed: 6)
  Failed tests:  1-6
  Non-zero exit status: 1
t2018-checkout-branch.sh                         (Wstat: 256 Tests: 18 Failed: 15)
  Failed tests:  1, 3-7, 9-10, 12-18
  Non-zero exit status: 1
t3404-rebase-interactive.sh                      (Wstat: 256 Tests: 51 Failed: 22)
  Failed tests:  1, 11, 25-26, 30, 33-41, 43-49, 51
  Non-zero exit status: 1
t2017-checkout-orphan.sh                         (Wstat: 256 Tests: 12 Failed: 6)
  Failed tests:  1-3, 7-9
  Non-zero exit status: 1
t2015-checkout-unborn.sh                         (Wstat: 256 Tests: 5 Failed: 2)
  Failed tests:  1, 4
  Non-zero exit status: 1
t2016-checkout-patch.sh                          (Wstat: 256 Tests: 14 Failed: 14)
  Failed tests:  1-14
  Non-zero exit status: 1
t2014-switch.sh                                  (Wstat: 256 Tests: 4 Failed: 2)
  Failed tests:  1, 3
  Non-zero exit status: 1
t2013-checkout-submodule.sh                      (Wstat: 256 Tests: 6 Failed: 6)
  Failed tests:  1-6
  Non-zero exit status: 1
t2011-checkout-invalid-head.sh                   (Wstat: 256 Tests: 3 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t2012-checkout-last.sh                           (Wstat: 256 Tests: 18 Failed: 10)
  Failed tests:  1, 3-5, 7-8, 15-18
  Non-zero exit status: 1
t2010-checkout-ambiguous.sh                      (Wstat: 256 Tests: 8 Failed: 5)
  Failed tests:  1, 3, 6-8
  Non-zero exit status: 1
t2009-checkout-statinfo.sh                       (Wstat: 256 Tests: 3 Failed: 3)
  Failed tests:  1-3
  Non-zero exit status: 1
t2008-checkout-subdir.sh                         (Wstat: 256 Tests: 8 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t2007-checkout-symlink.sh                        (Wstat: 256 Tests: 4 Failed: 2)
  Failed tests:  1, 4
  Non-zero exit status: 1
t1508-at-combinations.sh                         (Wstat: 256 Tests: 11 Failed: 9)
  Failed tests:  1-9
  Non-zero exit status: 1
t1412-reflog-loop.sh                             (Wstat: 256 Tests: 3 Failed: 3)
  Failed tests:  1-3
  Non-zero exit status: 1
t1506-rev-parse-diagnosis.sh                     (Wstat: 256 Tests: 17 Failed: 4)
  Failed tests:  1-2, 11-12
  Non-zero exit status: 1
t1411-reflog-show.sh                             (Wstat: 256 Tests: 10 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t1410-reflog.sh                                  (Wstat: 256 Tests: 12 Failed: 12)
  Failed tests:  1-12
  Non-zero exit status: 1
t1501-worktree.sh                                (Wstat: 256 Tests: 31 Failed: 3)
  Failed tests:  23, 26, 28
  Non-zero exit status: 1
t1400-update-ref.sh                              (Wstat: 256 Tests: 41 Failed: 2)
  Failed tests:  37-38
  Non-zero exit status: 1
t1401-symbolic-ref.sh                            (Wstat: 256 Tests: 4 Failed: 1)
  Failed test:  4
  Non-zero exit status: 1
t1021-rerere-in-workdir.sh                       (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t1004-read-tree-m-u-wf.sh                        (Wstat: 256 Tests: 17 Failed: 9)
  Failed tests:  9-17
  Non-zero exit status: 1
t1200-tutorial.sh                                (Wstat: 256 Tests: 27 Failed: 17)
  Failed tests:  3-4, 6-8, 12-13, 15-24
  Non-zero exit status: 1
t1005-read-tree-reset.sh                         (Wstat: 256 Tests: 6 Failed: 6)
  Failed tests:  1-6
  Non-zero exit status: 1
t0026-eol-config.sh                              (Wstat: 256 Tests: 5 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t1002-read-tree-m-u-2way.sh                      (Wstat: 256 Tests: 22 Failed: 6)
  Failed tests:  3-4, 6, 13-14, 18
  Non-zero exit status: 1
t0025-crlf-auto.sh                               (Wstat: 256 Tests: 11 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t1001-read-tree-m-2way.sh                        (Wstat: 256 Tests: 28 Failed: 4)
  Failed tests:  3-4, 13-14
  Non-zero exit status: 1
t0020-crlf.sh                                    (Wstat: 256 Tests: 34 Failed: 12)
  Failed tests:  1, 10-17, 21, 25-26
  Non-zero exit status: 1
t0022-crlf-rename.sh                             (Wstat: 256 Tests: 2 Failed: 2)
  Failed tests:  1-2
  Non-zero exit status: 1
t0000-basic.sh                                   (Wstat: 256 Tests: 48 Failed: 1)
  Failed test:  43
  Non-zero exit status: 1
t7008-grep-binary.sh                             (Wstat: 0 Tests: 20 Failed: 0)
  TODO passed:   12
t0050-filesystem.sh                              (Wstat: 0 Tests: 10 Failed: 0)
  TODO passed:   6
Files=579, Tests=8561, 893 wallclock secs ( 6.48 usr  2.29 sys + 349.46 cusr 473.32 csys = 831.55 CPU)
Result: FAIL
