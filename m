From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/3] Introduce a perf test for interactive rebase
Date: Tue, 10 May 2016 17:36:30 +0200 (CEST)
Message-ID: <cover.1462894344.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 17:36:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b09iF-0000uG-Ge
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 17:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbcEJPgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 11:36:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:52658 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272AbcEJPgi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 11:36:38 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LhwAY-1bMVor2oWw-00n7V2; Tue, 10 May 2016 17:36:31
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:K9yJA9FK3ofYeq8gWbn07gWlYDV0rb3zeCjM4Qub81yYISn8rrU
 t5GZMZYkAQRc/VRkTS+K2uCF3H4iPvRDGW9efIes5yXAkwD6VVB8K2yYpPP9hoxXPmvk3gZ
 +N8i9uQ1CmFu3BV10AXgxLBgeXUulePRdGyPcAZ5dGIMJ3DOnLdlb5zKBcUGdsWeEzAOc76
 w6Ok0pPNSw/p8d0Qv/PJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:15AJN9HmL8Q=:a2KuvsJwbdhmQQB/5rDdcj
 1aD97t7n23fZN7FezBqsEyB60sHLHPNSSdQ7AApjUrzOjJExVeoe9HMb6hFIc+BHymjta3Q2G
 5/kQgfMyEp46RMjJrIviG7+in7h7NkiwGXySc0rbONYWc8aInLDgtV3tbcedcQiti1QpoeftM
 6vA0/WUv3JeKxPPxd9aIY4z5R+qUq83brggxWbv9KgJgpmgrE/y7vALp/NZoOkZtS3tposShT
 7gNm9HBMueZF9WL6XdSp8P3WgWRnwUQIUGHNudEdyI0569m0JcG41EaNFWLGOZUi0WTKron0X
 +9wBlyHn0W9rstf5nFlt5M8unvVb9GMFsskoQYcXSpgCcoEjspldBVv5zaysNNdWHULlfcqzu
 0NUdAkZVm1jbw8aaqoh7ifbj8FgIO6CmPMi1ts/NBVWzPkn115jDb5X4Erg2qPkS3Du5PI9iV
 h9QY09yDYHWr6Z95rl6wl4AlHK8oa9mLzkpXKwv3o23A4gLkziMi0Ij8Efqp0THepMDkedNye
 gu+N8VHvn8nkckse5sJklgf0dSRVMGaioAi6aB34IqWmQ2CO8OZQU6P+cu7x9HrJkxssE8EHO
 ueWJbVCgzWlXcXm/mjMWzLed/R7tryk6KieU66iR50w9uA+kMwIBr+28mkYX1WwE+T4SQTsVT
 jpf9hB5q85O+/daa2NDXBKD7mkroXHFI9nl3B/eooqfc4UZogxKZjezRe/drEz0R9uR9VRdLs
 qRzvarY50P9tSvfE05NbGPMahac6QUTb4wKa0YAYBrq180Bd+nMuqN02WQlbPgQk/NJ41XM/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294149>

This is the second preparatory patch series for my rebase--helper work
(i.e. moving parts of the interactive rebase into a builtin).

It simply introduces a perf test (and ensures that it runs in my
environment) so as to better determine how much the performance changes,
really.


Johannes Schindelin (3):
  perf: let's disable symlinks on Windows
  perf: make the tests work in worktrees
  Add a perf test for rebase -i

 t/perf/p3404-rebase-interactive.sh | 31 +++++++++++++++++++++++++++++++
 t/perf/perf-lib.sh                 | 18 +++++++++++-------
 2 files changed, 42 insertions(+), 7 deletions(-)
 create mode 100755 t/perf/p3404-rebase-interactive.sh

Published-As: https://github.com/dscho/git/releases/tag/perf-rebase-i-v1
-- 
2.8.2.465.gb077790
