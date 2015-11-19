From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/7] Modernize t9300-fast-import
Date: Thu, 19 Nov 2015 20:09:42 +0100
Message-ID: <cover.1447959452.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 20:10:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzUb6-0006bo-1m
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 20:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbbKSTKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 14:10:12 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:57843 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030196AbbKSTKK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 14:10:10 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3p1rDc0LDwz5tlH;
	Thu, 19 Nov 2015 20:10:07 +0100 (CET)
Received: from dx.site (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id 7DB7229D8;
	Thu, 19 Nov 2015 20:10:07 +0100 (CET)
X-Mailer: git-send-email 2.6.2.337.ga235d84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281483>

Some time ago, I had to dig into t9300-fast-import and found it quite
unhelpful that it does not follow our modern best-practices. This series
brings it up-to-date. I thought I submit it now while it is quiet in
the area.

The larger patches are best viewed using -w -color-words because the
regular patch text is ... overwhelming.

Improving shell coding style is outside the scope of this series. I mean
fixing eyesores such as 'cat >foo <<EOF && cat foo | sort > bar', or minor
things such as quoting <<\EOF when the here-doc does not require
substitutions.

In case the large patches don't make it to the list, the series is also
available from

  https://github.com/j6t/git.git modernize-t9300

Johannes Sixt (7):
  modernize t9300: single-quote placement and indentation
  modernize t9300: use test_must_fail
  modernize t9300: use test_must_be_empty
  modernize t9300: wrap lines after &&
  modernize t9300: use test_when_finished for clean-up
  modernize t9300: mark here-doc words to ignore tab indentation
  modernize t9300: move test preparations into test_expect_success

 t/t9300-fast-import.sh | 3629 ++++++++++++++++++++++++------------------------
 1 file changed, 1822 insertions(+), 1807 deletions(-)

-- 
2.6.2.337.ga235d84
