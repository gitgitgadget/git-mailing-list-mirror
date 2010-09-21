From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv2 0/4] Add commit message options for rebase
 --autosquash
Date: Tue, 21 Sep 2010 14:24:59 -0600
Message-ID: <1285100703-49087-1-git-send-email-patnotz@gmail.com>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 22:25:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy9P6-0002Ay-8x
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 22:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab0IUUZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 16:25:20 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:47069 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab0IUUZT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 16:25:19 -0400
X-WSS-ID: 0L94622-0C-3NR-02
X-M-MSG: 
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1A86B4E586B
	for <git@vger.kernel.org>; Tue, 21 Sep 2010 14:25:14 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Tue, 21 Sep 2010 14:25:05 -0600
X-Server-Uuid: AF72F651-81B1-4134-BA8C-A8E1A4E620FF
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o8LKOsXh006143 for
 <git@vger.kernel.org>; Tue, 21 Sep 2010 14:24:56 -0600
Received: from s919422.srn.sandia.gov (134.253.71.44) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Tue, 21 Sep 2010 14:25:03 -0600
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1284687596-236-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.9.21.201514
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0,
 BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0,
 BODY_SIZE_800_899 0, DATE_TZ_NA 0, __CP_URI_IN_BODY 0, __CT 0,
 __CT_TEXT_PLAIN 0, __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0,
 __FROM_GMAIL 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0,
 __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_MAILTO 0, __URI_NO_WWW 0,
 __URI_NS '
X-TMWD-Spam-Summary: TS=20100921202505; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230332E34433939313441312E303038333A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 6087CB2B29K4396029-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156750>

This patch series adds new command line options to git-commit to make
it easy to specify messages for commits correctly formatted for use
wit 'rebase -i --autosquash'.

This 2nd iteration address concerns raised earlier:
http://thread.gmane.org/gmane.comp.version-control.git/156369 .  Most
notably, --squash=COMMIT now works with -m/-c/-C/-F and uses the
editor when appropriate.

Pat Notz (4):
  commit: --fixup option for use with rebase --autosquash
  t7500: add tests of commit --fixup
  commit: --squash option for use with rebase --autosquash
  t7500: add tests of commit --squash

 Documentation/git-commit.txt |   19 +++++++--
 builtin/commit.c             |   58 ++++++++++++++++++++++++--
 t/t7500-commit.sh            |   90 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 9 deletions(-)

-- 
1.7.3
