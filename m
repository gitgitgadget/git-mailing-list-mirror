From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Sat, 03 May 2008 11:18:31 -0700
Message-ID: <7vy76rtfns.fsf@gitster.siamese.dyndns.org>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
 <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-4-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-5-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 20:19:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsMKU-0008Np-Fa
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 20:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759573AbYECSSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 14:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759546AbYECSSj
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 14:18:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58709 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759374AbYECSSi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 14:18:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2FA2224ED;
	Sat,  3 May 2008 14:18:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 83D1524EC; Sat,  3 May 2008 14:18:33 -0400 (EDT)
In-Reply-To: <1209815828-6548-5-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Sat, 3 May 2008 19:57:07 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 58A41360-193D-11DD-A240-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81110>

Has this series been ever tested?

$ git diff one two
diff --git a/one b/two
index f9facd3..10c6195 100644
--- a/one
+++ b/two
@@ -1 +1 @@
-A quick(brown) fox
+A quick(yellow) fox

$ tail -n 2 .git/config
[diff]
        nonwordchars = "()"

$ git diff --color-words one two
diff --git a/one b/two
index f9facd3..10c6195 100644
--- a/one
+++ b/two
@@ -1 +1 @@
A quick(<red>brown)</red><green>yellow)</green> fox
