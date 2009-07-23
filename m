From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Trailing whitespace and no newline fix
Date: Wed, 22 Jul 2009 18:58:08 -0700
Message-ID: <7v8wig88jz.fsf@alter.siamese.dyndns.org>
References: <1248308678-23280-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jul 23 03:58:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTnZp-0000DD-It
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 03:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbZGWB6P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 21:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbZGWB6P
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 21:58:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbZGWB6O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 21:58:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D363EE29;
	Wed, 22 Jul 2009 21:58:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 221D0EE28; Wed, 22 Jul 2009
 21:58:09 -0400 (EDT)
In-Reply-To: <1248308678-23280-1-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed\, 22 Jul 2009 19\:24\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 47A852DA-772C-11DE-A46E-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123819>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> If a patch adds a new line to the end of a file and this line ends wi=
th
> one trailing whitespace character and has no newline, then
> '--whitespace=3Dfix' currently does not remove that trailing whitespa=
ce.

Looks obvious and correct.  Thanks.
