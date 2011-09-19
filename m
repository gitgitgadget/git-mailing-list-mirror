From: Junio C Hamano <junio@pobox.com>
Subject: [ANNOUNCE] Git 1.7.7.rc2
Date: Sun, 18 Sep 2011 23:15:01 -0700
Message-ID: <7vfwjtawii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Sep 19 08:15:26 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1R5X8U-0001nK-QO
	for glk-linux-kernel-3@lo.gmane.org; Mon, 19 Sep 2011 08:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab1ISGPI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 19 Sep 2011 02:15:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45088 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab1ISGPH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2011 02:15:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C46E1EB6;
	Mon, 19 Sep 2011 02:15:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=CFon8PrUvJCJvI2HAEmZVHrtv
	vg=; b=LXX2oMy12yWTos8MSiLqtahxEMDIfxleNIqrKFZ7eaFDEg99ahkBLg+Iw
	OdaGC7Jq4ueNzkCMQ6D+bBQFSQ5WlSwnVpTLS96+X2AhBYK8D6jef5IV7/ycrsO6
	jzEVaeDhWFteBh5A9I89CKd8qO9Zzv3CqY/wqq9pfp+sVzqk6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=DWbHznm9poLJ/nJq6F3
	Y7owF/Z8maADTkB/PIwVqzzX9Di5TtJElwou4Bf6nCHZqNLksP1g1oUwTE/2lQTP
	bZEp4lKlx6iJd4SUsqoyM8HT68oWaNnxz4ianjakOKszCb16iP/SnqDJQyQmRlFe
	AZDEU4Wt+tKv8/217ODZ6pmc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 636991EB5;
	Mon, 19 Sep 2011 02:15:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 908C81EB4; Mon, 19 Sep 2011
 02:15:03 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6798D06-E286-11E0-989C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181665>

A release candidate Git 1.7.7.rc2 is available but unfortunately not at
the usual places. Even so (rather, exactly because it is in unusual
places, so we are likely to have smaller number of casual observers who
grab and build them), please test it to help us make the upcoming relea=
se
as solid as we could.

A release candidate tarball is found at:

    http://code.google.com/p/git-core/downloads/list
 =20
and its SHA-1 checksum is:

1e0e035148df279af689131273570a7dde45950b  git-1.7.7.rc2.tar.gz

Also the following public repositories all have a copy of the v1.7.7-rc=
2
tag and the master branch that the tag points at:

	url =3D git://repo.or.cz/alt-git.git
	url =3D https://code.google.com/p/git-core/
	url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
	url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
	url =3D https://github.com/gitster/git

----------------------------------------------------------------

Changes since v1.7.7-rc1 are as follows:

Bryan Jacobs (1):
      git-svn: teach git-svn to populate svn:mergeinfo

=46r=C3=A9d=C3=A9ric Heitzmann (1):
      Disambiguate duplicate t9160* tests

Junio C Hamano (2):
      branch --set-upstream: regression fix
      Git 1.7.7-rc2

Pang Yan Han (1):
      format-patch: ignore ui.color
