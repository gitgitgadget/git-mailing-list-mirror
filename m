From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/13] Don't append default merge message to -m message
Date: Mon, 21 Apr 2008 22:27:32 -0700
Message-ID: <7vej8y792z.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <7v7iescvu7.fsf@gitster.siamese.dyndns.org>
 <20080421001726.GA13639@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 07:28:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoB3Y-000644-62
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 07:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbYDVF1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Apr 2008 01:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbYDVF1v
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 01:27:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbYDVF1v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2008 01:27:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4AB8529ED;
	Tue, 22 Apr 2008 01:27:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 824E329E5; Tue, 22 Apr 2008 01:27:44 -0400 (EDT)
In-Reply-To: <20080421001726.GA13639@alea.gnuu.de> (=?utf-8?Q?J=C3=B6rg?=
 Sommer's message of "Mon, 21 Apr 2008 02:17:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80059>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> ... But I doubt someone expects this behaviour
> because the manpage says:
>
>   The second syntax (<msg> HEAD <remote>) is supported for historical
>   reasons. Do not use it from the command line or in new scripts. It =
is
>   the same as git merge -m <msg> <remote>.
>       ^^^^              ^^
>
> Currently, it's not the same, but someone might expect it.

Yeah, the manpage is loosely written and does not reflect the reality. =
 I
am _VERY_ tempted to apply your change as-is and see if anybody screams=
=2E
Because git is designed to be very scriptable, people who want the curr=
ent
behaviour can still call fmt-merge-msg themselves.
