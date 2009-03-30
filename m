From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] send-email: refactor and ensure prompting doesn't 
 loop forever
Date: Sun, 29 Mar 2009 23:50:03 -0700
Message-ID: <7v3acvjyhw.fsf@gitster.siamese.dyndns.org>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
 <76718490903281848l5102afc3x89eed40ed6083dcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 08:51:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoBLR-0007d0-Ot
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 08:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158AbZC3GuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 02:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733AbZC3GuL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 02:50:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbZC3GuK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 02:50:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 542C6AA17;
	Mon, 30 Mar 2009 02:50:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AE875AA14; Mon,
 30 Mar 2009 02:50:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 01F9EF08-1CF7-11DE-AAEC-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115089>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Sat, Mar 28, 2009 at 9:39 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
>> There are three callers of the function:
>
> Where by "three" I mean "four". Please use this commit message instead:

Thanks.
