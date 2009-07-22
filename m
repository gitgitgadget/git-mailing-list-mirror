From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] grep: Add --max-depth option.
Date: Wed, 22 Jul 2009 11:44:43 -0700
Message-ID: <7v1vo8k15w.fsf@alter.siamese.dyndns.org>
References: <1248285135-9033-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:45:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTgoH-0007nm-U3
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 20:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbZGVSos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 14:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbZGVSos
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 14:44:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbZGVSor (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 14:44:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 91DCC10449;
	Wed, 22 Jul 2009 14:44:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0CF0710448; Wed,
 22 Jul 2009 14:44:44 -0400 (EDT)
In-Reply-To: <1248285135-9033-1-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Wed\, 22 Jul 2009
 19\:52\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BB17E5BA-76EF-11DE-A4D7-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123768>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> I've merged count_chars() into accept_subdir(), changed OPT_INTEGER t=
o
> OPTION_INTEGER, which allowed me to set argh to "<depth>", to be more
> consistent with git-grep.txt, and revised documentation.

Thanks.  Will queue.
