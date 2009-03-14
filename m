From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] [TopGit] Portability: Don't use alternation ("|") in
 sed regular expressions
Date: Fri, 13 Mar 2009 22:54:41 -0700
Message-ID: <7vvdqcejj2.fsf@gitster.siamese.dyndns.org>
References: <78BA729B-0026-45D0-96FC-330700519AAB@dartmouth.edu>
 <20090312152039.GA15626@pengutronix.de>
 <20090312152630.GA26379@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Brian Campbell <brian.p.campbell@dartmouth.edu>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sat Mar 14 06:56:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiMrB-0008OK-1E
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 06:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbZCNFyw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2009 01:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbZCNFyw
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 01:54:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbZCNFyv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2009 01:54:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E0EC50B5;
	Sat, 14 Mar 2009 01:54:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 90EEB50B4; Sat,
 14 Mar 2009 01:54:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A126E92A-105C-11DE-A9AE-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113235>

martin f krafft <madduck@madduck.net> writes:

> also sprach Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [2=
009.03.12.1620 +0100]:
>> IMHO we should reuse as much as possible from git.git.  For me even
>> requiring a git.git checkout to use its files would be OK.  I consid=
er
>> that even better then duplicating the relevant files.
>
> Maybe we could even start to think about integrating TopGit back
> into git.git?

Heh, it would need massive style fixes before that happens. I am fairly
picky on shell script styles.
