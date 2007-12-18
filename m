From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 14:22:45 -0800
Message-ID: <7vabo7y762.fsf@gitster.siamese.dyndns.org>
References: <20071217110322.GH14889@albany.tokkee.org>
	<506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
	<7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
	<57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
	<7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
	<20071218154211.GB12549@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4kqW-0003BO-Pw
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbXLRWXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 17:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755660AbXLRWXH
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:23:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628AbXLRWXG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 17:23:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 07A7B56F5;
	Tue, 18 Dec 2007 17:23:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 21B3656EE;
	Tue, 18 Dec 2007 17:22:53 -0500 (EST)
In-Reply-To: <20071218154211.GB12549@alea.gnuu.de> (=?utf-8?Q?J=C3=B6rg?=
 Sommer's message of
	"Tue, 18 Dec 2007 16:42:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68833>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> When it should go quick why don't use an alias. git stash can print t=
he
> list and everyone who wants a quick stash can create an alias for thi=
s.

You are taking this completely backwards.  The stash mechanism is all
about creating a quickie temporary pair of commits.  Anybody who wants
otherwise can use alias or choose not to use stash at all.
