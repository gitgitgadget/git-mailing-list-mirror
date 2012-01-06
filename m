From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.8.3
Date: Fri, 06 Jan 2012 13:53:53 -0800
Message-ID: <7vsjjsijke.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 22:54:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjHjo-0003VW-RA
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 22:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759055Ab2AFVx4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jan 2012 16:53:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32813 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756924Ab2AFVxz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2012 16:53:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DCDF52C2;
	Fri,  6 Jan 2012 16:53:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=QZw6VKqSaU0aI+AjV+nj+xfqW
	ZM=; b=fRU8qXlJa1oa4UDuCvD9+5jZnr+zl8r1hNIKpEkm6ifRHyOTnwtICuh86
	J0qx7Q2ja/MmY+7c5Wa1UeU9f6T/weJi4Bt6A3BPvfr7gpQ/31w3p7TUctT/wabG
	nnon24cMS7LFp/qhhRhngbaFWDJtSa22u7oq21aJb8X1yGaeV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Fz4Zpg14143STmxAY76
	m6hOaFjWp+ZCwomsbCNCuNLQ/oZkINXw1LY6Ip0bt52ZjRwYm9D8wf0HtK2w6081
	yoXLZypm6xRDh7rq82OZQw7TrwttAbzteQYpR8yvy2VClqW8R39nEXv5hdzTrEG6
	mnAWJAOInxFPE8fQBr2AeES0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 258EA52C1;
	Fri,  6 Jan 2012 16:53:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A258452C0; Fri,  6 Jan 2012
 16:53:54 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED6FD11E-38B0-11E1-B5ED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188048>

The latest maintenance release Git 1.7.8.3 is available.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

e5eb8c289b69d69fd08c81b587a06eb5dd2b5c1c  git-1.7.8.3.tar.gz
8a65d2425c1b6f646d130cf5846e92e9e0e93736  git-htmldocs-1.7.8.3.tar.gz
a6e2b7cff8181ee52a1cc00ebba7b349850d6680  git-manpages-1.7.8.3.tar.gz

Also the following public repositories all have a copy of the v1.7.8.3
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Changes since v1.7.8.2 are as follows:

Brian Harring (1):
      fix hang in git fetch if pointed at a 0 length bundle

Clemens Buchacher (2):
      Documentation: read-tree --prefix works with existing subtrees
      t5550: repack everything into one file

Jack Nagel (1):
      Add MYMETA.json to perl/.gitignore

Jakub Narebski (1):
      gitweb: Fix fallback mode of to_utf8 subroutine

Jens Lehmann (1):
      docs: describe behavior of relative submodule URLs

Junio C Hamano (1):
      Git 1.7.8.3

J=C3=BCrgen Kreileder (3):
      gitweb: Call to_utf8() on input string in chop_and_escape_str()
      gitweb: esc_html() site name for title in OPML
      gitweb: Output valid utf8 in git_blame_common('data')

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      Catch invalid --depth option passed to clone or fetch

Thomas Rast (1):
      Documentation: rerere.enabled is the primary way to configure rer=
ere
