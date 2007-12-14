From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Funky] "git -p cmd" inside a bare repository
Date: Fri, 14 Dec 2007 12:18:58 -0800
Message-ID: <7vejdpqbbh.fsf@gitster.siamese.dyndns.org>
References: <20071129122139.GA11176@laptop>
	<7vmysexdvw.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712141943280.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 14 21:19:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3H0R-0005qY-5S
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 21:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342AbXLNUTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 15:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753704AbXLNUTN
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 15:19:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbXLNUTM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 15:19:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DA07D9250;
	Fri, 14 Dec 2007 15:19:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 62CA9924C;
	Fri, 14 Dec 2007 15:19:02 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712141943280.27959@racer.site> (Johannes
	Schindelin's message of "Fri, 14 Dec 2007 19:44:10 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68338>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I have no time left to work on git for a few days, so I cannot even r=
eview=20
> your patch.  But Jeff's patch being smaller, I could, and AFAICT it s=
olves=20
> the problem.

We have more than a few days ;-) Hope you are feeling better now.

You got familialized yourself with the work-tree part because the
initial round was so broken and you had to step in during the last roun=
d
(unfortuantely ;-), and Nguy=E1=BB=85n also is familiar with that part =
of the
code.  It would be nice if we can have a proper fix that is not paperin=
g
over deeper breakage.
