From: Junio C Hamano <gitster@pobox.com>
Subject: [gmane.comp.version-control.git] [PATCH 0/4] gitk crash fix and locale updates
Date: Mon, 26 Oct 2015 17:16:20 -0700
Message-ID: <xmqqziz5dv3f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Takashi Iwai <tiwai@suse.de>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 01:16:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqrwC-00060e-C0
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 01:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbbJ0AQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 20:16:24 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750878AbbJ0AQX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 20:16:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 347D52604C;
	Mon, 26 Oct 2015 20:16:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=s
	IZ63K9UT7zXuQuHrl/bB35PErk=; b=kUoolzkZOxU6e3QHIhPI1E5y5c8DfYAlv
	ZFz4Q2Ts95vA8GZ4tXBUyluIdgwxidrZefr6YM+0nz45xmOxxs3zEcS455x9MuPM
	t39NiXWRhHpficKCHa5XZb8Yp3ozamm0DQk+QF9yd6aWDJ/Kn/IY5WFK04NOKOso
	fxGmkezk2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=dnOEv/za+IIMo/+JT6g4Jp6KwHxnE3GCcn5irM2h9oD7KyuRXb4gnHO0
	IcU9zvpVZJwV/0ih3yycuHqDIfV+wtj8JWkETzPrVz8Oe5K31S00NXWj6y++m/eI
	juLkuXypH++hwVQ3us7YCXoAONSyZfCQiFxwp2VFq6huUs+j8OI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B83C2604B;
	Mon, 26 Oct 2015 20:16:22 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A4EB92604A;
	Mon, 26 Oct 2015 20:16:21 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3A162BA-7C3F-11E5-B524-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280235>

Ping.  What do you think of these?  It appears that quite a many
people are getting bitten by the issues this series addresses.

Thanks.

From: Takashi Iwai <tiwai@suse.de>
Newsgroups: gmane.comp.version-control.git
Subject: [PATCH 0/4] gitk crash fix and locale updates
Date: Tue, 20 Oct 2015 14:33:00 +0200
Message-ID: <1445344384-12762-1-git-send-email-tiwai@suse.de>
Xref: news.gmane.org gmane.comp.version-control.git:279910
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279910>

Hi,

the recent change in gitk to support the menu accelerator broke the
invocation with --all option in non-English locales.  Also, the whole
menu translations are gone by this, too.  This patchset tries to
address these issues.


Takashi

===

Takashi Iwai (4):
  gitk: Fix crash with --all in non-English locales
  gitk: Update msgid's for menu items with accelerator
  gitk: Add accelerators to Japanese locale
  gitk: Add accelerator to German locale

 gitk-git/gitk        |  4 +--
 gitk-git/po/bg.po    | 34 ++++++++++++-------------
 gitk-git/po/ca.po    | 34 ++++++++++++-------------
 gitk-git/po/de.po    | 70 ++++++++++++++++++++++++++--------------------------
 gitk-git/po/es.po    | 34 ++++++++++++-------------
 gitk-git/po/fr.po    | 34 ++++++++++++-------------
 gitk-git/po/hu.po    | 34 ++++++++++++-------------
 gitk-git/po/it.po    | 36 +++++++++++++--------------
 gitk-git/po/ja.po    | 68 +++++++++++++++++++++++++-------------------------
 gitk-git/po/pt_br.po | 34 ++++++++++++-------------
 gitk-git/po/ru.po    | 34 ++++++++++++-------------
 gitk-git/po/sv.po    | 34 ++++++++++++-------------
 gitk-git/po/vi.po    | 34 ++++++++++++-------------
 13 files changed, 242 insertions(+), 242 deletions(-)

-- 
2.6.1
