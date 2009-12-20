From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.6.6.rc4
Date: Sun, 20 Dec 2009 14:59:47 -0800
Message-ID: <7vmy1d9rq4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 00:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMUlL-0006ah-Kg
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 00:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbZLTXAG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2009 18:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754482AbZLTXAB
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 18:00:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbZLTXAA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Dec 2009 18:00:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C0591892A6;
	Sun, 20 Dec 2009 17:59:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=eabxOl1Xbj/eNolNwNm2+Y2Xc
	1E=; b=HNRPOXRtxc+QU8Yer5PNeuBF97SOkn8HobH4gz4ivhd1NaibzwIL3PTbj
	VuldSRnIt8IAIrsqj8Z3fPdixnkssZEtJPVbx9ZKEtipoWMK2eafWd1LMNAK1YqT
	yYfBYAgWWMMBOJ7Z2eCol5sp1egWfi4oiuwNhQFXDBlsSjBYA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Ld++2RGc0r3ZhKrBtzB
	OxOcVdOQOlV7te5RBOMURtsRTdZj1J8pGyWo+ZHqYxCixDOdQnBEz8AsicWLKgjf
	2HZgxbBqpq2sbAvtmP7eeXQdvtuVFsbWKKvazy6VniPOAju9un7+2tet4ClgZrjc
	Gs3ilJYvaBuPPCvv1yQz8NxM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FBD48929F;
	Sun, 20 Dec 2009 17:59:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A22BC8929C; Sun, 20 Dec
 2009 17:59:48 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 62804BF2-EDBB-11DE-A875-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135538>

A release candidate Git 1.6.6.rc4 is available at the usual places
for final testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.6.rc4.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.6.rc4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.6.rc4.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.6.6.rc4-1.fc11.$arch.rpm	(RPM)

Hopefully I'll do the final this Wednesday to make 1.6.6 a holiday gift=
 to
everybody.

I would very much prefer news outlets like kernelpodcast.org and lwn.ne=
t
_not_ to say "... is released; it comes with many _fixes_".  Fixes to
released versions have indeed been included in the 'master' branch, but
they all appear in the maintenance release.  The main _point_ of using =
a
new feature release like 1.6.6 is to get new _features_, so it is more
appropriate to say "it comes with many new features."

Thanks for all contributors who have worked hard to whip this release i=
nto
shape.

----------------------------------------------------------------

Changes since v1.6.6-rc3 are as follows:

Bj=C3=B6rn Gustavsson (1):
      rebase -i: abort cleanly if the editor fails to launch

Eric Wong (2):
      git svn: make empty directory creation gc-aware
      t9146: use 'svn_cmd' wrapper

Junio C Hamano (1):
      Git 1.6.6-rc4

Stephen Boyd (2):
      api-strbuf.txt: fix typos and document launch_editor()
      technical-docs: document hash API
