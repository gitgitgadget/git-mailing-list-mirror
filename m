From: =?UTF-8?B?TmlrbGFzIEhhbWLDvGNoZW4=?= <mail@nh2.me>
Subject: git format-patch --in-reply-to allows header injection. Intended?
Date: Thu, 04 Sep 2014 23:21:49 +0200
Message-ID: <5408D7ED.9010203@nh2.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: petr.mvd@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 23:29:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPebE-0006GN-MK
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 23:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914AbaIDV3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 17:29:39 -0400
Received: from mail.grenz-bonn.de ([178.33.37.38]:53494 "EHLO
	mail.grenz-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbaIDV3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 17:29:36 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Sep 2014 17:29:36 EDT
Received: from [192.168.157.39] (unknown [74.125.61.156])
	by ks357529.kimsufi.com (Postfix) with ESMTPSA id 9E28A7CADB;
	Thu,  4 Sep 2014 23:22:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Spam-Status: No, score=1.3 required=8.0 tests=RDNS_NONE autolearn=no
	version=3.3.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on ks357529.kimsufi.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256483>

Hi,

I just wanted to ask if the --in-reply-to flag of git format-patch is
supposed to write the given string unmodified into the email or whether
it ought to perform some check against header injection.

For example, if you pass "--in-reply-to=<msgid>\nTo: <other@example.com"
(notice lack of trailing `>`), then the generated email will actually
contain a
  To: <other@example.com>
header.

(Depending on your shell you might also use "--in-reply-to=`cat`" to get
the above working more easily.)

Is this known and working as intended, or undesired?

Thanks!
Niklas
