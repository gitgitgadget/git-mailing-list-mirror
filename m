From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] builtin-commit: fix author date with --amend --author=<author>
Date: Mon, 12 Nov 2007 16:37:37 -0800
Message-ID: <7v8x530ylq.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
	<Pine.LNX.4.64.0711111735100.4362@racer.site>
	<1194896334.2869.7.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 01:38:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irjn4-0006FY-JY
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 01:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbXKMAhu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 19:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbXKMAhu
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 19:37:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55277 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbXKMAhu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 19:37:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DF57A2F2;
	Mon, 12 Nov 2007 19:38:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 67B3D951CB;
	Mon, 12 Nov 2007 19:38:06 -0500 (EST)
In-Reply-To: <1194896334.2869.7.camel@hinata.boston.redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Mon, 12 Nov 2007 14:38:54 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64739>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> I suggest we back this patch out.

Ok.  My mistake.  Your "Add testcase for amending and fixing
author in git commit" does contain test for this.

I need to amend the commit log message of that one, though ;-)
