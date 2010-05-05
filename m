From: Junio C Hamano <gitster@pobox.com>
Subject: 1.7.2 cycle will open soon
Date: Tue, 04 May 2010 22:39:59 -0700
Message-ID: <7vaaselxe8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 07:40:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9XLD-0001Dq-AZ
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 07:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720Ab0EEFkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 01:40:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266Ab0EEFkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 01:40:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 06B01B01CC;
	Wed,  5 May 2010 01:40:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=GNxL
	8mXCHd4c5Qd5pzX76I/iRR0=; b=WJgf247ejUWOwUMdrhzto2qLyRNmkn/S1M8E
	cVzih4ms60ML+F2X41nHIsocbupjhr6phSTDcpESCfGF4d0Ujd16Sz52YBcsNjHB
	8W724M3oWUZdY5DQMPKDu3/bNtOA9CFdn4CnFCR/GkuRCDUQ18Ftxk+WfcJUnep+
	lOwIZYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	fqv4w9d3RjNFTej5Rv9uK4T2fmwsV2zgKn4sEsSWS9XKxy/DOmYmtL8UEWuu/jhI
	8ZvRjpml7v2Bv+X59HzxNJEFnMhK56YX0rRSpFZejfWat1bkaJDrSxoW4K/0EUs5
	Lm1lYNC/WDDbS5dIgugvJCIEriPn2ba3aiiwel1uFZw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF533B01CB;
	Wed,  5 May 2010 01:40:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDBCFB01CA; Wed,  5 May
 2010 01:40:00 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A773C024-5808-11DF-81C7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146375>

The usual post-release ritual.

 - The tip of 'next' has been rebuilt on top of the release, with topics
   that have been cooking;

 - The 'maint' branch is now for 1.7.1.X series; and

 - What have been cooking in 'next' during the pre-release freeze period
   for 1.7.1 should start graduating to 'master' soon.

It appears that the tip of 'maint' and 'next' (but curiously not 'master')
do not pass test t1504 on at least FreeBSD right now, but I don't have
enough energy to hunt things down tonight.
