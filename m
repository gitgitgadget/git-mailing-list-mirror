From: Junio C Hamano <gitster@pobox.com>
Subject: Post 1.7.5 plans
Date: Mon, 25 Apr 2011 15:10:22 -0700
Message-ID: <7vei4qhtip.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 00:10:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QETzG-0000JO-7x
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 00:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487Ab1DYWK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 18:10:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab1DYWK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 18:10:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA33E5159;
	Mon, 25 Apr 2011 18:12:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=V
	rJm9hzB49lyHOSdZJRt+QBVad0=; b=OqSnGWVNjtcL5lledZ1+pjCP06dwLFxBE
	Z5kWwfmL0HeWQ0ENm2mbUOyX0wQmIVj79kAkhdPZBYG7pFP7vzr/tD5MC7Tzl1tk
	d4ncz80WNV/kUaAbduo7qPYhhCE5r3tjOd5vtH9yp1QfnXDagJtJ1PePlgWgfowg
	65yBInoq4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=UP6
	JK42h4YT3QwsySj90PZOUXY4lHiAFYZRlKPVYC5l5VVcyRL/yP2xetrIZECXXGiZ
	90ZqsXLfHJTyBjGkOQamxv6fxO6woZ8Ol7HkyBFqnphu0K7RUR/WjARnblH86UnT
	war6pUEOiOwn3UhSB3kLXNiEyU96HSVK25Tg9jfQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7F885157;
	Mon, 25 Apr 2011 18:12:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 158DA5156; Mon, 25 Apr 2011
 18:12:25 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B160788-6F89-11E0-B4F7-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172051>

Now that 1.7.5 is out, let's plan the next cycle toward 1.7.6.  Here is a
rough timetable I have in mind:

* Apr 25th (Week #1 of post 1.7.5 cycle)

  Post release clean-up.  Give higher priority regression fixes if/when
  found.

  Start merging some topics that have been cooking in "next" during the
  last cycle (see "What's cooking" I'll send out later today).

* May 2nd (Week #2) thru May 29th (Week #5)

  The usual "busy development" period.  New topics queued to "next" and
  graduating to "master", etc.

* June 1st (Week #6): 1.7.6-rc0 (Tentative feature freeze).

  Most of the 1.7.6 topics should be in "master" but allow a few topics to
  cook a bit longer in "next".

* June 8th (Week #7): 1.7.6-rc1 (Feature freeze).

* June 15th (Week #8): 1.7.6-rc2.

* June 19th (end of Week #8): 1.7.6 (Final).

We might slip for one week and do 1.7.6-rc3 on 22nd, final on 26th.  We
will hopefully know which by the middle of June.

Personally I am looking forward to see the remainder of i18n series (not
l10n at this moment yet) and the fundamental parts of magic pathspec
(i.e. ":(root):") series to be in the next release.  It would be really
nice if we can revisit some topics that have been stalled during this
cycle.
