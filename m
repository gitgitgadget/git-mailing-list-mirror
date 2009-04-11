From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] archive: do not read .gitattributes in working 
 directory
Date: Sat, 11 Apr 2009 12:22:49 -0700
Message-ID: <7v8wm7f112.fsf@gitster.siamese.dyndns.org>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com>
 <1239260490-6318-2-git-send-email-pclouds@gmail.com>
 <1239260490-6318-3-git-send-email-pclouds@gmail.com>
 <1239260490-6318-4-git-send-email-pclouds@gmail.com>
 <7vws9u2ov4.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0904090353s4ec770bfk3cd3f6559c367a20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:25:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsipE-0004sO-Ib
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758905AbZDKTW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758900AbZDKTWz
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:22:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758870AbZDKTWy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:22:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 34F35EE92;
	Sat, 11 Apr 2009 15:22:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8985AEE90; Sat,
 11 Apr 2009 15:22:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27E410C8-26CE-11DE-8259-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116329>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Maybe just remove the option and make --fix-attributes
> default for git-tar-tree. In other words, keep git-tar-tree's current
> behaviour.

That sounds like a sensible approach to me.

Thanks.
