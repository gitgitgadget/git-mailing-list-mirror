From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mailinfo: Fix getting the subject from the body
Date: Thu, 10 Jul 2008 16:25:34 -0700
Message-ID: <7v3amhnwy9.fsf@gitster.siamese.dyndns.org>
References: <4876820D.4070806@etek.chalmers.se>
 <7vod55o0tx.fsf@gitster.siamese.dyndns.org>
 <48768F30.8070409@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:26:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5XF-0006Va-QF
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbYGJXZn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 19:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbYGJXZn
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:25:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbYGJXZm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 19:25:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7ECB12504A;
	Thu, 10 Jul 2008 19:25:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 83A2025047; Thu, 10 Jul 2008 19:25:37 -0400 (EDT)
In-Reply-To: <48768F30.8070409@etek.chalmers.se> (Lukas =?utf-8?Q?Sandstr?=
 =?utf-8?Q?=C3=B6m's?= message of "Fri, 11 Jul 2008 00:37:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 827C4426-4ED7-11DD-AA1A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88055>

Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:

> I'm currently working on rewriting git-mailinfo to use strbuf's inste=
d
> of the preallocated buffers currently used. Do you want me to send a
> patch allocating hdr_data[i], or can you wait for my strbuf-conversio=
n
> patch? It'll propably be ready for review tonight.

Heh, after getting burned by that NUL thingy, I was waiting for somebod=
y
to step up.  Thanks.
