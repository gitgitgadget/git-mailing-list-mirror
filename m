From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-gui: chmod +x po2msg, windows/git-gui.sh
Date: Mon, 02 Dec 2013 11:27:47 -0800
Message-ID: <xmqqob4zqci4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 02 20:28:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnZA2-0004LG-SL
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 20:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368Ab3LBT1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 14:27:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019Ab3LBT1u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 14:27:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ECA755FAE;
	Mon,  2 Dec 2013 14:27:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=L
	eELcgAccL99a+E/uxSdTHeYZcA=; b=H3RHb8Xm772lb+sxQSfDFaHD0sEtpzv4P
	ciV6MVDzzlCdCAhuzQXSSkEU1vxkDkU0YgSjlnZu3+TScDTqP6uxdaus0Ifrf1pR
	W+WBSu1TYeO9Ju33hGSz6PBoMBu9o3Gyr5F9iZIx9438ofSSrgpzqmv4UmDgbJcz
	HrwgRqY4Ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=fA+JtxU43WyJjUxIS34C8xNGIMv6kTkTvas5wTTlRnzLH44Z+d4w2sqn
	SsGehr8+MX0j3/+GISCEVZusquZYFkT07l//OgDFRa5RoTAe1MgBWmyfMbRIYU8D
	rT61qVM3PkAkazvUD9D9FkYQmHc1AMbCcUhymRINznuEw551P5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE8D855FAD;
	Mon,  2 Dec 2013 14:27:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 283A855FAB;
	Mon,  2 Dec 2013 14:27:49 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D44CB3B8-5B87-11E3-BB87-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238645>

From: Jonathan Nieder <jrnieder@gmail.com>
Date: Mon, 25 Nov 2013 13:01:05 -0800

The Makefile only runs po/po2msg.sh using tclsh, but because the
script has the usual tcl preamble starting with #!/bin/sh it can also
be run directly.

The Windows git-gui wrapper is usable in-place for the same reason.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Pat, can you queue this to your tree?  I seem to be missing a
   handful of commits on your 'master' branch, up to 73fd416b
   (git-gui: correct spelling errors in comments, 2013-11-13), which
   I'll be pulling shortly.

   Thanks.

 po/po2msg.sh       | 0
 windows/git-gui.sh | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 po/po2msg.sh
 mode change 100644 => 100755 windows/git-gui.sh

diff --git a/po/po2msg.sh b/po/po2msg.sh
old mode 100644
new mode 100755
diff --git a/windows/git-gui.sh b/windows/git-gui.sh
old mode 100644
new mode 100755
-- 
1.8.5-386-gb78cb96
