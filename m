From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: managing my first project with git, yeay
Date: 02 Dec 2005 19:24:03 -0800
Message-ID: <86iru6c17w.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 03 04:24:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiO0d-0006ed-OH
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 04:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVLCDYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 22:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVLCDYK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 22:24:10 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:18579 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751177AbVLCDYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 22:24:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 04F128F794
	for <git@vger.kernel.org>; Fri,  2 Dec 2005 19:24:04 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 30347-02 for <git@vger.kernel.org>;
 Fri,  2 Dec 2005 19:24:03 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 590FC8F796; Fri,  2 Dec 2005 19:24:03 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.15.4; tzolkin = 2 Kan; haab = 2 Mac
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13144>


So, between yesterday and today, I issued "git-init-db", followed by
enough commands to have done this:

git-diff-tree -p -M 1723 HEAD | git-apply --stat --summary
 lib/GC/App/change_transactions.tt                  |    4 -
 lib/GC/App/edit_snippets.pm                        |    2 
 lib/GC/App/generate_aged_receivables.tt            |    2 
 lib/GC/App/make_manifest.tt                        |    2 
 lib/GC/App/record_adjustment.tt                    |   11 +-
 lib/GC/App/record_payment.pm                       |    7 +
 lib/GC/App/record_payment.tt                       |    7 +
 lib/GC/App/snippet.pm                              |    3 
 lib/GC/App/snippet.tt                              |    2 
 lib/GC/App/welcome.pm                              |    2 
 lib/GC/App/welcome.tt                              |    1 
 lib/GC/DB.pm                                       |   11 ++
 lib/GC/DB/Booking.pm                               |   28 ----
 lib/GC/DB/PersonCruise.pm                          |    3 
 lib/GC/DB/Phone.cfg                                |    1 
 lib/GC/DB/all.pm                                   |   20 ++-
 lib/GC/DB/randal-funcs-4                           |    2 
 lib/GC/DB/randal-funcs-5                           |  132 ++++++++++++++++++++
 lib/GC/DB/randal-funcs-6                           |   14 ++
 lib/GC/ttlib/pcs_to_ar.tt                          |   14 +-
 lib/GC/ttlib/pcs_to_matrix.tt                      |    3 
 lib/GC/ttlib/view/amount_with_button.tt            |   15 ++
 .../view/combo_select_person_ccs_for_payment.tt    |   31 ++++-
 23 files changed, 251 insertions(+), 66 deletions(-)
 create mode 100644 lib/GC/DB/randal-funcs-5
 create mode 100644 lib/GC/DB/randal-funcs-6
 create mode 100644 lib/GC/ttlib/view/amount_with_button.tt

This was on Darwin.  yeay.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
