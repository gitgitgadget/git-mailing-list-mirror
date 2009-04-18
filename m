From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_local_heads(): do not return random pointer if there
 is no head
Date: Fri, 17 Apr 2009 22:02:00 -0700
Message-ID: <7vljpyy2pj.fsf@gitster.siamese.dyndns.org>
References: <1239920183-29512-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 07:03:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv2iP-0005oX-Az
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 07:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbZDRFCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2009 01:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbZDRFCI
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 01:02:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbZDRFCH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2009 01:02:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 27C9610320;
	Sat, 18 Apr 2009 01:02:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5D0981031A; Sat,
 18 Apr 2009 01:02:02 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1024AD1E-2BD6-11DE-9BCE-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116812>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> it's silly to do this:
>
> mkdir foo && cd foo && git init && git push somewhere.git
>
> but segfault should not happen even in that case.

Thanks.
