From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.6.2
Date: Tue, 06 Sep 2011 16:46:54 -0700
Message-ID: <7vvct55j4h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 01:47:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R15M7-0003ip-Go
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 01:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab1IFXq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 19:46:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755355Ab1IFXq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 19:46:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ABDA5123;
	Tue,  6 Sep 2011 19:46:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=Aw2IggrqDWH+jNYQ8fKjJ6buPrk=; b=jzGp9nGgQ37BsmegJbDKZZcMPf0J
	RSoLrtlMgy+GmNrhNyUOmHjoDIpOeJOEBm1r+LgxaKzFd4mnfwxMUS3v7p3EcZ6A
	BUdyAkVMvPg9VHF/t8HzAp1umFRxDK5VK+GCIuBiu3lv7oFuGTo5li6ltEsFnHVh
	jqtInULXo9faL4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	WOToK0nqozH2vZMNziMIi2wCmjVuYW+VPHlpRFxUCuT6cjaGNDuwFWCDxEEE5gGp
	JeWrVvkxCEAdnM01B5A1xPFJ3AZH7FCWAu9xe8Z6OW0/RXTaJyoUXDRQVHyUD7aE
	lhb6tG0SDJXI4avAAnnMFbVxAOYs9oyZN1EZ27rtjDQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7257C5122;
	Tue,  6 Sep 2011 19:46:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E680B5121; Tue,  6 Sep 2011
 19:46:55 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80FF5D2A-D8E2-11E0-AB2B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180847>

I've tagged the latest maintenance release Git 1.7.6.2 but unfortunately
the tarballs are not available at the usual places. The release can be
fetched from any of the following repositories, at the tip of 'maint'
branch.

	git://repo.or.cz/alt-git.git
	https://github.com/gitster/git
	https://code.google.com/p/git-core/
	git://git.sourceforge.jp/gitroot/git-core/git.git
	git://git-core.git.sourceforge.net/gitroot/git-core/git-core

This is primarily to fix "git push --quiet" breakage in 1.7.6.1.

----------------------------------------------------------------

Changes since v1.7.6.1 are as follows:

Junio C Hamano (3):
      whitespace: have SP on both sides of an assignment "="
      Revert "Merge branch 'cb/maint-quiet-push' into maint"
      Git 1.7.6.2

Pang Yan Han (1):
      update-ref: whitespace fix

Thomas Rast (1):
      Documentation: clarify effects of -- <path> arguments
