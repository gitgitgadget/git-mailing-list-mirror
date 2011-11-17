From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.8.rc3
Date: Thu, 17 Nov 2011 14:10:44 -0800
Message-ID: <7vbosammcb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 23:10:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRAAX-0007ez-Ck
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 23:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab1KQWKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 17:10:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533Ab1KQWKr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 17:10:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0F3D6BC0;
	Thu, 17 Nov 2011 17:10:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=e
	qkRNQp/x3wxkYu1/WvoFEZWUpI=; b=D0/w7iqrf/5NctpT9RebxBRCE2dMd9zK+
	eQWJpGDyxrcCNeS3ZRWKeFoPwtTT0jQloz5MPUwuKhYPbUnurzPLurHH0qX5p0Pm
	GlO5uNKtaqD+SwpcPCx4zNEPRAaDdqCwgJ8QhV4x90jF2VVyGck9GnYwvl5r6Fqb
	Zncgt9xJWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=v+2
	CNPyV1+1FOKHgGkP3q5hXFw/hkLN0yrqW4rTz453wgGOdLcyoNDQacO3DBdyNsSD
	O1cwKSnib7tNOn2HzBpyEkEv4/awIfy7c0UmJ6mQX7NJZ3V/+ggxDm8fpjZWO6Of
	Czxc1CYyfs0o+6SZDqSJ3aHTDF6QwJWIRpKqJcLM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C57B46BBF;
	Thu, 17 Nov 2011 17:10:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 534616BBE; Thu, 17 Nov 2011
 17:10:46 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFC9CB04-1168-11E1-A4EE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185610>

A release candidate Git 1.7.8.rc3 is available for testing. We should
hopefully be able to see the final early next week.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

cc142fe293e289e473cd7259c695bb6a4c520fa8  git-1.7.8.rc3.tar.gz
9261e59da9da8027204bf45d84a0dd15041ba45d  git-htmldocs-1.7.8.rc3.tar.gz
d01b5cc48ab5e5a3eea7aa8fd575b4943e36a78d  git-manpages-1.7.8.rc3.tar.gz

Also the following public repositories all have a copy of the v1.7.8.rc3
tag and the master branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Changes since v1.7.8-rc2 are as follows:

Junio C Hamano (3):
      Revert "upload-archive: use start_command instead of fork"
      refs: loosen over-strict "format" check
      Git 1.7.8-rc3

Ramkumar Ramachandra (1):
      revert: prettify fatal messages
