From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.5.1
Date: Tue, 03 Dec 2013 13:47:49 -0800
Message-ID: <xmqq8uw1mwmb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 22:51:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnxsl-00068l-GZ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 22:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab3LCVvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 16:51:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530Ab3LCVvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 16:51:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1263F56E86;
	Tue,  3 Dec 2013 16:51:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=P
	AsLBp5141ApEtAseAJVfCSUAYQ=; b=kVlYU9z6YYdFDPcXCTpDb/SIT4H0sUTeo
	41kNPRFDx73K0bBlcKkmoXN8AYqkQYHMTlTPaGMevMQ1NZgeLDd9oWyTuaF6PAXb
	EztyQFx1I33q2V6LatHVnEYu0OUvoE0Ekrb2KoA7jkXQrKn1E7+FvohRBNSSIb5N
	taVkce+ew4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Bci1H6Ex4V+5sjpDpKs0bXZifgIq97+ETqbCWw69MoNu+zNP9UkWm9ER
	nxM3j3A9u9PJtTX1nj5UQ7ZOV/Qt8bQ15wt8FnO4jYd10P8ER19WoVCHMTB3b9VY
	PiXlVhR+50xYv9z/OiLhJXc2m/+nAJZHQ3iCsWpUA4k54RUaRKY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B63E256E84;
	Tue,  3 Dec 2013 16:51:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D6FE56E6D;
	Tue,  3 Dec 2013 16:51:40 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 18EE1C5E-5C65-11E3-8B4D-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238739>

The latest maintenance release Git v1.8.5.1 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

dcd244c7198e8afe42ab223f7b3c9b1ae01749c3  git-1.8.5.1.tar.gz
16cd5fdf486aa880c4fcb297d769070c67996317  git-htmldocs-1.8.5.1.tar.gz
32befa65b564640981d71f8a38eee19939a2eb63  git-manpages-1.8.5.1.tar.gz

The following public repositories all have a copy of the v1.8.5.1
tag and the maint branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Also, http://www.kernel.org/pub/software/scm/git/ has copies of the
release tarballs.

Git v1.8.5.1 Release Notes
==========================

Fixes since v1.8.5
------------------

 * "git submodule init" copied "submodule.$name.update" settings from
   .gitmodules to .git/config without making sure if the suggested
   value was sensible.

----------------------------------------------------------------

Changes since v1.8.5 are as follows:

Junio C Hamano (3):
      submodule: do not copy unknown update mode from .gitmodules
      Git 1.8.4.5
      Git 1.8.5.1

Nick Townsend (1):
      ref-iteration doc: add_submodule_odb() returns 0 for success
