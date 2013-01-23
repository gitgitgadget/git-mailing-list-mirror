From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/6] Change 'git' to 'Git' whenever the whole system
 is referred to #3
Date: Tue, 22 Jan 2013 18:49:48 -0800
Message-ID: <7vfw1sk3zn.fsf@alter.siamese.dyndns.org>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <1667947659.632844.1358796098848.JavaMail.ngmail@webmail20.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:50:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxqPl-0004qc-9q
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 03:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab3AWCtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 21:49:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346Ab3AWCtv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 21:49:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ECD3B331;
	Tue, 22 Jan 2013 21:49:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mproh1Y5IaQOEerfE1Ng1YJ7Suk=; b=Vj0S2L
	x+8vsgzfY0hAcHTiUw2bDIOCuOJceokrMQAUWkg+uYGp0S1/bM2AcOahda4EGj06
	3Uw+HFjPPKHlPxsjtt5DVEVMWGaEXt5JpiGAiFiH3KBvi26RYoqDXiml0nUnBNXH
	bi60I7xv7RMyAAlMffV0LizXp2WxzxCuA7Q/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YP8lI/eFWjo8kyUW1NHTgVGFybtvReH8
	VWgjnsFTbVcqXEIj/LBdFoGuqse1bW3oSl2kBMqis6YfZOUg2XAnuvXPWfZIpi5W
	6JJjzAcgCoCzxd8C45BI5CC2BkP6L44OmTqTX0ECow0vrt9kSkjFRDuZ8VMP48j4
	ESSzl527TQg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21924B330;
	Tue, 22 Jan 2013 21:49:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75DCBB32E; Tue, 22 Jan 2013
 21:49:50 -0500 (EST)
In-Reply-To: <1667947659.632844.1358796098848.JavaMail.ngmail@webmail20.arcor-online.net>
 (Thomas Ackermann's message of "Mon, 21 Jan 2013 20:21:38 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E86A1C6-6507-11E2-A716-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214274>

 Documentation/gitcore-tutorial.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 5d957c2..59c1c17 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1068,7 +1068,7 @@ and requires you to have a log-in privilege over `ssh` to the
 remote machine.  It finds out the set of objects the other side
 lacks by exchanging the head commits both ends have and
 transfers (close to) minimum set of objects.  It is by far the
-most efficient way to exchange git objects between repositories.
+most efficient way to exchange Git objects between repositories.
 
 Local directory::
 	`/path/to/repo.git/`
@@ -1077,7 +1077,7 @@ This transport is the same as SSH transport but uses 'sh' to run
 both ends on the local machine instead of running other end on
 the remote machine via 'ssh'.
 
-git Native::
+Git Native::
 	`git://remote.machine/path/to/repo.git/`
 +
 This transport was designed for anonymous downloading.  Like SSH
-- 
1.8.1.1.507.g1754052
