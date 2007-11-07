From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Mark 'git stash [message...]' as deprecated
Date: Wed, 7 Nov 2007 09:12:15 +0100
Message-ID: <208BA68A-462D-4EDF-996B-65CFFC3BB5C3@wincent.com>
References: <20071106085134.GD4435@artemis.corp> <1194395205-27905-1-git-send-email-bdowning@lavos.net> <473170AB.7030104@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Downing <bdowning@lavos.net>,
	Junio C Hamano <gitster@pobox.com>, tsuna@lrde.epita.fr,
	aghilesk@gmail.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 07 09:13:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipg21-0007y8-V4
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 09:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748AbXKGIMp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 03:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756725AbXKGIMo
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 03:12:44 -0500
Received: from wincent.com ([72.3.236.74]:49463 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755997AbXKGIMo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 03:12:44 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lA78CHE6028702;
	Wed, 7 Nov 2007 02:12:17 -0600
In-Reply-To: <473170AB.7030104@viscovery.net>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63784>

El 7/11/2007, a las 9:00, Johannes Sixt escribi=F3:

> Brian Downing schrieb:
>> Complain to STDERR unless 'git stash save' is explicitly used.
>> This is in preparation for completely disabling the "default save"
>> behavior of the command in the future.
>> ...
>> -'git-stash' [save] [message...]
>> +'git-stash' save [message...]
>
> Can't we have these two?
>
> 	git-stash
> 	git-stash save [message...]
>
> 'git stash' without a message as an equivalent of 'git stash save' =20
> is still very handy.

Agreed.

Wincent
