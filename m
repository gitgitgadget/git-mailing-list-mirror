From: Junio C Hamano <gitster@pobox.com>
Subject: Re: =?utf-8?Q?RE=C2=A0=3A?= trailling whitespace with git am ?
Date: Fri, 14 Aug 2009 13:31:02 -0700
Message-ID: <7vab22i1dl.fsf@alter.siamese.dyndns.org>
References: <606CC410B038E34CB97646A32D0EC0BF0181FAB4@venusbis.synchrotron-soleil.fr>
 <81b0412b0908141310x7e4acf4fgf4ea71cf53de6eea@mail.gmail.com>
 <606CC410B038E34CB97646A32D0EC0BF0181FABD@venusbis.synchrotron-soleil.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Alex Riesen" <raa.lkml@gmail.com>, <git@vger.kernel.org>
To: PICCA =?utf-8?Q?Fr=C3=A9d=C3=A9ric-Emmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:31:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc3Qs-0000VX-7D
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 22:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932872AbZHNUbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 16:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932855AbZHNUbI
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 16:31:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932871AbZHNUbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 16:31:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 375A629732;
	Fri, 14 Aug 2009 16:31:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BD37C29731; Fri, 14 Aug 2009
 16:31:03 -0400 (EDT)
In-Reply-To: <606CC410B038E34CB97646A32D0EC0BF0181FABD@venusbis.synchrotron-soleil.fr>
 ("PICCA =?utf-8?Q?Fr=C3=A9d=C3=A9ric-Emmanuel=22's?= message of "Fri\, 14 Aug
 2009 22\:21\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 65BB7418-8911-11DE-A30C-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125949>

PICCA Fr=C3=A9d=C3=A9ric-Emmanuel  <frederic-emmanuel.picca@synchrotron=
-soleil.fr>
writes:

> how can I do the difference between a patch with normal CR+LF (the au=
tor use this format)
> and a patch without CR+LF due to the webmail ?

That is a question to your webmail provider but I think you generally
can't.  Use dos2unix as Alex suggested and you should be fine.
