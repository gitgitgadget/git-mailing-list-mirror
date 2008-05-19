From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] t7701-repack-unpack-unreachable.sh: check timestamp of
 unpacked objects
Date: Sun, 18 May 2008 21:37:05 -0700
Message-ID: <7vd4niaozy.fsf@gitster.siamese.dyndns.org>
References: <16342222.1211083116270.JavaMail.teamon@b306.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: drafnel@gmail.com
X-From: git-owner@vger.kernel.org Mon May 19 06:38:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxx8Z-0006KL-9Z
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 06:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbYESEhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 00:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbYESEhY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 00:37:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbYESEhX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 00:37:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F332F34A8;
	Mon, 19 May 2008 00:37:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5410834A6; Mon, 19 May 2008 00:37:17 -0400 (EDT)
In-Reply-To: <16342222.1211083116270.JavaMail.teamon@b306.teamon.com>
 (drafnel@gmail.com's message of "Sat, 17 May 2008 23:00:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 44F13DA8-255D-11DD-BC67-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82410>

drafnel@gmail.com writes:


> +	test -f "$fsha1path" -a ! "$fsha1path" -nt "$packfile" -a \
> +				! "$fsha1path" -ot "$packfile" &&
> +	test -f "$csha1path" -a ! "$csha1path" -nt "$packfile" -a \
> +				! "$csha1path" -ot "$packfile" &&
> +	test -f "$tsha1path" -a ! "$tsha1path" -nt "$packfile" -a \
> +				! "$tsha1path" -ot "$packfile"
> +'

"Test" primaries -nt/-ot are unfortunately excluded from POSIX.
