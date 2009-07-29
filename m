From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Output from git diff
Date: Wed, 29 Jul 2009 11:26:56 -0700
Message-ID: <7vab2nuyz3.fsf@alter.siamese.dyndns.org>
References: <87hbwxaolw.fsf@krank.kagedal.org>
 <873a8fflt2.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Jul 29 20:27:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWDrv-0007l2-Pw
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 20:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbZG2S1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 14:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbZG2S1E
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 14:27:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbZG2S1E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 14:27:04 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F08D15401;
	Wed, 29 Jul 2009 14:27:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0AF8C153FD; Wed, 29 Jul 2009
 14:26:57 -0400 (EDT)
In-Reply-To: <873a8fflt2.fsf@krank.kagedal.org> ("David =?utf-8?Q?K=C3=A5g?=
 =?utf-8?Q?edal=22's?= message of "Wed\, 29 Jul 2009 19\:20\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 68DD16FC-7C6D-11DE-9402-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124376>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> And what should the documentation really say?

"git diff" unlike "git diff-<whatiscompared>" is a Porcelain, to produc=
e
human-readable output, and defaults to the abbreviated form.
