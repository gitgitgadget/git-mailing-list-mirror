From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Mon, 17 Dec 2007 21:01:49 -0800
Message-ID: <7vlk7s38aq.fsf@gitster.siamese.dyndns.org>
References: <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
	<20071215004230.GF7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
	<20071217200920.GB19816@mail.oracle.com>
	<alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
	<7v3au16myj.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999999.0712171641460.8467@xanadu.home>
	<7vbq8o4yxc.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999999.0712172212110.8467@xanadu.home>
	<46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Joel Becker" <Joel.Becker@oracle.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 06:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4UbD-000580-0B
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 06:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbXLRFCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 00:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbXLRFCM
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 00:02:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbXLRFCL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 00:02:11 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BB97943BF;
	Tue, 18 Dec 2007 00:02:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E82C943BE;
	Tue, 18 Dec 2007 00:01:55 -0500 (EST)
In-Reply-To: <46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 18 Dec 2007 16:52:22 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68698>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> If cvs 1.11 doesn't talk with 1.12 I'll say there are nuts - minor
> revisions should interoperate with end users not even thinking about
> it. But 1.5.5 has in its changelog lots of deprecations and interop
> changes.
>
> It's not good communication to label it 1.5.5.

There indeed are handful scheduled removals.  I do not mind declaring
that 1.6.0 comes after 1.5.4, or just relabel the removal schedule for
1.6.0 and keep the scheduled change on hold a bit longer.

By the way, I'd appreciate an Ack or comment on the recent pserver
authentication enhancements in c934dca22ee07cb3ca146a249bdb73ab0f30b2b1
(Authentication support for pserver); I do not mind merging this in
1.5.4 as the change is fairly isolated and should not affect people who
do not use the feature.
