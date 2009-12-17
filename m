From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.6.6.rc3
Date: Wed, 16 Dec 2009 16:30:57 -0800
Message-ID: <7vaaxiqw5a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763458AbZLQAbQ@vger.kernel.org Thu Dec 17 01:31:34 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763458AbZLQAbQ@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL4HF-0002ob-Ew
	for glk-linux-kernel-3@lo.gmane.org; Thu, 17 Dec 2009 01:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763458AbZLQAbQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 16 Dec 2009 19:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763430AbZLQAbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Dec 2009 19:31:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763111AbZLQAbL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Dec 2009 19:31:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 65B7588737;
	Wed, 16 Dec 2009 19:31:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=n8uRH9bpeTa3Anc/IcW4BAuPW
	KU=; b=At9Rfj6LCV2DFeYcj9DrVC756wdDCUp43g2VsgBtAywcGle/XRZv1WTmh
	tG9A5E6gmGdqB0fUG8Ebv2QEWatp0lQCWYKHBl7Z4m9I+Jwj6mh8OkzVgTfo7XgU
	IwuZr0ygagb3UaTQ23QR4aMsjrS9Svs89zpHPI7f0ZA30xx5Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=P77Zy7VoVnMd2APt/xi
	RVr2uHQCXEMNzLDxonrwOeEryg3FWQX/mS63yZ39FAUOHClVpR4vXHCyslTX5YsS
	+6vVi+BMdjyrLS/ioYixHgMJvhUjsQWnwlqtolWqDtggABEs7pP9mAJfncm9y6Z7
	/1Heg1g8yXens4FuXVoxhjco=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E33088736;
	Wed, 16 Dec 2009 19:31:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 235B68872D; Wed, 16 Dec
 2009 19:30:58 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 758A6E00-EAA3-11DE-9671-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135351>

A release candidate Git 1.6.6.rc3 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.6.rc3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.6.rc3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.6.rc3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.6.6.rc3-1.fc11.$arch.rpm	(RPM)

Things have really calmed down and hopefully we can give the final rele=
ase
as holiday present to everybody in time ;-)

----------------------------------------------------------------

Changes since v1.6.6-rc2 are as follows:

Bj=C3=B6rn Gustavsson (1):
      bash: Support new 'git fetch' options

Jeff King (1):
      ignore unknown color configuration

Johannes Sixt (1):
      help.autocorrect: do not run a command if the command given is ju=
nk

Junio C Hamano (7):
      Remove post-upload-hook
      Fix archive format with -- on the command line
      Git 1.6.5.6
      Update Release Notes for 1.6.6 to remove old bugfixes
      worktree: don't segfault with an absolute pathspec without a work=
 tree
      Git 1.6.5.7
      Git 1.6.6-rc3

Nanako Shiraishi (1):
      Illustrate "filter" attribute with an example
