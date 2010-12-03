From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.0.8, 1.7.1.3 and 1.7.2.4
Date: Thu, 02 Dec 2010 18:21:13 -0800
Message-ID: <7vk4jrppeu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 03:21:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POLH6-0002Zp-9C
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 03:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240Ab0LCCVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 21:21:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab0LCCVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 21:21:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A54063D56;
	Thu,  2 Dec 2010 21:21:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=jNIB
	jyByBD3M6iMYiC8BoCBGtqI=; b=jyuXJYYFdMjkN1D+02P/Zuj5gEWSS6Gi+4t7
	YNuAGWZczG6DlgIp7nASbU2uv+dBA29vQGjYPo/wYIFcoM65fG8nbf6X2Ns8Jb6j
	uUB6vJ9KAyphq0ONEC1JEz44somDL5wdTDq60wo8nN8AuTJRL/V+HrXc4MDjGI9w
	6knNc4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Z/E
	ekz8GYMC1e/RS30BlQ/3l8hZUyU8/7qQXfc+hm475V7Wl+aHnbZAGj4x9r2+GuBI
	oWgHlROa8J8rTFe+bv0c2qhgNVdpD2lRH76Ly5ZcuIzgbZjr+wJtH5UI5bl85yvk
	Z8niICK0LRCu36Jdgm1bqs3pex2yjreC4EEVE8TE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 73A1F3D55;
	Thu,  2 Dec 2010 21:21:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 620A33D54; Thu,  2 Dec 2010
 21:21:34 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0EF297A8-FE84-11DF-A637-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162760>

A few maintenance releases of Git 1.7.0.8, 1.7.1.3 and 1.7.2.4 are
available at the usual places (replace $V below with these version
numbers):

  http://www.kernel.org/pub/software/scm/git/

  git-$V.tar.{gz,bz2}			(source tarball)
  git-htmldocs-$V.tar.{gz,bz2}		(preformatted docs)
  git-manpages-$V.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-$V-1.fc11.$arch.rpm	(RPM)

These are primarily to backport support for the new "add.ignoreErrors"
name given to the existing "add.ignore-errors" configuration variable.

The next version, Git 1.7.4, and future versions, will support both
old and incorrect name and the new corrected name, but without this
backport, users who want to use the new name "add.ignoreErrors" in
their repositories cannot use older versions of Git.
