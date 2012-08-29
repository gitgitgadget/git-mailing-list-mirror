From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] revision (no-)walking in order
Date: Tue, 28 Aug 2012 23:46:48 -0700
Message-ID: <7vd32axkiv.fsf@alter.siamese.dyndns.org>
References: <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
 <1346220956-25034-1-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 08:47:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6c3G-0003Id-1T
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 08:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986Ab2H2Gqw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Aug 2012 02:46:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40600 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995Ab2H2Gqv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Aug 2012 02:46:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F57D7683;
	Wed, 29 Aug 2012 02:46:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=y66IYAIIo2Ki
	FIjTBPDVPpp0cno=; b=Fm0nIgmZCM0EUO7Am2Iv0b6N6eKKqU3NXJiialCFp9Z+
	8atKWgxuBhGoHuvobhvhpFf3LL4vxPOkz0lLMJRnnGv01XmNfVc2Dt72VP45qNgN
	gIQ36K4K9vHj4HlEaOW4PCmk5deGOX/PdPuK6OGpyaLZQxDg39/p7ocmO7UNN0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AY7X/q
	pcPBuPvw3l8Fv/m2l3fjqiQt8/E0OoqMqD7RpWp7SvgRSIMIABUO1iE9Hew1tsQU
	/y7FLVB6vkCggyYKLgP+6uzLTqb6LrZ7ddtGCs9hwu/3e+CycEkMWxITg7blKVey
	h/vo7186Z0CUANZKAlHNqNvn7ovoJH7LyEjwM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D5977682;
	Wed, 29 Aug 2012 02:46:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01CF27681; Wed, 29 Aug 2012
 02:46:49 -0400 (EDT)
In-Reply-To: <1346220956-25034-1-git-send-email-martinvonz@gmail.com> (Martin
 von Zweigbergk's message of "Tue, 28 Aug 2012 23:15:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F4CDB5E-F1A5-11E1-9C0C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204470>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> Btw2, I'm migrating my email to martinvonz@gmail.com (not y@google.co=
m
> ;-) which saves a few keystrokes and matches some of my other
> accounts, so these patches will be the first ones from the new
> address.

Please send in something like this, then.

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git i/.mailmap w/.mailmap
index 6303782..2650f9e 100644
--- i/.mailmap
+++ w/.mailmap
@@ -43,6 +43,7 @@ Lars Doelle <lars.doelle@on-line.de>
 Li Hong <leehong@pku.edu.cn>
 Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
 Martin Langhoff <martin@laptop.org>
+Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@gm=
ail.com>
 Michael Coleman <tutufan@gmail.com>
 Michael J Gruber <git@drmicha.warpmail.net> <michaeljgruber+gmane@fast=
mail.fm>
 Michael W. Olson <mwolson@gnu.org>
